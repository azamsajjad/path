5-Create and configure file systems
Create, mount, unmount, and use vfat, ext4, and xfs file systems
Mount and unmount network file systems using NFS
Configure autofs
Extend existing logical volumes
Create and configure set-GID directories for collaboration
Diagnose and correct file permission problems

Formatting Disk Partition with FAT32 File System
1. To format a disk with a FAT32 file system, use:
sudo mkfs -t vfat /dev/sdb1 upto 4gb
wipefs -a /dev/sda7 to refresh df -h
resize2fs /dev/sda7 to refresh df -h
mkfs -t ntfs /dev/sdb1 upto 1kb
ext4 16gb-16tb journaling filesystem to prevent data loss
ext4 support signle filesize of 16gb
ext4 is default in debian/ubuntu
ext4 you can reduce the size of ext4
ext4 is most compatible across linux,mac,windows
ext4 is better for single r/w thread
XFS is optimized for large file transfers and parrallel I/O operations
XFS supports larger file sizes & volumes
XFS uses more advanced journaling system
XFS is better for multiple read/write threads
XFS is default on RHEL
XFS supports growing but not reducing size of partition
XFS features built-in backup and recovery tools
vfat good for sharing files across d/f operating systems
vfat is excellent for a usb 
 FORMAT A USB TO BE USED ACROSS SYSTEMS

 mkfs.vfat /dev/sda7
 fsck.vfat /dev/sda7
 xfs_repair /dev/sda7

tune2fs ----> manipulate ext4 filesystem
xfs_admin ---> manipulate xfs filesystem

# AUTOFS SERVER
yum install -y nfs*
mkdir /public
mkdir /private
chmod 777 /public
chmod 777 /private
cal > /public/calpublic.txt
echo "Classes are Good!" > /private/echoprivately.txt
vim /etc/exports
                    /public 10.0.1.60(ro,sync)
                    /private 10.0.1.60(rw,sync)
exportfs -arvf
firewall-cmd --add-service={nfs,rpc-bind,mountd} --zone=public --permanent
firewall-cmd --list-all
systemctl enable --now nfs-server.service

# AUTOFS CLIENT
yum install -y nfs* autofs
    6  mkdir /automount
    7  mkdir /automount/private
    8  mkdir /automount/public
   11  vim /etc/auto.master
            /automount      /etc/automount.txt      --timeout=30
   12  vim /etc/automount.txt
            public -ro,sync 10.0.1.33:/public
            private -rw,sync 10.0.1.33:/private
   13  systemctl enable --now autofs
   14  systemctl status autofs
   15  systemctl status rpcbind
   16  df -ht
   17  df -hT
   18  cd /automount/
AUTOFS RHEL9
client : yum install nfs-utils autofs
            vim /etc/auto.master
                |-> /auto_mount /etc/auto.misc
            vim /etc/auto.misc
                |-> access          -rw,soft,intr       198.168.100.100:/share
            systemctl enable --now autofs
            directory /auto_mount/access automatically created under /





NFS
SERVER
/etc/exports
/export/web_data1       192.168.100.34/24(rw,sync,no_root_squash,insecure)
/export/web_data2       192.168.100.34/24(rw,sync,no_root_squash,insecure)
systemctl daemon-reload
exportfs -a / -rv

CLIENT
yum install cifs-utils rpcbind
rpcinfo -p 192.168.100.34
showmount -e 192.168.100.34
mount -t nfs 192.168.100.34:/export/web_data1 /nfs
 mount -t nfs 192.168.100.34:/export/web_data2 /nfs2
 or
 vim /etc/fstab
192.168.100.34/24:/export/web_data1 /mnt/nfs_web_data1  nfs defaults,_netdev 0 0
192.168.100.34/24:/export/web_data2  /mnt/nfs_web_data2 nfs defaults,_netdev 0 0
mount -a


# AUTOFS export home directories
WE HAVE USER HOME DIRECTORIES ON EVERY SERVER = INEFFICIENT
WE NEED TO CONSOLIDATE THEM TO 1 SERVER
THEY MUST BE AVAILABLE TO OTHER SERVERS VIA NFS & AUTOFS
 autofs
 /etc/autofs.conf
 /etc/auto.master
/etc/auto.home - Map files for individual on demand mount points

SERVER
yum install nfs*
vim /etc/hosts
192.168.171.129 nfs-client
vim /etc/exports
/home   nfs-client(rw,sync,no_root_squash)
systemctl enable --now nfs-server.service
exportfs -arvf
showmount -e
firewall-cmd add service nfs mountd rpc-bind and ports 111,20048,2049 both tcp&udp


CLIENT
yum install autofs
auto.master
# /export/home      /etc/auto.home
auto.home
# *         192.168.100.34:/home/&
showmount -e
mkdir -p /export/home
for i in manny moe jack marcia jan cindy ; do usermod -d /export/home/$i $i ; done
systemctl enable --now autofs
showmount -e 192.168.100.34
firewall-cmd add service nfs mountd rpc-bind and ports 111,20048,2049 both tcp&udp
# Another method
vim /etc/auto.master.d/home.autofs
#       /export/home    /etc/auto.home
vim /etc/auto.home
# *     192.168.100.34:/home/&
or 
# *       -rw,sync,no_root_squash 192.168.171.128:/home/&



STRATIS
consists of:
1 a Block device such as disk,partition,lvm,etc
stratis pool - size is sum of block devices in the pool
file system is xfs& managed via stratis, no fixed size, thinly provisioned, support snapshots
# yum install -y stratisd stratis-cli 
persistant stratis /etc/fstab
/stratis/pool/fs1  /mnt/stratisfs1  xfs  defaults,x-systemd.requires=stratisd.service 0 0
stratis filesystem destroy storage appfs1
stratis pool destroy storage



STRATIS
yum install -y stratisd stratic-cli
    4  yum install -y stratisd stratis-cli
    5  systemctl enable --now stratisd
    6  systemctl status stratisd
    7  stratis --help
    8  stratis pool --help
    9  stratis pool create -h
   10  stratis pool create
   11  stratis pool create pool0 /dev/xvdb
   12  stratis pool list
   13  stratis fs -h
   14  lsblk
   15  stratis fs create -h
   16  stratis fs create pool0 stratisfs
   17  mkdir -p /mnt/stratismnt
   18  stratis pool
   19  stratis fs
   20  df -ht
   21  df -hT
   22  lsblk
   23  fdisk -l
   24  stratis fs
   25  mount /dev/stratis/pool0/stratisfs /mnt/stratismnt/
   26  ls -l /mnt/stratismnt/
   27  touch /mnt/stratismnt/file1
   28  mkdir /mnt/stratismnt/dir1
   29  ls -l /mnt/stratismnt/
   30  df -hT /mnt/stratismnt/
   32  stratis fs
   33  vim /etc/fstab
   34  umount /mnt/stratismnt
   35  systemctl daemon-reload
   36  mount -a
   37  df -hT /mnt/stratismnt/
   38  ls -l /mnt/stratismnt/
   39  touch /mnt/stratismnt/file2
   41  stratis report
   42  wipefs /dev/xvdc
   43  wipefs /dev/xvdd
   44  stratis pool add-data pool0 /dev/xvdc
   45  stratis pool add-data pool0 /dev/xvdd
   46  stratis pool
   47  stratis fs
   48  df -hT /mnt/stratismnt/
   49  df -hT
   50  lsblk -f
   51  lsblk -l
   52  fdisk -l
   53  mkdir -p /mnt/stratismnt2
   54  stratis fs snapshot pool0 stratisfs stratisfs-snapshot
   55  mount /dev/stratis/pool0/stratisfs-snapshot /mnt/stratismnt2
   56  ls -l /mnt/stratismnt /mnt/stratismnt2
   57  rm -rf /mnt/stratismnt/file2
   58  ls -l /mnt/stratismnt /mnt/stratismnt2
   59  umount /mnt/stratismnt
   60  umount /mnt/stratismnt2
   61  vim /etc/fstab
   62  systemctl daemon-reload
   63  mount -a
   64  df -hT /dev/stratis
   65  stratis pool
   66  stratis fs
   67  vim /etc/fstab
   68  systemctl daemon-reload
   69  mount -a
   70  grep stratis /proc/mounts
   71  df -hT /mnt/stratisfs
   74  ls -l /mnt/stratismnt
   75  ls -l /mnt/stratismnt2
   76  stratis fs destroy pool0 stratisfs
   77  stratis fs
   78  stratis blockdev


disk compression
$ lvmdiskscan
LVM logical volumes on top of VDO
VDO on top of LVM Logical Volume
LVM on VDO on top of LVM Logical Volume
RHEL 9
yum install lvm2 kmod-kvdo vdo
pvcreate /dev/sda7
vgcreate VG1 /dev/sda7
lvcreate --type vdo --name VDO1 --size 13GB --virtualsize 1000GB VG1
mkfs.xfs -K /dev/VG1/VDO1
/etc/fstab
# /dev/VG1/VDO1     /mnt/TB     xfs     defaults        0 0
mount -a
vdostats --human-readable
lsblk
LVM on VDO RHEL8
yum install vdo kmod-kvdo
vdo create --name=vdo1 --device=/dev/xvdb --vdoLogicalSize=15G
{ echo "===== `date` on `hostname` ====" ; vdostats --human-readable ; vdostats --verbose ; grep -C5 'used percent' ; } >> vdostats.log
-C5 = grep word plus context, 5 lines above and below
pvcreate /dev/mapper/vdo1
vgcreate vdo_vg1 /dev/mapper/vdo1
lvcreate -n vdo_vol1 -L+14.9G vdo_vg1
vgs
lvs
lsblk
mkfs.xfs -K /dev/vdo_vg1/vdo_vol1
mkdir -p /mnt/vdo_data
mount -o discard /dev/vdo_vg1/vdo_vol1 /mnt/data
umount /mnt/data
vim /etc/fstab
UUID /mnt/data xfs defaults 0 0
mount -a
df -hT /mnt/data


Some practical examples on dd command :

To backup the entire harddisk : To backup an entire copy of a hard disk to another hard disk connected to the same system, execute the dd command as shown. In this dd command example, the UNIX device name of the source hard disk is /dev/hda, and device name of the target hard disk is /dev/hdb.
# dd if=/dev/sda of=/dev/sdb
“if” represents inputfile, and “of” represents output file. So the exact copy of /dev/sda will be available in /dev/sdb.
If there are any errors, the above command will fail. If you give the parameter “conv=noerror” then it will continue to copy if there are read errors.
Input file and output file should be mentioned very carefully. Just in case, you mention source device in the target and vice versa, you might loss all your data.
To copy, hard drive to hard drive using dd command given below, sync option allows you to copy everything using synchronized I/O.
# dd if=/dev/sda of=/dev/sdb conv=noerror, sync
To backup a Partition : You can use the device name of a partition in the input file, and in the output either you can specify your target path or image file as shown in the dd command.
# dd if=/dev/hda1 of=~/partition.img
To create an image of a Hard Disk : Instead of taking a backup of the hard disk, you can create an image file of the hard disk and save it in other storage devices. There are many advantages of backing up your data to a disk image, one being the ease of use. This method is typically faster than other types of backups, enabling you to quickly restore data following an unexpected catastrophe.It creates the image of a hard disk /dev/hda.
# dd if=/dev/hda of=~/hdadisk.img
To restore using the Hard Disk Image : To restore a hard disk with the image file of an another hard disk, the following dd command can be used
# dd if=hdadisk.img of=/dev/hdb
The image file hdadisk.img file, is the image of a /dev/hda, so the above command will restore the image of /dev/hda to /dev/hdb.

To create CDROM Backup : dd command allows you to create an iso file from a source file. So we can insert the CD and enter dd command to create an iso file of a CD content.
# dd if=/dev/cdrom of=tgsservice.iso bs=2048
dd command reads one block of input and process it and writes it into an output file. You can specify the block size for input and output file. In the above dd command example, the parameter “bs” specifies the block size for the both the input and output file. So dd uses 2048bytes as a block size in the above command.


AUTOFS 