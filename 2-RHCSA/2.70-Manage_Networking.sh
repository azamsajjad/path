7-Manage basic networking
Configure IPv4 and IPv6 addresses
Configure hostname resolution
Configure network services to start automatically at boot
Restrict network access using firewall-cmd/firewall

[root@x230 ~]# cd /etc/sysconfig/network-scripts/
[root@x230 network-scripts]# ls
readme-ifcfg-rh.txt
[root@x230 network-scripts]# cat readme-ifcfg-rh.txt
NetworkManager stores new network profiles in keyfile format in the
/etc/NetworkManager/system-connections/ directory.

Previously, NetworkManager stored network profiles in ifcfg format
in this directory (/etc/sysconfig/network-scripts/). However, the ifcfg
format is deprecated. By default, NetworkManager no longer creates
new profiles in this format.

Connection profiles in keyfile format have many benefits. For example,
this format is INI file-based and can easily be parsed and generated.

Each section in NetworkManager keyfiles corresponds to a NetworkManager
setting name as described in the nm-settings(5) and nm-settings-keyfile(5)
man pages. Each key-value-pair in a section is one of the properties
listed in the settings specification of the man page.

If you still use network profiles in ifcfg format, consider migrating
them to keyfile format. To migrate all profiles at once, enter:

# nmcli connection migrate

This command migrates all profiles from ifcfg format to keyfile
format and stores them in /etc/NetworkManager/system-connections/.

Alternatively, to migrate only a specific profile, enter:

# nmcli connection migrate <profile_name|UUID|D-Bus_path>

For further details, see:
* nm-settings-keyfile(5)
* nmcli(1)
[root@x230 network-scripts]# cd /etc/NetworkManager/
[root@x230 NetworkManager]# ls
conf.d  dispatcher.d  dnsmasq.d  dnsmasq-shared.d  NetworkManager.conf  system-connections
[root@x230 NetworkManager]# cd system-connections/
[root@x230 system-connections]# ls
4th-Reich.nmconnection  enp0s25.nmconnection  mycon.nmconnectioncat 4   


SCAN ALL DEVICES IN YOUR LAN
yum install nmap
nmap -sn 192.168.100.0/24
nmcli c s enp0s25
netstat -rn
# ip addr del 192.168.100.100/24 dev enp0s26

# nmcli radio wifi off
# nmcli radio
WIFI-HW  WIFI      WWAN-HW  WWAN    
enabled  disabled  enabled  enabled

# attach a device to connection
nmcli con modify enp0s26 connection.autoconnect yes
nmcli con modify enp0s26 connection.interface-name enp0s25
systemctl restart NetworkManager
systemctl restart sshd

# nmcli con mod enp0s26 ipv4.method "manual" ip4 "192.168.100.100/24" ipv4.dns "192.168.100.1,8.8.8.8" ipv4.gateway "192.168.100.1" ipv4.may-fail "no"
# nmcli con mod enp0s26 ipv6.method "manual" ip6 "2407:aa80:314:d851::7/128" ipv4.may-fail "yes"

CHECK BOTH CONNECTIONS ARE UP
root@server1: ~ # { ip a s eth0 ; ip a s eth1 ; } | grep inet\
    inet 10.0.1.188/24 brd 10.0.1.255 scope global dynamic noprefixroute eth0
    inet 10.0.1.21/24 brd 10.0.1.255 scope global noprefixroute eth1
root@server1: ~ # ping -I 10.0.1.188 10.0.1.21
root@server1: ~ # ping -I 10.0.1.21 10.0.1.188

You'll be using utilities such as nmcli, ip, vim, ifup, ping, and dig in this lab, and encountering files such as /etc/sysconfig/network-scripts/ifcfg-eth0, 
# the /etc/hosts, /etc/resolv.conf, and /etc/nsswitch.conf files, and more as you troubleshoot why you cannot get accurate information about a remote domain's DNS.
# TRINITY DNS RESOLUTION FILES

CHECK IF YOUR NETWORKS WILL COME BACK UP ON BOOT
systemctl status NETworkManager
grep autoconnect /etc/Networkmanager/sys

LAB
$ hostnamectl
HOSTNAME RESOLUTION
        yum whatprovides dig
    3  sudo yum install bind-utils
    4  ping linux.com
    5  cat /etc/resolv.conf
    7  dig @10.0.0.2 linux.com
    9  vim /etc/nsswitch.conf (changed hosts: files dns myhostname to dns files myhostname)
   10  ping linux.com
   11  vim /etc/hosts (removed wrong entry)
   12  ping linux.com
   now it pings to right address
   13  vim /etc/nsswitch.conf
   14  ping linux.com


   NETWORKING question RHEL9
   create a new connection named Net of type Ethernet having interface name eth0
   ip ares 200.0.0.12/16
   gateway 20.0.0.1
   dns 8.8.8.8
   --------------------------------------------------------------------------
   nmcli con add con-name Net type ethernet ifname eth0 ip4 200..0.12/16 gw4 20.0.0.1
   nmcli con mod Net ipv4.dns 8.8.8.8
   (cant edit dns while nmcli con add)
   nmcli con up
   PArameters to take care of while adding connection
   con-name | type | ifname | autoconnect | ap4 | gw4
   if it asks to add another address
   nmcli con mod Net +ipv4.addresses 200.0.0.13/16


succesffuly resolve to server1.example.com when your DNS is 192.168.....
/etc/resolv.conf
ALL DNS entries are saved in this file

first add a device
# nmcli con add type ethernet con-name ens224 ifname ens224 ipv4.addresses 192.168.171.171 ipv4.dns 192.168.171.2,8.8.8.8 ipv4.gateway 192.171.171.2 ipv4.method manual
nmcli connection reload















MANGER ASK TO CREATE 3 SUBNETS FOR A COFFEE SHOP. 1 FOR OFFICE, 1 FOR FRONT DESk, 1 FOR CUSTOMERS. 

SO WE WILL SELECT 4TH COLUMS AND CREATE 4 SUBNETS, 1 WILL BE WASTED
original subnet was /24, means subnet 1
to get 3or4 subnet we multiple 1 with 4 so we select 3rd column 

ORIGINAL NETWORK ID = 192.168.4.0/24
                           |-----|
SUBNET           1     2   | 4   |  8     16     32   64    128    256
HOST            256   128  | 64  |   32    16     8     4     2      1
SUBNET MASK     /24   /25  | /26 |  /27   /28   /29   /30   /31    /32
                           |_____|
---------------------------------------------------------------------
start with default Net id                           64-2=62 from table
NETWORK ID      SUBNET      USABLE IPs RANGE        No.OF_IPs   BROADCAST IP    
192.168.4.0     /26     192.168.4.1---192.168.4.62     62   192.168.4.63
192.168.4.64    /26    192.168.4.65---192.168.4.127    62   192.168.4.127
192.168.4.128   /26   192.168.4.129---192.168.4.192    62   192.168.4.191
192.168.4.192   /26   192.168.4.193---192.168.4.254    62   192.168.4.255