yum install httpd
vim /etc/httpd/conf/httpd.conf
chown apache:apache /contents
chown apache:apache index.html
curl localhost/index.html
ACCESS DENIED
setenforce 0
curl localhost/index.html
ACCESS 
setenforce 1
ls -lZ /var/www shows httpd_sys_content_t as context
2 ways to change it for /contents
chcon -t httpd_sys_content_t index.html
or
semanage fcontext -a -t httpd_sys_content_t '/content(/.*)?'
restorecon -R /content
ls -ldZ
curl -k 192.168.100.34


nmap lists all servers
nmap -sP 192.168.100.0/24

curl ifconfig.me
curl ipinfo.io/ip
to view public ip addresses
[root@x230 ~]# curl https://ipinfo.io/119.73.124.90
{
  "ip": "119.73.124.90",
  "hostname": "static-host119-73-124-90.link.net.pk",
  "city": "Rawalpindi",
  "region": "Punjab",
  "country": "PK",
  "loc": "33.5817,73.1636",
  "org": "AS135407 Trans World Enterprise Services (Private) Limited",
  "postal": "45710",
  "timezone": "Asia/Karachi",
  "readme": "https://ipinfo.io/missingauth"



  FTP 
  SERVER 
  yum install vsftpd
  282  vim /etc/vsftpd/vsftpd.conf 
  283  systemctl enable --now vsftpd
  284  journalctl -exu vsftpd
  285  vim /etc/vsftpd/vsftpd.conf 
  286  systemctl enable --now vsftpd
  287  firewall-cmd --add-pot=21/tcp --add-port=3000-3100/tcp --permanent
  288  firewall-cmd --add-port=21/tcp --add-port=3000-3100/tcp --permanent
  289  systemctl restart firewalld
  290  setsebool -h
  291  setsebool --help
  292  man sebool
  293  man setsebool
  294  setsebool list
  295  getsebool 
  296  getsebool -a
  297  semanage port -l | grep ftp
  298  semanage fcontext -l
  299  semanage fcontext -l | grep http
  300  semanage fcontext -l | grep http | less
  301  setsebool -a | grep ftp
  302  getsebool -a | grep ftp
  303  setsebool -p ftpd_full_access on
  304  setsebool -P ftpd_full_access on
  305  vim /etc/vsftpd/vsftpd.conf 
  306  systemctl restart vsftpd.
  307  systemctl restart vsftpd
  334  vim /etc/vsftpd/vsftpd.conf
  335  vim /etc/hosts.allow
  336  vim /etc/hosts.deny
  337  vim /etc/hosts.allow
  338  systemctl restart vsftpd
  339  vim /etc/hosts.allow
  340  ls -alh /var/ftp
  341  ls -alh /var
  342  vim /etc/hosts.allow
  343  vim /etc/hosts.deny
  344  vim /etc/vsftpd/vsftpd.conf
  345  systemctl restart vsftpd
  346  chown -R 775 /var/ftp/
  347  ll /var
  348  setenforce 0
  349  sysctemctl restart vsftpd
  350  systemctl restart vsftpd
  351  setenforce 1
  352  setsebool -P ftpd_anon_write 1
  353  getsebool -a | grep ftp
  354  systemctl restart vsftpd
  355  vim /etc/vsftpd/vsftpd.conf
  356  systemctl restart vsftpd
  357  history


CLIENT 
yum install -y lftp
vim /etc/hosts
lftp server1

ftp commands
ls - list file of server
!ls - list local files
mirror - download/sync all files
mirror -R - upload all files
get - download a single file
put - upload single file


http -t
syntax ok



"**************************************************************"
---
- hosts: webservers
  become: yes
  vars_files:
    - /home/ansible/secret
  tasks:
  - name: install apache
    yum: name=httpd state=latest
  - name: configure httpd as necessary
    template:
      src: /home/ansible/assets/httpd.conf.j2
      dest: /etc/httpd/conf/httpd.conf
  - name: create secure directory
    file: state=directory path=/var/www/html/secure mode=0755
  - name: deploy htaccess file
    template:
      src: /home/ansible/assets/htaccess.j2
      dest: /var/www/html/secure/.htaccess
  - name: make sure passlib is installed for htpasswd module
    yum: name=python-passlib state=latest
  - name: create users for basic auth
    htpasswd:
      path: /var/www/html/secure/.passwdfile
      name: "{{ secure_user }}"
      password: "{{ secure_password }}"
      crypt_scheme: md5_crypt
  - name: start and enable apache
    service: name=httpd state=started enabled=yes
  - name: install secure files
    copy:
      src: /home/ansible/assets/classified.html
      dest: /var/www/html/secure/classified.html