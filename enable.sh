#!/bin/bash
# Enable hibernation
# Reference - https://ask.fedoraproject.org/en/question/43237/where-in-fedora-20-are-the-suspend-and-hibernate-options/

# Enable recovery in the /etc/default/grub
sed -i -e 's|^\(GRUB_DISABLE_RECOVERY="\)true"|\1false"|' /etc/default/grub

# Find the swapdevice
SWAPDEVICE=`grep -e '^[^#].*swap' /etc/fstab | head -n 1 | cut -d ' ' -f 1`
echo "Using SWAPDEVICE=${SWAPDEVICE} for hibernation"

# add "resume=swapdevice" to the GRUB_CMDLINE_LINUX=
sed -i -e "s|^\(GRUB_CMDLINE_LINUX=\".*\)\"|\1 resume=${SWAPDEVICE}\"|" /etc/default/grub

# Regenerate the grub config
/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg
