8-Manage users and groups
Create, delete, and modify local user accounts
Change passwords and adjust password aging for local user accounts
Create, delete, and modify local groups and group memberships
Configure superuser access

grep '^[A-Z] /etc/login.defs (see default login settings)
useradd -D (see default useradd setting)


set +o history (dnt record next command)
echo "$user:linux" | chpasswd
set -o history

passwd -S reason (password info)
passwd -e reason (set dummy password , user will change it after 1st login)
vim /etc/login.defs to change new users password settings


for admins
chage -l username
chage -d 0 username (passwd expired and now user create new pass at next login)

files created in etc/skel/ directory are automatically copid in new user home directory
.
new files must be owned by group owner
set gid
chmod g+s /UK
drwxrws---.
.
only the file creator can delete their own file
set sticky bit
chmod +t /UK
.
echo "echo this is rupert\'s script\!" > rupertscript.sh
[rupert@x230 shared_docs]$ ./rupertscript.sh
chmod ug+x rupertscript.sh
.
 1013  chown -R :engineers /home/shared_docs/
 1014  ll
 1015  chmod -R 770 /home/shared_docs/
 1016  ll
 1017  chmod g+s /home/shared_docs/
 1018  ll
 1019  chmod +t /home/shared_docs/

groudmod -n dba_managers it_managers
new group name dba_managers

useradd -m -G dba_managers,dba_staff jack
-m = create home directory

for user in rupert reason azam hassan faizi ; do echo "Password aging for "$user"" ; chage -l $user |
grep number ; echo ; done | less
chage rupert
chage reason
or 
for user in rupert reason azam hassan faizi ; do echo "Adjust Password aging for "$user"" ; chage -m 15 -M 90 $user ; echo ; done | less

chage -E $(date -d +1day +%Y-%m-%d) db_user
for user in azam hassan faizi contsvc ; do echo "Setting Password for "$user"..." ; usermod -p $(openssl passwd r4g4554g) $user ; done


SUDOers
visudo /etc/sudoers

ACTIVATE BY removing #
## Processes
# Cmnd_Alias PROCESSES = /bin/nice, /bin/kill, /usr/bin/kill, /usr/bin/killall
## messages
OR ADD a LINE
# Cmnd_Alias MESSAGES = /bin/tail -f /var/log/messages

%wheel  ALL=(ALL)       ALL
%engineers      ALL=SOFTWARE, SERVICES, PROCESSES
#%dba_intern    ALL=MESSAGES


LAB
sudo visudo
allow a user to have admin previleges
## User Aliases
## These aren't often necessary, as you can use regular groups
## (ie, from files, LDAP, NIS, etc) in this file - just use %groupname
## rather than USERALIAS
# User_Alias ADMINS = jsmith, mikem
User_Alias      ADMINUSERS = sajjad
.
## Command Aliases
## These are groups of related commands...
Cmnd_Alias      ADMINTASKS = /usr/sbin/useradd, /bin/passwd, sudoedit /etc/hosts
.
.
## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
ADMINUSERS      ALL=ADMINTASKS
.
.
.
use --> which useradd <-- command to see paths

PASSWORD
echo "dbapass" | passwd --stdin manny

for user in manny moe jack ; do echo "creating "$user..." ; useradd -m $user ; done
for user in manny moe jack ; do echo "setting passwords for "$user..." ; usermod -p $(openssl passwd -1 dbapass) $user ; done
for user in manny moe jack ; do echo "setting group permissions for "$user..." ; chgrp -R $user /home/$user ; done


chown -R :dba_staff /home/dba_docs/
root@server2: ~ # chmod 770 /home/dba_docs/
root@server2: ~ # chmod g+s /home/dba_docs/
root@server2: ~ # chmod o+t /home/dba_docs/
root@server2: ~ # setfacl -Rm d:g:dba_staff:rwx,g:dba_staff:rwx /home/dba_docs/
root@server2: ~ # setfacl -Rm d:u:jack:r--,u:jack:r-- /home/dba_docs/
root@server2: ~ # setfacl -Rm d:u:cindy:r--,u:cindy:r-- /home/dba_docs/
root@server2: ~ # setfacl -Rm d:u:marcia:rwx,u:marcia:rwx /home/dba_docs/
root@server2: ~ # stat /home/dba_docs/
for user in manny moe cindy jack jan marcia ; do ln -s /home/dba_docs/ /home/$user/dba_docs ; done


SET UID - allows a file being executed to run with previleges of owner
SET GID - allows a file to be executed with the authority of file's group
STICKY BIT - only root, dir owner & owner of file can remove files in that dir

for i in azam hassan faizi ; do useradd -m -G marketing $i ; done
mmkdir /home/marketing
chown -R :marketing /home/marketing
chmod -R 770 /home/marketing
stat /home/marketing

