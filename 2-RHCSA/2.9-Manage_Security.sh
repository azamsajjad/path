9-Manage security
Configure firewall settings using firewall-cmd/firewalld
Manage default file permissions
Configure key-based authentication for SSH
Set enforcing and permissive modes for SELinux
List and identify SELinux file and process context
Restore default file contexts
Manage SELinux port labels
Use boolean settings to modify system SELinux settings
Diagnose and address routine SELinux policy violations


semanage port -l ----> command not found
yum install policycoreutils*




firewall-cmd --help --reload --permanent --add-port 82/tcp --add-service mysql
nmap -A 192.168.100.193
nmap -sn 192.168.100.0/24

1st highlight for default files, 2nd for old files
[root@x230 home]# setfacl -Rm d:g:engineers:rwx,g:engineers:rwx /home/shared_docs/
[root@x230 home]# setfacl -Rm d:u:faizi:rx,u:faizi:rx /home/shared_docs/
[root@x230 home]# getfacl /home/shared_docs/
getfacl: Removing leading '/' from absolute path names
# file: home/shared_docs/
# owner: root
# group: engineers
# flags: -st
user::rwx
user:faizi:r-x
group::rwx
group:engineers:rwx
mask::rwx
other::---
default:user::rwx
default:user:faizi:r-x
default:group::rwx
default:group:engineers:rwx
default:mask::rwx
default:other::---
.?
   13  sed -i -e 's/AllowZoneDrifting=yes/AllowZoneDrifting=no/' /etc/firewalld/firewalld.conf
   14  grep '^AllowZone' /etc/firewalld/firewalld.conf
   15  systemctl reload firewalld
   16  firewall-cmd --zone=public --add-service=http --permanent
   17  firewall-cmd --zone=public --add-service=https --permanent
   18  firewall-cmd --zone=public --add-service=https
   19  firewall-cmd --zone=public --add-service=http


   ACL
   cd ~
    2  cd /opt/ProjectA
    3  ll
    4  getfacl /opt/ProjectA/
    5  ls -ld /opt/ProjectA/
    6  groups mortimer
   6.  setfacl -m u:clarice:rwx /opt/ProjectA/
   6.  setfacl -m u:caruso:rwx /opt/ProjectA/
    7  setfacl -m g:managers:rwx /opt/ProjectA/
    8  getfacl /opt/ProjectA/
    9  su clarice
   10  cd /opt/ProjectA/
   11  ll
   12  groups caruso
   13  getfacl -R /opt/ProjectA/ > ~/ProjectA.acl.bu
   14  cat ~/ProjectA.acl.bu
   18  getfacl -R /opt/ProjectA/ > ~/ProjectA.acl.bu
   19  cat ~/ProjectA.acl.bu
   20  grep caruso ~/ProjectA.acl.bu
   21  setfacl -m u:caruso:0 /opt/ProjectA/
   22  getfacl -R /opt/ProjectA/
   23  getfacl /opt/ProjectA/
   24  head ~/ProjectA.acl.bu
   25  cd /
   26  getfacl /opt/ProjectA/
   27  setfacl --restore=~/ProjectA.acl.bu ----------------->error
   28  setfacl --restore=/home/mortimer/ProjectA.acl.bu
   29  getfacl /opt/ProjectA/
   ---------->caruso permissions restored


   FIX APACHE SELINUX POLICY AND CONTEXT ISSUE
   
    3  grep httpd /var/log/messages
    4  journalctl -xe  ----->suggested when we ran systemctl start httpd
    4  journalctl -u httpd
    4 grep httpd /var/log/audit/audit.log
    5  ausearch -c 'httpd' --raw | audit2allow -M my-httpdpol ---->suggested by journalctl
    6  ls -al my-httpdpol.*
    7  file my-httpdpol.*
    8  semodule -i my-httpdpol.pp 
    9  systemctl start httpd
   10  systemctl status httpd
   14  curl localhost:85/test.html
   15  curl http://127.0.0.1:85/test.html
   16  grep 'httpd\|test.html' /var/log/messages
   17  grep 'httpd\|test.html' /var/log/messages | more
   18  grep 'httpd\|test.html' /var/log/messages
   19  grep 'httpd\|test.html' /var/log/messages | less
   20  ls -lZ /web
   21  semanage --help
   22  man semanage
   23  info semanage
   24  info semanage f-context
   25  ls -ldZ /var/www
   26  semanage fcontext -a -t httpd_sys_content_t "/web(/.*)?"
   27  restorecon -Rv /web
   28  ls -lZ /web
   31  curl localhost:85/test.html
   32  systemctl restart httpd
      32  systemctl restart httpd
         32  systemctl restart httpd
   33  tail -30 /var/log/messages



4 TYPES of Questions on SELinux on RHEL9 exam
SELinux MODES
getenforce | setenforce 0 for permissive | setenforce 1 for enforcing
if they ask you to disable SELinux policy
vim /etc/sysconfig/selinux --> SELINUX=disabled 
SELinux BOOLEANS
ensure httpd is able to access user home directory
getsebool -a  ---> list all the BOOLEANS
getsebool -a | grep httpd
setsebool -p httpd_enable_homedirs on
SELinux PORT 
system is not able to connect to httpd at port 82
semanage port -l --> list all ports
semanage port -a -t http_port_t -p tcp 82
SELinux CONTEXT
semanage fcontext -l
httpd service is able to access & host files from /test directory
ls -lZ /test
semanage fcontext -a -t httpd_sys_content_t "/test(/.*)?"
restorecon -R /test
/etc/httpd/conf/httpd.conf
DocumentRoot "/var/ww/httml" ---> "/test"
<Directory "/var/www/html" ---> "/test"
systemctl restart httpd
restorecon -R 



FIREWALL ZONES
/usr/lib/firewalld/zones/home.xml 
firewall-cmd --permanent --new-zone=myoffice
firewall-cmd --get-zones
firewall-cmd --get-active-zones
firewall-cmd --get-services
firewall-cmd --zone=public --list-services/ports
firewall-cmd --zone=dmz --list-services
firewall-cmd --zone=home --list-services ---> list all services firewall understands in a zone
firewall-cmd --reload
firewall-cmd --zone=public --remove-service=http 
firewall-cmd --zone=public --remove-port=9000/tcp 
firewall-cmd --zone=public --change-interface=ens224  --->do this for quick work ,then return back to restricted zone
firewall-cmd --get-active-zones
home
   interface: ens160 (nic)
public
   interface: ens224 (nic)

FIREWALL SCRIPTS
how firewall knows which service use which port?
/usr/lib/firewalld/services ---> script files -- http.xml / ftp.xml
when you use a script, new configuration saves in /usr/lib/f/services directory
/etc/firewalld
how to define a custom service
cp /usr/lib/f/services/ssh.xml /etc/firewalld/services/example.xml
vim example.com 
         <?xml version="1.0" encoding="utf-8"?>
         <service>
            <short>SSH</short>
            <description>Secure Shell (SSH) is a protocol for logging into and executing commands on remote machines. It provides secure encrypted communications. If you plan on accessing your machine remotely via SSH over a firewalled interface, enable this option. You need the openssh-server package installed for this option to be useful.</description>
            <port protocol="tcp" port="22"/>
         </service>
edit example.com 
         <?xml version="1.0" encoding="utf-8"?>
         <service>
            <short>example</short>
            <description>example is a protocol for logging into and executing commands on remote machines. It provides secure encrypted communications. If you plan on accessing your machine remotely via SSH over a firewalled interface, enable this option. You need the openssh-server package installed for this option to be useful.</description>
            <port protocol="tcp" port="7777"/>
         </service>
firewall-cmd --reload
firewall-cmd --get-services | grep example

FIREWALL MASQUERADING
firewall-cmd --zone=public --add-forward-port=port=80:proto=tcp:toport=8080 --permanent
--reload
firewall-cmd --list-forward-ports
firewall-cmd --zone=public --remove-forward-port=port=80:proto=tcp:toport=8080 --permanent
-------------------------------------------
firewall-cmd --zone=public --add-masquerade 
firewall-cmd --zone=public --add-forward-port=port=80:proto=tcp:toport=8080:toaddr=192.168.100.99 --permanent

FIREWALL RICH RULES
only accept ssh on port 22 from 1 ip address
solution - RICH RULES                  --remove 
firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv4" source address="10.0.8.8" port port=22 protocol=tcp accept'
firewall-cmd --list-rich-rules --permanent

