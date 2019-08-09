#!/bin/bash

# Made by Fernando "maroto"
# Run anything in the filesystem right before being "mksquashed"

script_path=$(readlink -f ${0%/*})
work_dir=work

# Adapted from AIS. An excellent bit of code!
arch_chroot(){
    arch-chroot $script_path/${work_dir}/airootfs /bin/bash -c "${1}"
}  

do_merge(){

arch_chroot "pacman-key --init
pacman-key --populate
pacman-key --refresh-keys
pacman -Syy
sed -i 's?GRUB_DISTRIBUTOR=.*?GRUB_THEME=?' /etc/default/grub
sudo -H -u liveuser bash -c 'dbus-launch dconf load / < mousepad.dconf'
rm mousepad.dconf
find /root -type d -exec chmod -R 755 {} \;
chown root:root -R /root"

}

#################################
########## STARTS HERE ##########
#################################

do_merge

#sed -i 's~\#GRUB_BACKGROUND=.*~GRUB_BACKGROUND=\/usr\/share\/endeavouros\/splash.png~g' /etc/default/grub
