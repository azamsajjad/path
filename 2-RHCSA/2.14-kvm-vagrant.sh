grep -e 'vmx' /proc/cpuinfo   /svm for AMD
lsmod | grep kvm 
dnf install cockpit cockpit.socket
systemctl enable --now cockpit.socket
firewall-cmd --add-service=cockpit -- permanent
firewall-cmd --Reload

BRIDGE NETWORKING

# nmcli con add con-name nm-bridge ifname nm-bridge type bridge autoconnect yes ipv4.method auto ipv6.method auto
# nmcli con add con-name nm-bridge-port ifname eth0 type ethernet slave-type bridge master br0 autoconnect yes
another manual way of setting upbridge networking for VMs
[root@x230 ~]# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    425    0        0 nm-bridge
192.168.100.0   0.0.0.0         255.255.255.0   U     425    0        0 nm-bridge
192.168.122.0   0.0.0.0         255.255.255.0   U     0      0        0 virbr0
traffic goes from bottom to up

virsh net-destroy default
virsh net-list
virsh shutdown vmserver
ip a s 
#bring down ethernet interface and get rid of its ip
ip link set enp0s25 down 
ip addr del 192.168.100.100/24 dev enp0s25
ip a s 
systemctl stop NetworkManager
systemctl stop systemd-networkd (it will used when we automate all this eventually)
#making of a bridge device
ip link add name br0 type bridge
ip link set enp0s25 master br0
ip addr add 192.168.100.100/24 dev br0 brd 192.168.100.255
now our device are ready to be UP 
ip link set up enp0s25
ip link set up br0
from 102 --> $ arping 192.168.100.103 -I eth0
returns ip with mac address, means we can resolve this host from 102
"VM is now visible on LAN, but no internet connectivity because gateway is not defined"
[root@x230 ~]# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.100.0   0.0.0.0         255.255.255.0   U     425    0        0 br0
traffic goes from bottom to up
[root@x230 ~] route add default gw 192.168.100.1
[root@x230 ~]# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         _gateway        0.0.0.0         UG    425    0        0 br0
192.168.100.0   0.0.0.0         255.255.255.0   U     425    0        0 br0
traffic goes from bottom to up


"********************************************************************"
dnf module install virt
dnf install virt-viewer virt-install
dnf install qemu qemu-kvm libvirt-daemon("to create VMs") libvirt-clients("for virsh") bridge-utils("bridge networking") virt-manager
systemctl status libvirtd.service 
Create a virtual machine from the command line
We are going to install a Debian virtual machine using a Debian 11 iso image located in the Downloads folder in the home directory.

To create the new virtual machine, we will run the following command.

$ sudo virt-install 
--name=vm \
--os-type=Linux \
--os-variant=debian9 \
--vcpu=2 \
--ram=2048 \
--disk path=/var/lib/libvirt/images/Debian.img,size=15 \
--graphics spice \
--location=/home/james/Downloads/debian-11.1.0-amd64-DVD-1.iso \
--network bridge:virbr0


#!/bin/bash
virt-install \
--name x230U \
--ram 1048 \
--disk path=/home/rupert/Downloads/ubuntu-22.qcow2,size=8 \
--vcpus 2 \
--os-type linux \
--os-variant generic \
--console pty,target_type=serial \
--bridge=br0
--cdrom /home/rupert/Downloads/ubuntu-22.04.2-desktop-amd64.iso


or THROUGH virt-manager
Network source -> Bridge devices
Device Name -> nm-bridge
Device model -> virtio

virsh shutdown vm_name
virsh start vm_name
virsh list --all
virsh list
virsh reboot vm_name
virsh destroy vm_name
virsh undefine --domain debian-vm --remove-all-storage


504  sudo vim  /etc/libvirt/libvirtd.conf
505  sudo vim /etc/libvirt/qemu.conf
506  virt-manager

'''
Configuration
To use as a normal user without root we need to configure KVM, this will also enable the libvirt networking components.

Set the UNIX domain socket ownership to libvirt and the UNIX socket permission to read and write.

/etc/libvirt/libvirtd.conf
...
unix_sock_group = 'libvirt'
...
unix_sock_rw_perms = '0770'
...
Add your user to the libvirt user group.

Add your user to /etc/libvirt/qemu.conf. Otherwise, QEMU will give a permission denied error when trying to access local drives.

Search for user = "libvirt-qemu" or group = "libvirt-qemu", uncomment both entries and change libvirt-qemu to your user name or ID. Once edited it should look something like below.

/etc/libvirt/qemu.conf
# Some examples of valid values are:
#
#       user = "qemu"   # A user named "qemu"
#       user = "+0"     # Super user (uid=0)
#       user = "100"    # A user named "100" or a user with uid=100
#
user = "username"

# The group for QEMU processes run by the system instance. It can be
# specified in a similar way to user.
group = "username"
Upon opening Virt-Manager, it will default to the system variant (root) of the QEMU connection.

This can be changed to the user connection by going to: File > Add Connection.

Now select QEMU/KVM User session as the Hypervisor and click OK. This will now auto-connect to the user session. You can now disconnect and remove the system connection if desired.
'''
VIRT-MANAGER
connect --> QEMU user-session

[rupert@x230 ~]$ sysctl net.ipv4.ip_forward
net.ipv4.ip_forward = 1



"*********************************************************"
INSTALL VIRTUALBOX
lscpu | grep -i virtualization
#install dependencies
#Step 2: Enable EPEL Repo in RHEL
$ sudo dnf install binutils kernel-devel kernel-headers libgomp make patch gcc glibc-headers glibc-devel dkms -y


#add repo
sudo dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo
#import gpg key
rpm --import https://www.virtualbox.org/download/oracle_vbox.asc
#OR
# [virtualbox]
# name=Oracle Linux / RHEL / CentOS-$releasever / $basearch - VirtualBox
# baseurl=http://download.virtualbox.org/virtualbox/rpm/el/$releasever/$basearch
# enabled=1
# gpgcheck=1
# repo_gpgcheck=1
# gpgkey=https://www.virtualbox.org/download/oracle_vbox_2016.asc


dnf install VirtualBox-7.1 -y

#Be sure to add the logged-in user to the vboxusers group using the following commands.
$ sudo usermod -aG vboxusers $USER
$ newgrp vboxusers

#To install the VirtualBox Extension Pack, visit the official Virtualbox downloads page. Similarly, you can download the extension pack using the wget command as shown.

$ wget https://download.virtualbox.org/virtualbox/7.0.2/Oracle_VM_VirtualBox_Extension_Pack-7.0.2.vbox-extpack

sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.0.2.vbox-extpack

#finally
sudo /sbin/vboxconfig
#if error This system is currently not set up to build kernel modules. Please install the Linux kernel "header" files matching the current kernel for adding new hardware support to the system.
uname -r
yum install -y kernel-devel-$(uname -r)
sudo /sbin/vboxconfig

vagrant up
[ansible@x230 vagrant]$ vboxmanage startvm 21744d62-4f4f-4787-a5f4-9b4f2fa9b9b0 --type emergencystop
[ansible@x230 vagrant]$ VBoxManage unregistervm 21744d62-4f4f-4787-a5f4-9b4f2fa9b9b0       

"******************************************************"

VAGRANT - goto website hashicorp-
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install vagrant

Install Vagrant VMware Utility - download from website

yum group-install "Development Tools"
https://app.vagrantup.com/boxes/search (Search boxes)

