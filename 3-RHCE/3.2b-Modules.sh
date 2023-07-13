    $ ansible-doc -l | wc -l
    7440 modules

[copy]
    ansible web -m copy -a 'src=~/copythisfileintmp.txt dest=/tmp'
    # yellow = job performed , green = no change, job already done
    ansible-doc copy
    ansible web -m copy -a 'src=~/copythisfileintmp.txt dest=/opt' -u root -k password
    ansible web -m copy -a 'src=~/copythisfileintmp.txt dest=/opt' -b sudo 
    # if restricted directory but user is added in sudoers file
    # only writing -b is enough too
    ansible web -m copy -a 'src=~/copythisfileintmp.txt dest=/root mode=0755 owner=reason group=wheel'
    # copy with permissions
    ansible web -m copy -a 'src=/etc/redhat-release dest=/tmp remote_src=yes'
    # copy from host to host , not main node
    ansible web -m copy -a 'src=~/copythisfileintmp.txt dest=/root backup=yes'
    # if dest has this file, create backup of it and copy new file.
    ansible web -m copy -a 'content="Nehra Classes are awesome." dest=/tmp/Nehraclasses.txt'
    ansible web -m copy -a 'content="New Nehra Classes are awesome." dest=/tmp/Nehraclasses.txt'
    # overwritten
    ansible web -m copy -a 'src=~/Nehraclasses.txt dest=/tmp backup=yes'
    ansible all -m command -a 'ls -alh /tmp'
    -rw-r--r--.  1 root     root        0 Jun 18 23:07 Nehraclasses.txt
    -rw-r--r--.  1 root     root       30 Jun 18 23:02 Nehraclasses.txt.36941.2023-06-18@23:07:08~ 
    # old file with same name got backedup

[command]
    ansible web -m command -a 'ls -alh /tmp'
    ansible web -m command -a 'uptime' 
    # command module will only run if python 2.4 or up is installed on the node
    # otherwise use [RAW-module]
    # for multiple commands, use RAW
[raw]
    ansible web -m raw -a 'uptime ; lsblk'
[shell]
    ansible web -m copy -a 'src=~/shell.sh dest=/root/shell.sh mode=0755'
    ansible web -m shell -a '/root/shell.sh'
[fetch]
    ansible web -m fetch -a 'src=/etc/chrony.conf dest=~/backup'
    ansible web -m fetch -a 'src=/etc/httpd.conf dest=~/backup'
    cd ~/backup/192.168.100.101/etc/chrony + httpd
[get_url]
    ansible web -m get_url -a 'url=https://linux-training.be/linuxfun.pdf dest=/tmp/linuxfun.pdf'

[lineinfile]
    # to add a line in a file
    ansible web -m lineinfile -a 'dest=/tmp/Nehraclasses.txt line="This server is managed by Ansible"
    ansible web -m lineinfile -a 'dest=/tmp/Nehraclasses.txt line="This server is managed by Ansible and Jenkins"
    ansible all -m command -a 'cat /tmp/Nehraclasses.txt'
    # 192.168.100.102 | CHANGED | rc=0 >>
    # This server is managed by Ansible
    # This server is managed by Ansible and Jenkins
    ansible web -m lineinfile -a 'dest=/tmp/Nehraclasses.txt line="Dear all," insertafter=BOF'
    # 192.168.100.102 | CHANGED | rc=0 >>
    # Dear all,
    # This server is managed by Ansible
    # This server is managed by Ansible and Jenkins
    ansible web -m lineinfile -a 'dest=/tmp/Nehraclasses.txt line="Thanks" insertafter=EOF' -->End of File
    ansible web -m lineinfile -a 'dest=/tmp/Nehraclasses.txt line="This is also managed by Terraform" insertafter=This' --> insert after the line beginning with 'This'
    ansible web -m lineinfile -a 'dest=/tmp/Nehraclasses.txt line="This is also managed by Terraform" state=absent' -->remove this line
    ansible web -m lineinfile -a 'dest=/tmp/Nehraclasses.txt regexp=^This state=absent' -->use regular expression to delete all lines starting with 'This'
[replace]
    ansible web -m replace -a 'dest=/tmp/Nehraclasses.txt regexp=^Dear replace=Hello'
    # Dear all ---> Hello all
[file]
    ansible web -m file -a 'path=/tmp/data state=directory'
    ansible web -m file -a 'path=/tmp/data state=absent' --->delete dir
    ansible web -m file -a 'path=/home/user/text state=touch'
    ansible web -m file -a 'path=/home/user/text' ---> with no state, it prints out information
    ansible web -m file -a 'path=/home/user/text mode=0400'
    ansible web -b -m file -a 'path=/home/user/text owner=root'
[user]
    ansible web -m user -a 'name=sehrish state=present uid=1350 groups=wheel'
    [groups=wheel ----> secondary group]
    [group=wheel ----> primary group]
    ansible web -m user -a 'name=sehrish append=yes groups=staff'
    ansible web -m command -a 'id -a sehrish'
    # 192.168.100.102 | CHANGED | rc=0 >>
    uid=1350(sehrish) gid=1350(sehrish) groups=1350(sehrish),10(wheel)
    # 192.168.100.101 | CHANGED | rc=0 >>
    uid=1350(sehrish) gid=1350(sehrish) groups=1350(sehrish),10(wheel)
    ansible node2 --> if you want to add on a single machine
    ansible web -m user -a 'name=sehrish state=absent'
[group]
    ansible web -m group -a 'name=staff gid=1025 state=present'
    ansible web -m command -a 'tail -3 /etc/group'
    ansible web -m group -a 'name=staff state=absent'
    ansible web -m group -a 'name=manager state=absent'
[yum]
    ansible web -m yum -a 'name=zsh state=present/install'
    ansible web -m command -a 'rpm -qi zsh'
[yum_repository]
    ansible web -m copy -a 'src=local.repo dest=/etc/yum.repo.d/'
    or
    ansible web -m yum_repository -a 'name=test description="test repo" baseurl=http://baseos.com/appstream anabled=1 gpgcheck=0'
    ansible web -m command -a 'yum repolist all'
    ansible web -m yum_repository -a 'name=test state=absent' --> to delete a repo
[package]
    ansible web -m package -a 'name=zsh state=present/installed use=yum'
    ansible web -m package -a 'name=httpd status=latest'
[stat]
    ls command - file size - permissions - and much more - existence of file on server
    ansible web -m stat -a 'path=/etc/passwd'
    ansible web -m stat -a 'path=/etc/xyz.conf' --> exists on servers = false
    ansible web -m stat -a 'path=/dev/nvme0n2p1'
[setup]
    ansible web -m setup
    ansible web -m setup -a 'filter=*kernel*'
    VIP IMPORTANT
    PRINTS NODE INFORMATION
[service]
[systemd]
    # to re-read systemd
    ansible web -m systemd -a 'daemon-reload=true'
    # to re-execute systemd
    ansible web -m systemd -a 'daemon_reexec=true'
    ansible web -m systemd -a 'name=httpd state=started enabled=true'
    ansible web -m systemd -a 'name=httpd state=restarted' --> 
    # service shutdown and start
    ansible web -m systemd -a 'name=httpd state=reloaded' -->
    # service daemon reload its configuration from config file
    ansible web -m systemd -a 'name=httpd state=stopped'
    ansible web -m systemd -a 'name=httpd enbled=false'
    ansible web -m command -a 'systemctl status httpd'
    # systemctl mask httpd -> symlink is pointed to /dev/null
    ansible web -m systemd -a 'name=httpd state=stopped enabled=false'
    ansible web -m systemd -a 'name=httpd masked=true'
[debug]
    ansible localhost -m debug -a 'msg="{{ ansible_version.full }}"'
[uri]
    check to see if nodes have internet access
    uri = url testing
    ansible all -m uri -a 'url=http://api.classes.com:9898'
[parted]
    ansible node2 -m parted -a 'device=/dev/sdb number=1 part_end=10GiB state=present'
    ansible node2 -m parted -a 'device=/dev/sdb number=2 part_start=10GiB part_end=15GiB state=present'
    ansible node2 -m parted -a 'device=/dev/sdb number=3 part_start=15GiB part_end=19GiB part_type=extended state=present'
    ansible node2 -m parted -a 'device=/dev/sdb number=3 state=absent'
    ansible node2 -m command -a 'lsblk'
    ansible node2 -m command -a 'lsblk -f' --> see fs
    ansible node2 -m command -a 'blkid' -->see fs
[filesystem]
    ansible node2 -m filesystem -a 'device=/dev/sda1 fstype=xfs'
    ansible node2 -m filesystem -a 'device=/dev/VolGrp/LogVol fstype=ext4'

[LVG]
    ansible-doc LVG
    ansible node2 -m lvg -a 'pvs=/dev/sda2 vg=VolGrp state=present'
    ansible node2 -m lvg -a 'pvs=/dev/sda2,/dev/sd3 vg=VolGrp state=present'
    ansible node2 -m lvg -a 'vg=VolGrp state=absent'
    ansible node2 -m command -a 'vgs'

[LVOL]
    ansible node2 -m lvol -a 'vg=VolGrp lv=LogVol size=4G state=present'
    ansible node2 -m lvol -a 'vg=VolGrp lv=LogVol size=+1G state=present'
    ansible node2 -m lvol -a 'vg=VolGrp lv=TestVol size=100%FREE state=present'
    ansible node2 -m lvol -a 'vg=VolGrp lv=LogVol state=absent force=true'
    ansible node2 -m command -a 'lvs'
[mount]
    ansible node2 -m mount -a 'path=/opt/ src=/dev/VolGrp/LogVol fstype=ext4 opts=defaults state=mounted'
    if a module not INSTALLED , then
    ansible-galaxy collection install ansible.posix
[cron]
    ansible web -m cron -a 'name=nehra weekday=1 minute=48 hour=22 user=root job="echo NehraClasses > /var/log/messages"'
    ansible web -m command -a 'crontab -l -u root'
