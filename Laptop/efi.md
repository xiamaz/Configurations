# Windows Messing with EFI
Windows 10 had always a notorius reputation for messing with dual-boot configuration with Linux. Doing fun stuff like deleting Linux partitions or overwriting EFI boot binaries.
One thing it seems to do, is mess with the EFI System Partition itself. After doing the Windows 10 anniversary update, Windows managed to graciously ignore my default Systemd-bootloader, which was easily fixed, by reinstalling systemd-boot from a live usb system.
What was left behind was a noticeable lag on starting systemd-boot. 
Following this up I noticed that the partition itself, seems to have received some damage, as resize commands and checkdisk seem to fail on the partition, although systemd-boot wasnt complaining, besides from a noticeable freeze on bootup.

This left me with the simple solution to remove the somehow corrupted EFI partition and migrate to a new one.
This process essentially boils down to:
1. Copy EFI partition contents to a safe location. EFI is a FAT32-Partition, so you don't need to worry about permissions mostly.
2. Remove old EFI partition (DANGER)
3. Create new EFI partition - recommended size of 512MiB
4. Set ESP flag and boot flag (do not set the legacy boot flags)
5. Update Linux fstab with new partition
6. bootctl --path=ESPMOUNTPOINT install # this is best done in chroot

Afterwards your partitions should be sane again, at least as long as windows decides to be docile.
The better solution might be just to delete Windows altogether. Saving you from these unwelcome surprises.
