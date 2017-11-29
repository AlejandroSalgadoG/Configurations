#host
wget https://mirrors.kernel.org/archlinux/iso/2016.12.01/archlinux-bootstrap-2016.12.01-x86_64.tar.gz
tar xfz archlinux-bootstrap-2016.12.01-x86_64.tar.gz
sudo mount --bind root.x86_64 /tmp
cd /tmp
cp /etc/resolv.conf /etc
sudo mount -t proc /proc proc
sudo mount --rbind /sys sys
sudo mount --rbind /dev dev
sudo mount --rbind /run run
sudo chroot /tmp

#arch
pacman-key --init
pacman-key --populate archlinux
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bk

#host
sed -i 's/^#Server/Server/' /tmp/etc/pacman.d/mirrorlist.bk

#arch
rankmirrors -n 6 /etc/pacman.d/mirrorlist.bk > /etc/pacman.d/mirrorlist
mount /dev/sda8 /mnt #mount root
mkdir /mnt/boot
mount /dev/sda9 /mnt/boot #mount boot
mkdir /mnt/boot/efi
mount /dev/sda2 /mnt/boot/efi #mount efi
pacstrap /mnt base
genfstab -U /mnt/ >> /mnt/etc/fstab
lsblk -no UUID /dev/sda10 #copy output
vim /mnt/etc/fstab #UUID=9e7ea86e-ad75-4b65-a48f-b22c77ebcb13 none swap defaults 0 0
arch-chroot /mnt

#Real arch
ln -s /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc
pacman -S vim
uncoment en_US.UTF-8 from /etc/locale.gen
locale-gen
vim /etc/locale.conf # LANG=es_CO.UTF-8
vim /etc/hostname # alejandro
vim /etc/hosts # 127.0.1.1       alejandro.localdomain   localhost
pacman -S iw
pacman -S wpa_supplicant
pacman -S dialog
pacman -S iputils # optional
pacman -S git
passwd
mkdir /boot/efi
mount /dev/sda2 /boot/efi
vim /etc/grub.d/40_custom

	hint = grub-probe --target=hints_string /boot/efi/EFI/Microsoft/Boot/bootmgfw.efi
	uuid = grub-probe --target=fs_uuid /boot/efi/EFI/Microsoft/Boot/bootmgfw.efi

	menuentry "Microsoft Windows Vista/7/8/8.1 UEFI-GPT" {
		insmod part_gpt
		insmod fat
		insmod search_fs_uuid
		insmod chain
		search --fs-uuid --set=root $hint $uuid
		chainloader /EFI/Microsoft/Boot/bootmgfw.efi
	}

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub --boot-directory=/boot/efi --debug
grub-mkconfig -o /boot/efi/grub/grub.cfg

vim /etc/modprobe.d/modprobe.conf # blacklist nouveau
sudo pacman -S xf86-video-intel
mkdir /etc/X11/xorg.conf.d
vim /etc/X11/xorg.conf.d/20-intel.conf
	
	Section "Device"
	    Identifier "Intel Graphics"
	    Driver "intel"
	EndSection

sudo pacman -S xorg-server
sudo pacman -S xorg-xinit

cp /etc/X11/xinit/xinitrc /home/alejandro/.xinitrc
vim .xinitrc 

	#After the last if delete everything and put
	exec i3

vim .bash_profile

	if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	    exec startx
	fi

sudo pacman -S xf86-input-synaptics

sudo pacman -S gnome-terminal
sudo pacman -S ttf-droid
setxkbmap latam
sudo localectl set-x11-keymap latam

sudo pacman -S xorg-xbacklight
sudo pacman -S pulseaudio
sudo pacman -S pavucontrol

sudo pacman -S binutils
sudo pacman -S gcc
sudo pacman -S make
sudo pacman -S pkg-config
sudo pacman -S fakeroot
sudo pacman -S patch

git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si

git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si

yaourt -S broadcom-wl
sudo pacman -S networkmanager
sudo pacman -S network-manager-applet

sudo systemctl start NetworkManager.service 
sudo systemctl enable NetworkManager.service 
