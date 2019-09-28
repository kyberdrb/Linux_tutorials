# Arch Linux Installation

1. Download Arch Linux iso and clone it on the USB drive

    Linux
    
        lsblk
        sudo dd if=arch.iso of=/dev/sdb
    
    Windows
    
    - Rufus
    
    [Arch Wiki - USB flash installation media](https://wiki.archlinux.org/index.php/USB_flash_installation_media#In_Windows)

1. Plug the USB drive into a PC and boot from it.
Keep pressing F8 / F9 / F12 to get boot device selection menu or go straight to BIOS and change boot settings there.
If your computer supports it, boot in UEFI mode, which I really recommend. Otherwise boot in legacy mode.
If your computer (like mine laptop HP 4530s) doesn't offer you a UEFI boot option for your USB (only legacy) boot from `EFI/boot/loader.efi` these steps to boot the USB in UEFI mode (make sure UEFI booting is enabled in the BIOS):
  Rapidly press F9
  Choose "Boot From EFI File"
  Choose option "ARCHISO_EFI_..."
  Select "EFI -> boot -> loader.efi"
Now the USB will boot in UEFI mode a shortly you will see the ARCH EFI bootloader.

****************************************

After you get the Arch Linux boot screen, choose "Boot Arch Linux x86_64"

To install Arch Linux you need to have Internet connection. It's recommended to use the Ethernet, but Wi-Fi connection is also possible, if your wireless adapter is supported. Below I will explain how to connect to the Internet via Ethernet and Wi-Fi.

List all your wired and wireless network adapters
	
	ip link

****************************************
WIRELESS (Wi-Fi) ONLY

Connect to a Wi-Fi network

    wifi-menu
    
Choose the network, confirm profile name and enter password.

The Wi-Fi adapter is turned on automatically by the command and the IP address is obtained automatically as well via DHCP.

****************************************

The Ethernet should be named "enpXsY" (X and Y are numbers). Wireless adapters have a name in format "wloZ" (Z is a number).
Then you need to request an IP address via DHCP (for manual IP configuration see Arch Linux Wiki - Network configuration):
	
	dhcpcd enpXsY

or for wireless adapters

	dhcpcd wloZ

an IP address should be assigned to the Ethernet interface.

Test connectivity:
	
	ping google.com -c 4

If the ping was successful, we can proceed with Arch Linux installation.

We have to determine, if we want legacy or EFI install of Arch Linux. If you choosed "UEFI" in the boot device selection earlier, read on, otherwise skip this part.

****************************************

If you choosed to boot from USB in UEFI mode, check the list of EFI variables to see, if Arch Linux can be installed in UEFI mode:
	
	efivar -l

If it lists variables, you can install Arch Linux in UEFI mode :D
If it doesn't list any variables or prints an error "efivar: error listing variables: Function not implemented", it means, that either we booted into legacy mode, or our UEFI is not supported.

Now we can continue with the disk partitioning

DISK PARTITIONING
First of all, we have to choose the disk, which Arch Linux will be installed on. Print the list of connected disks with command:

	lsblk

Let's say, we want to install Arch on disk "sda".
Firstly, we need to wipe the disk:

	sgdisk --zap-all /dev/sda


Then we need to partition it.
For UEFI install it will be partitioned like this:
	boot (EFI), Swap, Root
For legacy install it will be partitioned like this:
	Swap, Root

****************************************
UEFI ONLY

    sgdisk --clear /dev/sda
    sgdisk --new=1:0:+600MiB --typecode=1:ef00 /dev/sda    
    sgdisk --new=2:0:+210GiB --typecode=2:8300 /dev/sda

Run the partition tool (I will use cgdisk, but there are many others)
	
	cgdisk /dev/sda
	
	# Press any key to continue ...

UEFI partitioning configuration:

	# Create EFI partition
	Select "New"
	First sector: 4096
	Size in sectors: 512MiB
	Hex code or GUID: EF00
	Partition name: boot

	# Create Swap partition
	Select "New"
	First sector: <press Enter - use the first availible sector>
	Size in sectors: 4GiB
	Hex code or GUID: 8200
	Partition name: swap
		
	# Create Root partition
	Select "New"
	First sector: <press Enter - use the first availible sector>
	Size in sectors: <press Enter
          for HDD: use the rest of the space
          for SSD use 80% of the rest of the disk space - the rest leave unallocated as overprovisioning>
	Hex code or GUID: <press Enter - 8300>
	Partition name: system

****************************************
LEGACY ONLY

Legacy partitioning procedure. Don't forget to make some overprovisioned space if you are using a SSD (at least 20% of the free space of the system partition)!

	1: type command "cfdisk"
	2: choose dos on next screen
	3: choose "new"
	4: type half the size of ur ram
	5: press enter & choose primary
	6: choose type
	7: choose linux swap / solaris
	8: press "arrow down" and choose "new"
	9: press enter & choose primary
	10: choose bootable
(thx Gregory Nwosibe: https://www.youtube.com/watch?v=Wqh9AQt3nho)	
	
****************************************



Write changes to disk:

	Select "Write"
	yes

	# Quit from cgdisk
	Select "Quit"

Restart the computer:

	reboot

Boot from the USB in the same mode as previously.

Verify if the changes have been successfuly applied:

	lsblk

You should see the new partitions under the name of your disk.
The partitions are useless for now, therefore we need to format them:
# Format EFI partition (if you have any)
	mkfs.fat -F32 /dev/sda1

	# Format Root partition
	mkfs.ext4 -t ext4 -F /dev/sda1
	y

1. [Optional step] Turn on swap:

	mkswap /dev/sdaX
	swapon /dev/sdaX

    Verify, if the changes have been applied:

	lsblk

1. Check partition types
Now we should see partition types (filesystems) next to our new partitions.

    fdisk -l /dev/sda

Now we can proceed with the actual installation of Arch Linux:

	# Mount system partition
	mount /dev/sda2 /mnt

****************************************
UEFI ONLY

	# Mount EFI partition (if you have any)
	mkdir /mnt/boot
	mount /dev/sda1 /mnt/boot
****************************************



Find the fastest mirrors for pacman:

	cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
	
	# Uncomment all servers
	sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup

	# Choose the top 6 mirrors
	rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

****************************************

Install pacman and the base system:

	pacstrap /mnt base

****************************************

Generate filesystem file (fstab) using UUIDs:

	genfstab -U -p /mnt >> /mnt/etc/fstab

Edit "/etc/fstab" file:

	nano /mnt/etc/fstab
	# Replace every "relatime" with "noatime" -> better HDD/SSD IO speed
	# For the boot partition (probably sda1?) change the "rw" to "ro" - more secure booting process and system runtime

****************************************

Chroot into /mnt

    systemd-nspawn -b -D /mnt

	
	
	****************************************
Edit locale setting (system and application language):
	
	nano /etc/locale.gen
	# Uncomment entries "en_US.UTF-8 UTF-8" and "en_US.ISO-8859-1"

Save file (Ctrl + O) and exit (Ctrl + X).
Generate new locale settings
	
	locale-gen
	
	
	

****************************************

Set time:

	cd /usr/share/zoneinfo
	cd Europe
	rm /etc/localtime
	ln -sf /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
	hwclock --systohc

****************************************

Set up hostname

	echo whatever_hostname_you_want > /etc/hostname
	cat /etc/hostname

The hostname will be set after next reboot.

****************************************

Set up pacman repositories:

	nano /etc/pacman.conf
	
	# Uncomment [multilib] repository
	# Add AUR to pacman repositories
	
	[archlinuxfr]
	SigLevel = Never
	Server = http://repo.archlinux.fr/$arch

	
	

	[seblu]
	Server = http://al.seblu.net/$repo/$arch

Save file (Ctrl + O) and exit (Ctrl + X).

Update packages:

	pacman -Syyuu
	# If it will prompt you to install packages press 'y' and then <Enter>

Install yaourt to be able install packages from AUR.
Installation of yaourt is not necessary, but sometimes it makes life much easier.
The "herecura" repository contains precompiled packages from AUR, namely opera-ffmpeg-codecs,
which extends the multimedia functionality of opera browser.
The "seblu" repository contains precompiled Virtualbox Extension Pack (virtualbox-ext-oracle)

For yaourt:

	pacman -S yaourt

Save and exit.

Set up root password:

	passwd
	<type your password>
	<type your password again>

Add a new user account:

	useradd -m -g users -G wheel,storage,power -s /bin/bash laptop

Set up password for the new user:

	passwd laptop
	<type your password>
	<type your password again>

Allow the new user to use the "sudo" command:

        pacman -S --noconfirm sudo

	visudo

	# Find this line:

		## Uncomment to allow members of group wheel to execute any command
		# %wheel ALL=(ALL) ALL

	# and change it - uncomment the wheel line and require the root password:
	
		## Uncomment to allow members of group wheel to execute any command
		%wheel ALL=(ALL) ALL
		Defaults rootpw
                Defaults timestamp_timeout=180

This will allow for the new user to use the "sudo" command but not with the user password! Instead, the root password will be required.

Save and exit

    press (Esc)
    :wq

Install additional packages
    - `dialog` - contains `wifi-menu` utility which interactively connects to the internet
    - `wpa_supplicant` - dependency of  `diaalog`
    - `bash-completion` - complete  commands with `Tab` key

	pacman -S --noconfirm dialog wpa_supplicant bash-completion
	


BOOTLOADER INSTALLATION

****************************************
INTEL CPU ONLY

Install Intel microcode (to improve system stability).

	pacman -S --noconfirm intel-ucode

****************************************

Exit from systemd container

    shutdown now
    
Enter Arch chroot environment beacuse in systemd container the directory `/sys/firmware/efi/efivars` is empty. In `arch-chroot` environment is the directory populated.

    arch-chroot /mnt

****************************************
UEFI ONLY

Mount EFI variables (efivars)
	
	mount -t efivarfs efivarfs /sys/firmware/efi/efivars

Install bootloader (systemd-boot):

	bootctl install

Generate a system partition UUID, i.e. the partition, where you installed the operating system Arch Linux on, and then use it in the bootloader instead of the partition name (more secure):

	# Note: "sda1" is the name of the root partition in this example
	blkid -s PARTUUID -o value /dev/sda2 >> /boot/loader/entries/arch.conf
	
	

	# Output:
	<partuuid_of_root_partition>
	
	

Edit bootloader configuration:

	# Create new file named "arch.conf"
	nano /boot/loader/entries/arch.conf
	
	# Fill it like this (ommit the line with "intel-ucode", if you don't have an Intel CPU):

	title Arch Linux
	linux /vmlinuz-linux
	initrd /intel-ucode.img
	initrd /initramfs-linux.img
	options root=PARTUUID=<partuuid_of_root_partition> rw

****************************************
 
LEGACY ONLY

For legacy system we need to install GRUB bootloader

	pacman -S grub-bios
	y
	grub-install /dev/sda

Generate init file for GRUB
	
	mkinitcpio -p linux
	grub-mkconfig -o /boot/grub/grub.cfg
****************************************

If you got warning messages about missing firmwares, take note which firmwares are you missing. We will install that, after the first login.

Reboot
	exit
	reboot
	# Remove the installation USB now!

If the system doesn't boot AND you have a NVidia graphics card, boot from the USB again and install and configure graphics drivers:

	mount /dev/sda2 /mnt
	mount /dev/sda1 /mnt/boot
	arch-chroot /mnt
	pacman -S nvidia nvidia-libgl lib32-nvidia-libgl nvidia-utils lib32-nvidia-utils
	exit
	reboot

****************************************
FIRST CONSOLE LOGIN

Login as regular user i.e. under `laptop` user account.

Connect to the internet:

    sudo wifi-menu

or

    wpa_supplicant -B -i wlo1 -c <(wpa_passphrase SSID_of_the_network "network password")

Install X server and desktop environment:

    pacman -S --noconfirm lxqt
    
    pacman -S xorg
      
Install graphics drivers (I have integrated Intel graphics):

    1. Uncomment the `[multilib]` repository in `/etc/pacman.conf`
    1. Update package list
    
        sudo pacman -Syyuu
	
	

        pacman -S mesa lib32-mesa xf86-video-intel libva-intel-driver

Now we have to decide, if we want to log in to our computer from
GUI (desktop/login manager - little unstable, but pretty) or from terminal (fast and secure)

****************************************
A: TERMINAL LOGIN

Edit file ~/.xinitrc:

    sudo pacman -S xorg-xinit
    cp /etc/X11/xinit/xinitrc ~
    mv xinitrc .xinitrc #add dot before filename: mv xi<Tab> xi<Tab><Alt+b>.<Enter>
    nano ~/.xinitrc

Find a line (at the end) with
  
    # start some nice programs

At the very end of the file add command to start a destop environment

  exec startlxqt

Save and exit.

Edit file ~/.bash_profile
Add this to the end of the file

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ];
then
  exec startx
fi

This will start X server right after login.
Save, exit.
Reboot.
You will be greeted with a command line login prompt.
Enter your username and password. The desktop environment will start immediately.
Below I provide you with the samples of mentioned files.



~/.xinitrc

#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
#
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
# for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#  [ -x "$f" ] && . "$f"
# done
# unset f
#fi
#
#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

# start desktop environment
exec startlxqt





~/.bash_profile

#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ];
then
  exec startx
fi

****************************************
B: GRAPHICAL LOGIN

ak sa chceme prihlasovat z desktopoveho manazera (graficka prihlasovacia obrazovka),
nainstalujeme SDDM a nechame ho spustat sa po starte systemu:

  pacman -S sddm
  systemctl enable sddm.service


****************************************
POST-INSTALL

Now we all see our desktop environment. 
Let's make some changes.



sudo pacman -S breeze-icons xscreensaver

****************************************
PROXY AND GRAPHICS ACCELERATION

Edit /etc/environment file:

  sudo nano /etc/environment

And edit its content to something like this:

#
# This file is parsed by pam_env module
#
# Syntax: simple "KEY=VAL" pairs on separate lines
#
VDPAU_DRIVER=va_gl
LIBVA_DRIVER_NAME=i965
#http_proxy=http://192.168.0.3:3128/
#https_proxy=http://192.168.0.3:3128/
#ftp_proxy=http://192.168.0.3:3128/
#no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
#HTTP_PROXY=http://192.168.0.3:3128/
#HTTPS_PROXY=http://192.168.0.3:3128/
#FTP_PROXY=http://192.168.0.3:3128/
#NO_PROXY="localhost,127.0.0.1,localaddress,.localdomain.com"

At the top we setting system variables VDPAU and LIBVA to enable graphics acceleration for Intel graphics. Then we set up proxy server address for various protocols.

****************************************
SSD OPTIMIZATION

Open terminal and type:
  sudo systemctl enable fstrim.timer
This will execute TRIM command on all TRIM-capable drives once a week (Periodic TRIM
Periodic TRIM is safer and more supported and less prone to errors than Continuous TRIM.

****************************************
NETWORK MANAGEMENT

You can manage the network interfaces via terminal:
  "wpa_supplicant" (connecting to Wi-Fi access point)
  "iw" (scanning for availible Wi-Fi networks)
For wired connections just use "dhcpcd" :)

If we are not satisfied with manual management of network interfaces,
we can install a Network Manager and its applet (for the notification area):
	pacman -S networkmanager network-manager-applet
	systemctl enable NetworkManager.service

****************************************
XFCE4 CONFIGURATION

Go to Applications menu -> Settings ->

Keyboard
  Layout tab
    Disable "User system defaults"
    Click on "Add" button
    Add German layout
    Click on the button again and add Slovak layout
    Remove English layout
    Change layout option: Alt+Shift

Panel
  Customize it by your liking
  I like to have no Quick Launch icons
  and to the right I have:
    Workspace Switcher
    PulseAudio Plugin (Volume icon)
    Power Manager Plugin (Battery indicator)
    Bluetooth indicator (but it's called "Notification Area (external)")
    Redshift icon
    Keyboar layout switcher
    Clock
    Action Buttons

Power Manager
  General tab
    When power button is pressed: Shutdown (battery and plugged-in)
    When sleep button is pressed: Sleep (battery and plugged-in)
    Turn off the rest.
  Display tab
    Display power management: Off
    Blank after: Never (battery and plugged-in) (Disables automatic screen dimming and turning it off.)
    Reduce after: Never

Removable Drives and Media [Optional]
  Storage tab
    This might be useful for automounting removable devices,
    but I'm using my own scripts (wrappers) to mount and unmount
    removable devices.

    Enable "Mount removable drives when hot-plugged"
    Enable "Mount removable drives when inserted"

Window Manager Tweaks
  Cycling tab
    Enable "Cycle through windows on all workspaces"
    Enable "Cycle through windows in a list"
  Compositor tab
    Disable "Enable display compositing"

Workspaces
  General tab
    Number of workspaces: 2
  Margins tab
    Left margin: 1
    Right margin: 1
  

****************************************
ADDITIONAL PROGRAMS

See "ARCH_installed_packages_user.txt".

For package installation automation, see
  https://bbs.archlinux.org/viewtopic.php?pid=470581#p470581

****************************************
CLEAN-UP

Remove unused packages
  sudo pacman -Rns $(pacman -Qtdq)

Clear cached packages
  sudo pacman -Sc
  :: Do you want to remove all other packages from cache? [Y/n] y
  :: Do you want to remove unused repositories? [Y/n] n


****************************************
TROUBLESHOOTING

Question:
Can't update/upgrade system via pacman. Pacman displays these error messages:

error: Partition /boot is mounted read only
error: not enough free disk space
error: failed to commit transaction (not enough free disk space)
Errors occurred, no packages were upgraded.

Answer:
SEE "ARCH_updating_procedure.txt"


Qusetion:
The USB stick is not mounted automatically nor shown in file manager.
Answer:
See "ARCH_XFCE_enable_trash_automounting_removable_drives.txt"


Question:
Trash is not showing in the file manager or Desktop.
Answer:
See "ARCH_XFCE_enable_trash_automounting_removable_drives.txt"

****************************************
Sources:
	GloriousEggroll - 2017 Arch Linux EFI Install Guide
		https://www.youtube.com/watch?v=iF7Y8IH5A3M

	GloriousEggroll - 2016 Arch Linux EFI Install Guide Part 1 - Preparation and Disk Partitioning
		https://www.youtube.com/watch?v=MMkST5IjSjY
	
	GloriousEggroll - 2016 Arch Linux EFI Install Guide Part 2 - Installing Arch and Making it Boot
		https://www.youtube.com/watch?v=0WBB8v-tiz8
	
	GloriousEggroll - 2016 Arch Linux EFI Install Guide Part 3 - Making it user friendly and adding a desktop environment
		https://www.youtube.com/watch?v=n5UK66GF99A
	
	GloriousEggroll - 2016 Arch Linux NetworkManager / Wifi Setup guide.
		https://www.youtube.com/watch?v=MAi9DurTRQc

	goguda55 Tech Tutorials - How to Install Arch Linux
		https://www.youtube.com/watch?v=Wqh9AQt3nho

	https://wiki.archlinux.org/index.php/Solid_State_Drives#Periodic_TRIM
	https://www.digitalocean.com/community/tutorials/how-to-configure-periodic-trim-for-ssd-storage-on-linux-servers
	https://wiki.archlinux.org/index.php/pacman#Cleaning_the_package_cache
	https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Removing_unused_packages_.28orphans.29
	https://apple.stackexchange.com/questions/10139/how-do-i-increase-sudo-password-remember-timeout/51763#51763
	https://wiki.archlinux.org/index.php/Hardware_video_acceleration#VA-API_drivers
	https://wiki.archlinux.org/index.php/Intel_graphics#Installation
	https://wiki.archlinux.org/index.php/Environment_variables#Defining_variables
	https://wiki.archlinux.org/index.php/Xinit#xinitrc
