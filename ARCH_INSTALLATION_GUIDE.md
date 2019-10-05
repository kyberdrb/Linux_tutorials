# Arch Linux Installation

## Create a bootable Arch Linux USB

1. Download Arch Linux ISO

1. Clone it on the USB drive

    - Linux
        Preferred method: `dd`
	
	1. Find the name of the USB stick
    
            lsblk
	    
	1. Clone the Arch ISO on it
	
            sudo dd if=arch.iso of=/dev/sdb
    
    - Windows
    
        - Preferred method: [Rufus](https://wiki.archlinux.org/index.php/USB_flash_installation_media#Using_Rufus)

## Boot from the USB

1. Plug the USB drive into a PC and boot from it. Keep pressing F8 / F9 / F12 to get boot device selection menu or go straight to BIOS and change boot settings there. I recommend booting the USB and installing Arch Linux in UEFI mode. The booting mode can be set in the BIOS.
    1. If your computer (like mine laptop HP 4530s) doesn't offer you a UEFI boot option for your USB, only the _Legacy_ one, boot from `EFI/boot/loader.efi` these steps to boot the USB in UEFI mode (make sure UEFI booting is enabled in the BIOS):
        1. Rapidly press F9
        1. Choose `Boot From EFI File`
        1. Choose option `ARCHISO_EFI_...`
        1. Select `EFI -> boot -> loader.efi`
    
    Now the USB will boot in UEFI mode a shortly you will see the ARCH EFI bootloader.

1. After you get the Arch Linux boot screen, choose `Boot Arch Linux x86_64`

## Connect to the Internet

1. To install Arch Linux you need to have Internet connection. It's recommended to use the Ethernet, but Wi-Fi connection is also possible, if your wireless adapter is supported. Below I will explain how to connect to the Internet via Ethernet and Wi-Fi.

    1. List all your wired and wireless network adapters
	
	        ip link
    
    1. Connect to the internet. Below are the steps for connecting to the wireless and wired network
        - Connect to a Wi-Fi network
    
            1. Execute command

                    wifi-menu
    
            1. Choose the network, confirm profile name and enter password. The Wi-Fi adapter is turned on automatically by the command and the IP address is obtained automatically as well via DHCP.

        - Connect to a wired network
            The Ethernet should be named similar to `enpXsY` where X and Y are numbers. Wireless adapters have a name in format similar to `wloZ` where Z is a number. Then you need to request an IP address via DHCP
	
	            dhcpcd enpXsY

            an IP address should be assigned to the Ethernet interface.
	    For manual IP configuration see [Arch Linux Wiki - Network configuration](https://wiki.archlinux.org/index.php/Network_configuration#Static_IP_address)

    1. Test connectivity:
	
            ping google.com -c 4

        If the ping was successful, we can proceed with Arch Linux installation.

## Check UEFI mode

Now we neet do decide, if we want legacy or EFI install of Arch Linux. If you chose "UEFI" in the boot device selection earlier, read on, otherwise skip this part.

If you choosed to boot from USB in UEFI mode, check the list of EFI variables to see, if Arch Linux can be installed in UEFI mode:
	
	efivar -l

If it lists variables, you can install Arch Linux in UEFI mode :D
If it doesn't list any variables or prints an error "efivar: error listing variables: Function not implemented", it means, that either we booted into legacy mode, or our UEFI is not supported.

Now we can continue with the disk partitioning

## Partition the disks

First of all, we have to choose the disk, which Arch Linux will be installed on. Print the list of connected disks with command:

	lsblk

Let's say, we want to install Arch on disk "sda".
Firstly, we need to wipe the disk:

	sgdisk --zap-all /dev/sda
	
The target disk is now clean. We can proceed to the disk partitioning.

### UEFI partitioning

For UEFI install it will be partitioned like this:

	boot (EFI), Swap, Root

#### via `sgdisk` (preferred)

    sgdisk --clear /dev/sda
    sgdisk --new=1:0:+600MiB --typecode=1:ef00 /dev/sda    
    sgdisk --new=2:0:+210GiB --typecode=2:8300 /dev/sda

#### via `cgdisk`

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
	Hex code or GUID: <press Enter - 8300>
	Partition name: system
	
Write changes to disk:

	Select "Write"
	yes

	# Quit from cgdisk
	Select "Quit"

### Legacy partitioning

For legacy install it will be partitioned like this:

	Swap, Root

Remember to make some overprovisioned space if you are using a SSD (at least 20% of the free space of the system partition)!

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

Write changes to disk:

	Select "Write"
	yes

Quit from cfdisk

	Select "Quit"

## Verify created partitions

Verify if the changes have been successfuly applied:

	lsblk

You should see the new partitions under the name of your disk.

## Format partitions

1. Format EFI partition (if you have any)

        mkfs.fat -F32 /dev/sda1
	
Format system partition

        mkfs.ext4 -t ext4 -F /dev/sda2
        y

1. [Optional step] Turn on swap:

        mkswap /dev/sdaX
        swapon /dev/sdaX

1. Verify, if the changes have been applied:

        lsblk

1. Check partition types. Now we should see partition types (filesystems) next to our new partitions.

        fdisk -l /dev/sda

## Mount partitions

Mount system partition

    mount /dev/sda2 /mnt

### UEFI ONLY

Mount EFI partition

    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot

## Select the fastest repository servers

Update package database

        pacman - Syy
	
Install `reflector`
	
	pacman -S reflector

Backup original pacman's mirror list

	cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

Create new mirror list. The servers which we will provide the fastest speed for downloading packages will be on the top of the list.

        reflector --sort rate > /etc/pacman.d/mirrorlist
	
The command can take a while to finish depending on the speed of your internet connection.

https://wiki.archlinux.org/index.php/mirrors#Server-side_ranking

## Install Arch Linux

Install pacman and the base system:

	pacstrap /mnt base

## Generate filesystem table

fstab using UUIDs:

	genfstab -U -p /mnt >> /mnt/etc/fstab

Edit "/etc/fstab" file:

	nano /mnt/etc/fstab
	# Replace every "relatime" with "noatime" -> better HDD/SSD IO speed
	# For the boot partition (probably sda1?) change the "rw" to "ro" - more secure booting process and system runtime

****************************************

Chroot into /mnt using systemd containers

    systemd-nspawn -b -D /mnt

Login as `root`

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

	pacman -Syy

Install updates

        pacman -Syu
	# If it will prompt you to install packages press 'y' and then <Enter>

The "seblu" repository contains precompiled Virtualbox Extension Pack (virtualbox-ext-oracle)

The "herecura" repository contains precompiled packages from AUR, namely opera-ffmpeg-codecs,
which extends the multimedia functionality of opera browser.

## Set up root password:

	passwd
	<type your password>
	<type your password again>

## Add a new user account:

	useradd -m -g users -G wheel,storage,power -s /bin/bash laptop

## Set up password for the new user:

	passwd laptop
	<type your password>
	<type your password again>

## Allow the new user to use the `sudo` command:

1. Install `sudo`

        pacman -S sudo

1. Allow the user to use `sudo` command

        visudo

1. Find this line:

        ## Uncomment to allow members of group wheel to execute any command
        # %wheel ALL=(ALL) ALL

1. Change it by uncommenting the `wheel` line and require the root password:
	
		## Uncomment to allow members of group wheel to execute any command
		%wheel ALL=(ALL) ALL
		Defaults rootpw
                Defaults timestamp_timeout=180

This will allow for the new user to use the `sudo` command but not with the user password! Instead, the root password will be required. The root password will be valid for `180` minutes.

Save and exit

    press (Esc)
    :wq

### Install additional packages

I need these packages beacuse they simplify the work at first login.

- `dialog` - contains `wifi-menu` utility which interactively connects to the internet
- `wpa_supplicant` - dependency of  `diaalog`
- `bash-completion` - complete  commands with `Tab` key
- `vim` - text editor

        pacman -S dialog wpa_supplicant bash-completion vim

BOOTLOADER INSTALLATION

****************************************
INTEL CPU ONLY

Install Intel microcode (to improve system stability).

    pacman -S intel-ucode

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

    echo "title Andrej" >> /boot/loader/entries/arch.conf
    basename /boot/vmlinuz-linux >> /boot/loader/entries/arch.conf
    basename /boot/intel-ucode.img >> /boot/loader/entries/arch.conf
    basename /boot/initramfs-linux.img >> /boot/loader/entries/arch.conf
    blkid -s PARTUUID -o value /dev/sda2 >> /boot/loader/entries/arch.conf

Open boot configuration file

    # Create new file named "arch.conf"
    nano /boot/loader/entries/arch.conf
	
Edit bootloader configuration like it is shown below. Ommit the line with "intel-ucode", if you don't have an Intel CPU.

    title Andrej
    linux /vmlinuz-linux
    initrd /intel-ucode.img
    initrd /initramfs-linux.img
    options root=PARTUUID=d65b559b-fe10-43e8-8853-09f55b3fa25d rw

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

# Arch Linux Configuration - move to a separate file

FIRST CONSOLE LOGIN

Login as regular user i.e. under `laptop` user account.

Connect to the internet:

    sudo wifi-menu

or

    wpa_supplicant -B -i wlo1 -c <(wpa_passphrase SSID_of_the_network "network password")
    
Set time:

    sudo ln -sf /usr/share/zoneinfo/Europe/Bratislava /etc/localtime
    sudo hwclock --systohc
    
## Create `vim` configuration

- Create `vim` config file with these contents

        $ vim ~/.vimrc

        set tabstop=4
        set shiftwidth=4
        set expandtab


## Select language

Edit locale setting (system and application language):
	
	sudo nano /etc/locale.gen
	# Uncomment entries "en_US.UTF-8 UTF-8" and "en_US.ISO-8859-1"

Save file (Ctrl + O) and exit (Ctrl + X).
Generate new locale settings
	
	sudo locale-gen
	sudo localectl set-locale LANG=en_US.UTF-8
	
If the `localectl` command wouldn't be issued, we would see in the desktop environment meaningless characters

## Install X server
    
    sudo pacman -S xorg
      
## Install graphics drivers

I have integrated graphics on Intel Skylake platform.

Basic packages for Intel graphics

    pacman -S mesa lib32-mesa xf86-video-intel vulkan-intel


## Install desktop environment

XFCE4

    sudo pacman -S xfce4 xfce4-goodies

## Login

Now we have to decide, if we want to log in to our computer from
GUI (desktop/login manager - little unstable, but pretty) or from terminal (fast and secure)

### TERMINAL LOGIN

#### Edit file `~/.xinitrc`

        sudo pacman -S xorg-xinit
        cp /etc/X11/xinit/xinitrc ~
        mv xinitrc .xinitrc #add dot before filename: mv xi<Tab> xi<Tab><Alt+b>.<Enter>
        nano ~/.xinitrc

1. Delete everything after the `fi` i.e. after the end of the condition after the line `# start some nice programs`.

1. At the very end of the file add command to start a destop environment

        exec startlxqt

    or

        exec startxfce4
    
    depending on which desktop environment is installed.

1. Save and exit.

Sample `~/.xinitrc`

    $ cat ~/.xinitrc

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

    if [ -d /etc/X11/xinit/xinitrc.d ] ; then
     for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
      [ -x "$f" ] && . "$f"
     done
     unset f
    fi

    exec startxfce4

#### Edit file `~/.bash_profile`

`TODO nano...`

Add this to the end of the file

    exec startx

This will start X server right after login.
Save, exit.

Sample `~/.bash_profile`

    $ cat ~/.bash_profile

    #
    # ~/.bash_profile
    #
    
    [[ -f ~/.bashrc ]] && . ~/.bashrc
    
    exec start

1. Reboot

        reboot

    You will be greeted with a command line login prompt.

    Enter your username and password. The desktop environment will start immediately.

## AUR helper utility

I'll install `pikaur` beacuse It's convenient for me to use.

### Installation

Prepare packages for `pikaur`

    sudo pacman -S openssh git base-devel

- Installation: 
        
        cd /tmp
        git clone https://github.com/actionless/pikaur.git
        cd pikaur
        makepkg -fsri
	
    Reinstall `pikaur` by itself
    
        pikaur -S pikaur
        
    Source: https://github.com/actionless/pikaur#installation
      
### Configuration

Create `pikaur` config file

        $ vim ~/.config/pikaur.conf
    
        [sync]
        alwaysshowpkgorigin = no
        develpkgsexpiration = -1
        upgradesorting = versiondiff
        showdownloadsize = no

        [build]
        keepbuilddir = no
        keepdevbuilddir = yes
        skipfailedbuild = no
        alwaysusedynamicusers = no

        # changed from default
        noedit = yes

        # changed from default
        donteditbydefault = yes

        # changed from default
        nodiff = yes

        gitdiffargs = --ignore-space-change,--ignore-all-space

        [colors]
        version = 10
        versiondiffold = 11
        versiondiffnew = 9

        [ui]
        requireenterconfirm = yes
        diffpager = auto
        printcommands = no
        reversesearchsorting = no

        [misc]
        sudoloopinterval = 59
        pacmanpath = pacman
        aurhost = aur.archlinux.org
        newsurl = https://www.archlinux.org/feeds/news/

        [network]
        socks5proxy = 
            
    Source: https://github.com/actionless/pikaur#configuration
    
**From now on, I only use `pikaur` to manage all my packages instead of `pacman`.**

## Enable hardware acceleration for graphics

Hardware acceleration for Intel graphics for my new laptop

    sudo pacman -S intel-media-driver libvdpau-va-gl

Open the file with environment variables

    sudo vim /etc/environment

Enable hardware for intel acceleration

    VDPAU_DRIVER=va_gl
    LIBVA_DRIVER_NAME=iHD
    
Reboot to activate hardware acceleration
    
## Verify hardware acceleration for graphics

Install verification utilities

    sudo pacman -S libva-utils vdpauinfo
    
Check `VAAPI` and `VDPAU` configuration

    $ vainfo
    
    vainfo: VA-API version: 1.5 (libva 2.5.0)
    vainfo: Driver version: Intel iHD driver - 1.0.0
    vainfo: Supported profile and entrypoints
          VAProfileNone                   :	VAEntrypointVideoProc
          VAProfileNone                   :	VAEntrypointStats
          VAProfileMPEG2Simple            :	VAEntrypointVLD
	  
---

    $ vdpauinfo
    
    display: :0.0   screen: 0
    API version: 1
    Information string: OpenGL/VAAPI backend for VDPAU
    
    Video surface:
    
    name   width height types
    -------------------------------------------
    420     4096  4096  NV12 YV12 UYVY YUYV Y8U8V8A8 V8U8Y8A8 
    422     4096  4096  NV12 YV12 UYVY YUYV Y8U8V8A8 V8U8Y8A8 
    444     4096  4096  NV12 YV12 UYVY YUYV Y8U8V8A8 V8U8Y8A8 
    
    Decoder capabilities:
    
    name                        level macbs width height
    ----------------------------------------------------
    MPEG1                          --- not supported ---
    MPEG2_SIMPLE                   --- not supported ---
    MPEG2_MAIN                     --- not supported ---
    H264_BASELINE                  51 16384  2048  2048
    H264_MAIN                      51 16384  2048  2048
    H264_HIGH                      51 16384  2048  2048
    
## Sound

Install sound server and graphical front-end

    pikaur -S pulseaudio pavucontrol alsa-utils
    alsactl restore
    
Installing `alsa-utils` package and issuing command `alsactl restore` enlived the audio output from the headphone jack on `Dell Latitude E5470`.
    
Reboot

    reboot
    
Sources:
- https://bbs.archlinux.org/viewtopic.php?pid=1749454#p1749454
- https://www.reddit.com/r/archlinux/comments/7ahv5n/linux_41310_no_audio/?st=ja1l4lq2&sh=65b079bd
- https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture#ALSA_Utilities
    
## Enable tap-to-click and natural scrolling for touchpad

1. List IDs of all input devices

        $ xinput list
        
        ...
        ⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
        ⎜   ↳ AlpsPS/2 ALPS DualPoint Stick           	id=13	[slave  pointer  (2)]
        ⎜   ↳ AlpsPS/2 ALPS DualPoint TouchPad        	id=14	[slave  pointer  (2)]
        ...

1. Identify the touchpad device

    This line is telling me the ID of the touchpad device which is `14`:

    **AlpsPS/2 ALPS DualPoint TouchPad        	id=14	[slave  pointer  (2)]**

1. List the capabilities of the touchpad

        $ xinput list-props 14

        Device 'AlpsPS/2 ALPS DualPoint TouchPad':
            Device Enabled (165):	1
            Coordinate Transformation Matrix (167):	1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
            libinput Tapping Enabled (318):	0
            ...
            libinput Natural Scrolling Enabled (300):	0
            ...
	    
1. Enable `Tapping` and `Natural Scrolling`

        xinput set-prop 14 318 1
        xinput set-prop 14 300 1

1. Verify touchpad settings

        $ xinput list-props 14

        Device 'AlpsPS/2 ALPS DualPoint TouchPad':
            Device Enabled (165):	1
            Coordinate Transformation Matrix (167):	1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
            libinput Tapping Enabled (318):	1
            ...
            libinput Natural Scrolling Enabled (300):	1
            ...

1. Add it to autostart
    - XFCE4
        1. Go to `Applications -> Settings -> Session and Startup`
	1. Tab `Application Autostart`
	1. Click on `Add` button
	1. Create a _tap-to-click_ startup task
	    - **Name:** `Touchpad: tap-to-click`
	    - **Command:** `xinput set-prop 14 318 1`
	    - ***Trigger:* `on login`
	1. Create a _natural scrolling_ startup task
	    - **Name:** `Touchpad: tap-to-click`
	    - **Command:** `xinput set-prop 14 300 1`
	    - ***Trigger:* `on login`
	    
	1. Log out and back in to verify the startup tasks are effective.

Sources:
- https://askubuntu.com/questions/1087328/lubuntu-18-10-how-to-activate-tap-to-click/1089387#1089387
- https://wiki.archlinux.org/index.php/Libinput#Via_xinput

****************************************
POST-INSTALL

Now we all see our desktop environment. 
Let's make some changes.



sudo pacman -S breeze-icons xscreensaver

****************************************
PROXY

Edit /etc/environment file:

  sudo nano /etc/environment

And edit its content to something like this:

    <snip>
    #http_proxy=http://192.168.0.3:3128/
    #https_proxy=http://192.168.0.3:3128/
    #ftp_proxy=http://192.168.0.3:3128/
    #no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    #HTTP_PROXY=http://192.168.0.3:3128/
    #HTTPS_PROXY=http://192.168.0.3:3128/
    #FTP_PROXY=http://192.168.0.3:3128/
    #NO_PROXY="localhost,127.0.0.1,localaddress,.localdomain.com"
    <snip>

At the top we setting system variables VDPAU and LIBVA to enable graphics acceleration for Intel graphics. Then we set up proxy server address for various protocols.

****************************************
SSD OPTIMIZATION

Open terminal and type:
  sudo systemctl enable fstrim.timer
This will execute TRIM command on all TRIM-capable drives once a week (Periodic TRIM
Periodic TRIM is safer and more supported and less prone to errors than Continuous TRIM.

****************************************
## NETWORK MANAGEMENT

### Terminal

I manage all networks in terminal.

For wireless networks I use `wifi-menu`.

For wired networks I use `dhcpcd`.

### Graphical

If we need to connect to the `eduroam` network, or to connect to the Ethernet automatically on plugging in the cable we can install a `Network Manager` utility together with its applet for the notification area

    pacman -S networkmanager network-manager-applet
    systemctl enable NetworkManager.service
    reboot
    
#### Connect to `eduroam` network

I failed to connect to the `eduroam` network with `wpa_supplicant` with a configuration generated by the `Configuration Assistant Tool` from [eduroam webpage](https://cat.eduroam.org).

This is a case where the `Network Manager` helped me to connect to the network.

I used these settings:
- Security: `WPA & WPA2 Enterprise`
- Authentication: `Protected EAP (PEAP)`
- Anonymous identity: `<I've left this field blank>`
- Domain: `<I've left this field blank>`
- Check `No CA certificate is required`
- PEAP version: `Automatic`
- Inner authentication: `MSCHAPv2`
- Username: `<student_id>@uniza.sk`
- Password: `<LDAP_password>`

## XFCE4 CONFIGURATION

- Terminal
    1. Open Terminal (Ctrl + Alt + T) 
    1. `Edit -> Preferences`
    1. Tab `General`
        1. Uncheck `Show unsafe paste dialog`
    1. Tab `Appearance`
        1. Font
            1. Click on font
            1. Find `Monospace Bold`
            1. Set the font size to `14`
            1. Close the dialog window
        1. Tabs
            1. Check option `Use custom styling to make tabs slim`
        1. Close the Preferences window
        1. Check the settings by reopening a terminal window

- Desktop
    1. Go to the Desktop (Ctrl + Alt + D)
    1. Right click on empty space on the Desktop
    1. Choose `Desktop Settings`
    1. Background
        1. `Style:` None
        1. `Color:` Solid color
        1. Click on the first color box next to `Color` menu
        1. Choose _black_ color
        1. Select
    1. Icons
        1. Appearance
            1. `Icon type:` None
	    
    1. Go back to the Desktop
    1. Right click on the bottom panel
    1. Navigate to `Panel -> Panel Preferences`
    1. On the top of the dialog window click on a button with a minus sign on it. This will remove the panel.

### Quick connecting to a network

1. Open application finder

        Alt + F2

    - Wireless network

            xfce4-terminal -e 'bash -c "sudo wifi-menu"'
	
    - Ethernet

            xfce4-terminal -e 'bash -c "sudo dhcpcd enp0s31f6"'

First time you need to execute the entire command.

Next time it will be enough to type `wifi`. The command pops-up below the command line.

Source: https://askubuntu.com/questions/980720/open-xfce-terminal-window-and-run-command-in-same-window/983865#983865

---

1. Go to `Applications menu -> Settings`

- Session and Startup
    1. Tab `Application Autostart`
        1. `Add`
            - `Name:` Redshift
            - `Command:` `redshift`
            - `Trigger:` on login

- Keyboard
    - `Layout` tab
        1. Uncheck `User system defaults`
        1. Change layout option: Alt+Shift
        1. Click on "Add" button
        1. Add German layout
        1. Add a Slovak layout the same way
        1. Remove English layout

- Panel
    - `Items` tab
        - Workspace Switcher
        - PulseAudio Plugin - Volume icon
        - Power Manager Plugin - Battery indicator
        - Clock
        - Keyboar layout switcher

- Power Manager
    - `General` tab
        - Buttons
            - When power button is pressed: Shutdown (battery and plugged-in)
            - When sleep button is pressed: Suspend (battery and plugged-in)
            - Set the rest of the actions to `None`.
	    - Enable `Handle display brightness keys`. This prevents from occasional brigntness-key-blocking.
        - Laptop Lid
            - When laptop lid is closed: Suspend (battery and plugged-in)
    - `System` tab
        - Critical power
            - On critical battery power: `Ask`
    - `Display` tab
        - Display power management
	    - set everything to `Never`

- Removable Drives and Media [Optional]
    - Storage tab
        - Enable `Mount removable drives when hot-plugged`
        - Enable `Mount removable drives when inserted`

- Window Manager Tweaks
    - Cycling tab
        - Enable `Cycle through windows on all workspaces`
        - Enable `Cycle through windows in a list`

- Workspaces
    - General tab
        - Number of workspaces: `2`
    - Margins tab
        - Left margin: `1`
        - Right margin: `1`

## Additional programs

See "ARCH_installed_packages_user.txt".

For package installation automation, see
  https://bbs.archlinux.org/viewtopic.php?pid=470581#p470581
  
### Automount devices and enable Trash

Install required packages

    pikaur -S gvfs
  
For automounting mobile devices:

    pikaur -S gvfs-mtp gvfs-gphoto2

1. Go to `Applications menu -> Settings -> Removable Drives and Media`
1. check `Mount removable drives when hot-plugged` and `Mount removable media when inserted`
1. Disconnect the removable disk, if it's connected.
1. Plug in your removable device.
1. Open file manager.

The removeable device will appear in the left column.


If not, you can still mount the drive manually via terminal:

Check, which label corresponds your USB stick

  lsblk
or
  sudo fdisk -l

Then mount it

  gvfs-mount -d /dev/sdX#

where X is the drive name and # is the partition number, e.g.

  gvfs-mount -d /dev/sdb1


Sources:
  https://forum.voidlinux.eu/t/solved-xfce-missing-trash-and-other-icons-on-the-desktop/2010/2
  https://bbs.archlinux.org/viewtopic.php?pid=1608701#p1608701
  https://docs.xfce.org/xfce/thunar/using-removable-media
  https://www.youtube.com/watch?v=fYlBVkB1gn4

## Updating

    cat update_arch.sh

    #!/bin/bash

    PIKAUR_INSTALLED=$(pacman -Q | grep pikaur)
    if [[ -z $PIKAUR_INSTALLED ]]; then 
        rm -rf /tmp/pikaur-git
        mkdir /tmp/pikaur-git
        curl https://aur.archlinux.org/cgit/aur.git/snapshot/pikaur-git.tar.gz --output /tmp/pikaur-git.tar.gz
        tar -xvzf /tmp/pikaur-git.tar.gz --directory /tmp/pikaur-git
        cd /tmp/pikaur-git/pikaur-git
        makepkg --ignorearch --clean --syncdeps --noconfirm
        PIKAUR_PACKAGE_NAME=$(ls *.tar*)
        sudo pacman -U $PIKAUR_PACKAGE_NAME --noconfirm
        rm -rf /tmp/pikaur-git
    fi

    rm -rf ~/.libvirt
    pikaur -Syyuu
    pikaur -Scc --noconfirm

    COMMAND=$1
    SHUTDOWN_TIME=$2
    if [[ $COMMAND == "--shutdown" ]]; then
        shutdown $SHUTDOWN_TIME
    fi


## Troubleshooting

Question:
Can't update/upgrade system via pacman. Pacman displays these error messages:

error: Partition /boot is mounted read only
error: not enough free disk space
error: failed to commit transaction (not enough free disk space)
Errors occurred, no packages were upgraded.

Answer:
Also see `ARCH_updating_procedure.txt`

## Sources

[GloriousEggroll - 2017 Arch Linux EFI Install Guide](https://www.youtube.com/watch?v=iF7Y8IH5A3M)
- GloriousEggroll - 2016 Arch Linux EFI Install Guide Part 1 - Preparation and Disk Partitioning: https://www.youtube.com/watch?v=MMkST5IjSjY
- GloriousEggroll - 2016 Arch Linux EFI Install Guide Part 2 - Installing Arch and Making it Boot: https://www.youtube.com/watch?v=0WBB8v-tiz8
- GloriousEggroll - 2016 Arch Linux EFI Install Guide Part 3 - Making it user friendly and adding a desktop environment: https://www.youtube.com/watch?v=n5UK66GF99A
- GloriousEggroll - 2016 Arch Linux NetworkManager / Wifi Setup guide: https://www.youtube.com/watch?v=MAi9DurTRQc
- goguda55 Tech Tutorials - How to Install Arch Linux: https://www.youtube.com/watch?v=Wqh9AQt3nho
- https://wiki.archlinux.org/index.php/Solid_State_Drives#Periodic_TRIM
- https://www.digitalocean.com/community/tutorials/how-to-configure-periodic-trim-for-ssd-storage-on-linux-servers
- https://wiki.archlinux.org/index.php/pacman#Cleaning_the_package_cache
- https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Removing_unused_packages_.28orphans.29
- https://apple.stackexchange.com/questions/10139/how-do-i-increase-sudo-password-remember-timeout/51763#51763
- https://wiki.archlinux.org/index.php/Hardware_video_acceleration#VA-API_drivers
- https://wiki.archlinux.org/index.php/Intel_graphics#Installation
- https://wiki.archlinux.org/index.php/Environment_variables#Defining_variables
- https://wiki.archlinux.org/index.php/Xinit#xinitrc

