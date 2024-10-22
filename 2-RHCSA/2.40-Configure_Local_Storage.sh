4-Configure local storage
List, create, delete partitions on MBR and GPT disks
Create and remove physical volumes
Assign physical volumes to volume groups
Create and delete logical volumes
Configure systems to mount file systems at boot by universally unique ID (UUID) or label
Add new partitions and logical volumes, and swap to a system non-destructively

du -sh /root combine size
du -ah /root file sizes
check directory size on disk
create a swap partition
df -h /
df -h /mnt
blkid (get uuID)
lsblk -l & -f
fdisk -l
fdisk 
t - to change partition type - select 82
partprobe
mkswap -L more_swap /dev/sda7 (label=more_swap)
swapon /dev/sda7
swapon
edit /etc/fstab
umount then mount -a (this way we will know its persistent)
free -h (view Ram)


use #vgdisplay command to view Physical extent and logical extent sizes
CREATE a LOGICAL VOLUME
pvcreate /dev/sda7
pvs
vgcreate newVG /dev/sda7
vgs
lvcreate -l 100%FREE -n newLVM newVG
lvs
vdostats --hu
lsblk
mkfs.ext4 /dev/mapper/newVG-newLVM
mkdir /dir
vim /etc/fstab
/dev/mapper/newVG-newLVM    /dir    ext4 defaults 0 0
mount -a
mount | grep dir
ADD 1GB storage to dir
pvcreate /dev/sda8
vgextend newVG /dev/sda8
lvextend -r -L +1G newVG/newLVM (-------> -r to automatically install filesystem on extended space)
lvs
df -h /dir -> still 2gb
resize2fs /dev/mapper/newVG/newLVM


create LV named LV2 with 10 extent where the size of each extent is 8mb
vgcreate -s 8mb VG1 /dev/sda7
vgdisplay
lvcreate -l 10 -n LV2 /dev/VG1/LV2


to REMOVE
umount /dir
lvremove newLVM
vgremove -f newVG
pvremove /dev/sda7 /dev/sda8
wipefs -a /dev/sda7 /dev/sda8

partdev (not covered)

fdisk -l | grep "^/dev/xvd" | sort


List your disk partitions using various tools
Create a new partition and put a file system on it
Unmount the file system
Create an extended and logical partitions and confirm
1  yum update -y
    2  exit
    3  fdisk -l
    4  fdisk
    5  lsblk
    6  fdisk -l /dev/xvdb
    7  fdisk /dev/xvdb
    8  mkfs.ext4 /dev/xvdb1
    9  parted /dev/xvdb1 print
   10  mkdir /mnt/ext4disk
   11  fdisk /dev/xvdc
   12  mkfs.xfs /dev/xvdc5
   13  lsblk
   14  findmnt
   15  lsblk -f
   16  vim /etc/fstab
   17  mount -a
   18  mount | grep ext4
   19  cat /proc/mounts | grep ext4
   20  
   
   Add a swap file system to the system
Add a swap file to the system
NO NEED TO FDISK/CREATE A PARTITION
   lsblk -fs
   21  free
   22  free -h
   23  mkswap /dev/xvdd
   25  lsblk -fs
   26  vim /etc/fstab
   27  swapon -v /dev/xvdd
   28  free -h
#    29  dd if=/dev/zero of=/moreswap bs=1024 count=65536
#    30  mkswap /moreswap
   31  free -h
   32  chmod 600 /moreswap
   33  vim /etc/fstab
   /moreswap        swap    swap    defaults    0 0
   34  systemctl daemon-reload
   35  free -h
#    36  swapon /moreswap
   37  free -h
   38  free -h ; grep moreswap /proc/swaps


backup entire disk into another disk
dd if=/dev/sda of=/dev/sdb

LAB
Partition Disks and Create Physical Volumes
Create and Extend a Volume Group and a Logical Volume
Format, Mount, and Extend the Logical Volume and File System
Reduce a Logical Volume and File System and Remove and Wipe a Physical Volume

lsblk
    3  fdisk /dev/xvdb
    4  fdisk /dev/xvdc
    5  fdisk /dev/xvdd
    6  partprobe
    7  fdisk -l
    8  lsblk
    9  lsblk -f
   10  blkid
   11  lsblk -fs
   12  lsblk
   13  pvcreate /dev/xvdb1
   14  pvcreate /dev/xvdc1
   15  pvcreate /dev/xvdd1
   16  vgcreate VGVolume /dev/xvdb1
   17  vgextend VGVolume /dev/xvdc1
   18  lvcreate -L+3.99GB -n "datavolume" VGVolume
   19  lvs
   20  mkdir -p /mnt/lvmpoint
   21  mkfs.ext4 /dev/VGVolume/datavolume
   22  mount /dev/VGVolume/datavolume /mnt/lvmpoint/
   23  ls -l /mnt/lvmpoint/
   24  touch /mnt/lvmpoint/file3
   25  ls -l /mnt/lvmpoint/
   26  df -hT /mnt/lvmpoint/
   27  lsblk
   28  lvs
   29  vgs
   30  pvs
   31  vgextend VGVolume /dev/xvdd1
   32  vgs
   33  lvs
   34  lvextend -L+2GB /dev/VGVolume/datavolume
   35  lvextend -L+1.95GB /dev/VGVolume/datavolume
   36  lvs
   37  df -hT /dev/VGVolume/datavolume
   38  lvs
   39  lvresize --resizefs --size 5.95GB /dev/VGVolume/datavolume
   40  df -hT /dev/VGVolume/datavolume
   41  ls -l /mnt/lvmpoint/
   42  df -hT /mnt/lvmpoint/
   43  lvreduce --resizefs --size 4GB /dev/VGVolume/datavolume
   44  df -ht /mnt/lvmpoint/
   45  vdreduce /dev/VGVolume /dev/xvdb1
   46  vgreduce /dev/VGVolume /dev/xvdb1
   47  lvs
   48  lvreduce --resizefs --size 3.9GB /dev/VGVolume/datavolume
   49  vgs
   50  vgreduce /dev/VGVolume /dev/xvdb1
   51  vgreduce /dev/VGVolume /dev/xvdd1
   52  lsblk -f
   53  pvremove /dev/xvdd1
   54  lsblk -f


VDO on LVM RHEL9
yum install lvm2 kmod-kvdo vdo 
lsblk
pvcreate /dev/sda7
vgcreate VG1 /dev/sda7
lvcreate --type vdo --name vdo1 --size 5GB --virtualsize 50Gb VG1
lsblk
mkfs.xfs  -k  /dev/VG1/VDO1
mkdir -p /vdo_m
vim /etc/fstab
# /dev/VG1/VDO1 /vdo_m  xfs   defaults 0 0 
mount -a



# mkfs.ext4 -E nodiscard /dev/vdovg/vdo-lv 
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 13107200 4k blocks and 3276800 inodes
Filesystem UUID: fc19bd48-4154-465f-b8a0-7cfefc62f20a
Superblock backups stored on blocks: 
    32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
    4096000, 7962624, 11239424

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (65536 blocks): done
Writing superblocks and filesystem accounting information: done   
autofs RHEL9


