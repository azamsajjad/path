write root (to send a message)
wall "hello" (send message to all users by root) -n to suppress
who (see who is logged in)
w (see who is active)


to access server2 from server1
[server1] ssh-keygen
[server1] ssh-copy-id [ip of server2]
[server1] scp user@server2:/~/*.gz . (dot means put it in current directory)
#if we dont know the location, we can sftp
[server1] sftp user@server2
sftp> ? to see commands
> navigate into folders and run
> mget *.gz 
> quit
got those dumps in [server1] home directory



shh key for github
 ll /c/Users/T480/.ssh
  157  chmod 0700 .ssh
  158  chmod 0700 /c/Users/T480/.ssh
  160  cd /c/Users/T480/.ssh
  161  ssh-keygen -t rsa -b 4096 -C "user@gmail.com"
  162  cat id_rsa.pub
  163  cd /d/rhcsa/
  164  git push -u origin main



-r is used for directory
scp -r /home/cloud_user/server1/ cloud_user@44.202.76.13:/home/cloud_user/

scp /home/cloud_user/final.txt cloud_user@44.203.210.185:~/

cloud_user@server2: ~ $ ssh -t cloud_user@18.234.181.169 free >> server_health.txt
Connection to 18.234.181.169 closed.
cloud_user@server2: ~ $ ssh -t cloud_user@18.234.181.169 df -hT >> server_health.txt
Connection to 18.234.181.169 closed..
cloud_user@server2: ~ $ ssh -t cloud_user@18.234.181.169 nmcli c s  >> server_health.txt
Connection to 18.234.181.169 closed.
cloud_user@server2: ~ $ eval $(ssh-agent -s)
Agent pid 2650
cloud_user@server2: ~ $ ssh-add
Identity added: /home/cloud_user/.ssh/id_rsa (cloud_user@server2)
cloud_user@server2: ~ $ ssh 18.234.181.169
cloud_user@server1: ~ $ ssh cloud_user@18.234.181.169 tar -zcvf wget-server2.tar.gz wget-1*.rpm
cloud_user@server1: ~ $ scp cloud_user@18.234.181.169:~/wget-server2* .




SUDO
whoami ; groups
id
We need to determine what files get run when we use SU
sudo -i
cloud_user@server2: ~ $ sudo -i
[sudo] password for cloud_user:
root@server2: ~ # echo export SOURCED1=.bash_profile >> ~/.bash_profile ; echo 'echo $SOURCED1' >> ~/.bash_profile
root@server2: ~ # echo export SOURCED2=.bashrc >> ~/.bashrc ; echo 'echo $SOURCED2' >> ~/.bashrcroot@server2: ~ # grep SOURCED .bash_profile
export SOURCED1=.bash_profile
echo $SOURCED1
root@server2: ~ # exit
RESULT
sudo -i echo = show both files
means that sudo -i is login shell for ROOT
and sudo is just the user with previleges
sudo -i passwd root (sets root password)
similarly
su -c 'echo $path' returns cloud user path
su - returns root user path means its root
sudo and su is user
sudo -i and su - is root



SSH from windows to remote linux
PS C:\Users\T480> ssh-keygen
PS C:\Users\T480> type $env:USERPROFILE\.ssh\id_rsa.pub | ssh 192.168.100.100 "cat >> .ssh/authorized_keys"
t480@192.168.100.100's password:
PS C:\Users\T480> type C:\Users\T480\.ssh\id_rsa.pub | ssh root@192.168.100.100 "cat >> .ssh/authorized_keys"
root@192.168.100.100's password:
PS C:\Users\T480> ssh root@192.168.100.100
Web console: https://x230:9090/ or https://192.168.100.151:9090/

Last login: Sat May 27 22:42:10 2023 from 192.168.100.193
[root@x230 ~]#