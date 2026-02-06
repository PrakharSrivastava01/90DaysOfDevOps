LVM and EBS Volume on EC2
Objective

To understand how storage works on an EC2 instance by using EBS volumes with and without LVM, and to observe data persistence behavior.

Part 1: LVM on EC2 (Using EBS Volumes)
1. Checked existing block devices

Used lsblk to verify attached disks and existing partitions.

Command used:

lsblk


2. Created Physical Volumes

Converted the attached EBS disks into LVM physical volumes.

Commands used:

pvcreate /dev/xvdd
pvcreate /dev/xvdf


Verified using:

pvdisplay

3. Created Volume Group

Created a volume group using both physical volumes.

Command used:

vgcreate my_vg /dev/xvdd /dev/xvdf


Verified using:

vgdisplay

4. Created Logical Volume

Created a logical volume from the volume group.

Command used:

lvcreate -L 15G -n my_lvs my_vg


Verified using:

lvdisplay

5. Verified LVM mapping

Checked how the logical volume is mapped to underlying disks.

Command used:

lsblk


Logical volume my_vg-my_lvs is visible and spans across both disks.

Observations (LVM)

EBS volumes are raw block devices.

Physical Volumes prepare disks for LVM usage.

Volume Groups combine storage from multiple disks.

Logical Volumes are created from pooled storage.

Logical Volumes need formatting before they can be mounted.

Part 2: EBS Volume Without LVM (Direct Method)
1. Attached an EBS volume directly

Attached a new EBS volume to the EC2 instance without using LVM.

Verified using:

lsblk

2. Formatted the volume

Formatted the volume with an ext4 filesystem.

Command used:

mkfs -t ext4 /dev/xvdg

3. Mounted the volume

Mounted the formatted volume to a directory.

Commands used:

mount /dev/xvdg /mnt/test


Created files inside the mounted directory to test data storage.

4. Unmounted and detached the volume

Unmounted the volume and detached it from the EC2 instance.

Command used:

umount /mnt/test

5. Reattached and verified data

After reattaching and mounting the same EBS volume, the previously created data was still present.

Observations (Non-LVM)

Formatting creates a filesystem on the volume.

Unmounting does not delete data.

Detaching an EBS volume does not erase data.

Data persists as long as the same EBS volume is reused.

Conclusion

This exercise demonstrated both LVM-based and non-LVM-based storage management on EC2. It also confirmed that EBS volumes retain data even after unmounting or detaching, provided the same volume is reattached.
