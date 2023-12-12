cpu utilization 99% script
for i in 1 2 3 4; do while : ; do : ; done & done

3-Operate running systems
Boot, reboot, and shut down a system normally
Boot systems into different targets manually
Interrupt the boot process in order to gain access to a system
Identify CPU/memory intensive processes and kill processes
Adjust process scheduling
Manage tuning profiles
Locate and interpret system log files and journals
Preserve system journals
Start, stop, and check the status of network services
Securely transfer files between systems

BOOT PROCESS
grub bootloader, systemd, POST PROCESS

We lost Root Password
systemctl get-default -> graphical.target
linux....... rd.break
ctrl+x
emergency mode
mount -o remount,rw /sysroot
chroot /sysroot
paaswd Root
touch .autorelabel
mount -o ro,remount /sysroot
exit
if error
then 
linux..... systemd.unit=multi-user.target
login
systemctl get-default -> graphical.target
systemctl set-defaulr multi-user
systemctl get-default -> multi-user.target
this was booting system into different targets manually

SYSTEM LOGGING
exam obj: locate & interrupt system log files & journals
preserve system journals
/var/log
journald
persistant journals

grep -i systemd /var/log/messages | less
grep systemd `find /var/log -maxdepth 1 -type f -print` | grep -v dnf |less
grep -v dnf = exclude dnf entries
shift+g to go to end - g to go to start


# FIND COMMAND 
find FILES larger than 4MB and COPY them to root/largefiles
find /etc/ -size +4M -type f -exec cp {} /root/largefiles/ \;
create a bash script 'mysearch' to locate files under /usr/share having size less than 1.0M
after executing script, list search files has to be copied under /root/myfiles
mkdir /root/myfiles
vim mysearch
#!/bin/bash
find /usr/share -size -1M -type f -exec cp {} /root/myfiles \;
chmod +x mysearch
./mysearch

Find All Files in `/etc` (Not Subdirectories) that Are Older Than 720 Days, and Output a List to `/root/oldfiles`
The find command has numerous flags that can help with this.
-maxdepth 1 will search only /etc and not any subdirectories.
-mtime +720 will match on files that were modified more than 720 days ago.
A complete command is:
find /etc/ -maxdepth 1 -mtime +720 > /root/oldfiles

find /etc -maxdepth 1 -iname "*.*" -exec du -sh {} \; | sort -h > ect_dir_file_sizes.txt

journalctl -u httpd
journalctl -g systemd | less (grep for systemd)
journalctl -S 4:25:00 -U 4:26:00
journalctl --list-boots
journalctl SETTINGS - journalctl must be persistant
cat /etc/systemd/journald.conf
#storage=auto  (4 types, volatile /run/log/j, Persistent /var/log/j)
                (NONE all j data dropped, Auto- default - persistent if /var/log/journal exists)
journalctl --flush
systemctl restart systemd-journald

INTRUDER ALERT - runaway PROCESS
first step, download STRESS from epel repo
subscription-manager repos --list (copy codeready)
subscription-manager repos --enable codeready-....
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
yum install -y STRESS
stress -c 1 &
ps -aux | grep stress
or
ps -ef | grep stress
top
r to renice
kill -9 pid
nice -n 19 stress -c 1 &
renice -n 10 pid
ADJUST PERFORMANCE OF A PROCESS
chrt --max
        SCHED_OTHER min/max priority    : 0/0
        SCHED_FIFO min/max priority     : 1/99
        SCHED_RR min/max priority       : 1/99
        SCHED_BATCH min/max priority    : 0/0
        SCHED_IDLE min/max priority     : 0/0
        SCHED_DEADLINE min/max priority : 0/0
chrt -f -p 45 pid 
pgrep stress
pkill stress

chrt -o -p 0 10445 ---> yuou can only user priority 0 with other/normal priority processes,
whose priority will then be managed by nice values

for every 16 million nanoseconds, we should have 10 million nsec in which a process whose runtime is 5 million nsec can be run
chrt -d --sched-runtime 5000000 --shed-deadline 10000000 --shed-period 16666666 -p 0(priority) 1213(pid)


WE ARE ASKED TO HELP TO REDUCE POWER CONSUMPTION IN OUR DATACENTER
tuned-adm
cat /etc/tuned/tuned-main.conf
location for custom profiles
/usr/tuned
/usr/lib/tuned (distro specific profiles)
systemctl start tuned
systemctl enable tuned
tuned-adm active
tuned-adm list profiles
tuned-adm profile powersave
tuned-adm recommend
ENABLE DYNAMIC TUNING
vi /etc/tuned/tuned-main.conf
dynamic_tuning=0 ->1
systemctl restart tuned

systemctl --type=service
systemctl --type=service --state=dead
systemctl --type=service --state=running
systemctl halt
systemctl poweroff

LEGACY SHUTDOWN COMMANDS
[root@x230 ~]# which {shutdown,poweroff,reboot,halt} | xargs ls -l
lrwxrwxrwx. 1 root root 16 Mar 21 00:16 /usr/sbin/halt -> ../bin/systemctl
lrwxrwxrwx. 1 root root 16 Mar 21 00:16 /usr/sbin/poweroff -> ../bin/systemctl
lrwxrwxrwx. 1 root root 16 Mar 21 00:16 /usr/sbin/reboot -> ../bin/systemctl
lrwxrwxrwx. 1 root root 16 Mar 21 00:16 /usr/sbin/shutdown -> ../bin/systemctl
sudo shutdown -r +15 "Please save all work, server is rebooting in 15 minutes"
shutdown -c (to cancel sheduled shutdown)

screen -S Sys-Monitor -t cmdline
DIVIDE CLI into 2
crtl+a |
crtl+a tab
crtl+a c (starts new bash session)
pkill screen
screen -ls
screen -wipe


chrt


LAB - TUNEd 
ls -l /usr/lib/tuned

vimdiff /usr/lib/tuned/virtual-guest/tuned.conf /usr/lib/tuned/virtual-host/tuned.conf
grep -n dynamic_tuning /etc/tuned/tuned-main.conf
=10:dynamic_tuning = 1
vim +10 /etc/tuned/tuned-main.conf
shift+$ r to replace a character
systemctl restart tuned
1028  systemctl start tuned
 1029  systemctl status tuned
 1030  tuned-adm active
 1031  tuned-adm list
 1032  tuned-adm profile powersave
 1033  tuned-adm active
 1034  tuned-adm profile powersave virtual-guest
 1035  tuned-adm active
[root@x230 ~]# diff /usr/lib/tuned/virtual-guest/tuned.conf /usr/lib/tuned/virtual-host/tuned.conf
6c6
< summary=Optimize for running inside a virtual guest
---
> summary=Optimize for running KVM guests
10,17c10,12
< # If a workload mostly uses anonymous memory and it hits this limit, the entire
< # working set is buffered for I/O, and any more write buffering would require
< # swapping, so it's time to throttle writes until I/O can catch up.  Workloads
< # that mostly use file mappings may be able to use even higher values.
< #
< # The generator of dirty data starts writeback at this percentage (system default
< # is 20%)
< vm.dirty_ratio = 30
---
> # Start background writeback (via writeback threads) at this percentage (system
> # default is 10%)
> vm.dirty_background_ratio = 5
19,22c14,16
< # Filesystem I/O is usually much more efficient than swapping, so try to keep
< # swapping low.  It's usually safe to go even lower than this on systems with
< # server-grade storage.
< vm.swappiness = 30
---
> [cpu]
> # Setting C3 state sleep mode/power savings
> force_latency=cstate.id_no_zero:3|70


SCHEDULER
1005  stress -c 1 &
 1006  chrt --help
 1007  pgrep stress
 1008  chrt -p 29208
 1009  chrt -p 29209
 1010  chrt -r -p 33 29208
 1011  chrt -p 29209
 1012  chrt -r -p 33 29209
 1013  chrt -p 29209
 1014  chrt -r -p 33 29208
 1015  chrt -p 29208
 1016  kill -9 29209
 1017  sudo kill -9 29209
 1018  sudo kill -9 29208
 1019  pgrep stress
 1020  chrt -f 44 stress -c 1 &
 1021  pregep stress
 1022  pgrep stress
 1023  chrt -p 29231

 
 LOG FILES & journals
1039  journalctl
 1040  ls -l /var/log/journal
 1041  journalctl --list-boot
 1042  journalctl -b 0
 1043  journalctl | grep NTP
 1044  journalctl -u chronyd.service
 1045  journalctl --since=17:59:00 --until=18:15:00
 1046  journalctl --since=-3m
 1048  journalctl --since=-10m
 1049  journalctl --since=-60m
 1050  grep -i storage /etc/systemd/journald.conf
 1051  man journald
 MAKE IT PERSISTANT
 1052  man journald.conf
 1053  mkdir -p /var/log/journal
 1054  journalctl --flush
 1055  ls -l /var/log/journal
 /run/log/journal

 True. Persistent journals are stored in the default location of /var/log/journal, if it exists.

True. Volatile journals are stored in the default directory of /run/log/journal, if the /var/log/journal directory does not exist.



SERVER
/etc/rsyslog.conf
uncomment following lines

if UDP logging
# provides UDP syslog reception
#module(load="imudp")
#input(type="imudp" port="514")

if TCP logging
# provides TCP syslog reception
#module(load="imtcp")
#input(type="imtcp" port="514")

# and add this to end of this file
$template RemoteLogs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?RemoteLogs
& ~

firewall-cmd --add-port=514/tcp --permanent


CLIENT
*.* @@192.168.171.128:514  (@@ signifies tcp, @ for udp)
systemctl restart rsyslog
Note that the *.* syntax determines that all log entries on the server should be forwarded. If you want to forward only specific logs, you can specify the service name instead of * such as cron.* @@0.0.0.0:514 or apache2.* @@0.0.0.0:514. You can also forward logs to more than one server: