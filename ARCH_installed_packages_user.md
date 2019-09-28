**  PACMAN **

* pulseaudio -> audio server
* pavucontrol/pavucontrol-qt -> pulseaudio frontend (gui)
* chromium - web browser; for video hardware acceleration see https://wiki.archlinux.org/index.php/Chromium#Hardware_video_acceleration
* openssh -> SSH client and server
* git -> recover the ~/.gitconfig file; generate a new SSH key
    - https://help.github.com/en/enterprise/2.16/user/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent  
    - https://help.github.com/en/articles/connecting-to-github-with-ssh
* base-devel - development tools for Arch Linux
* pikaur -> AUR helper utility; the only AUR helper I need
    - Installation: 
        
            cd /tmp
            git clone https://aur.archlinux.org/pikaur.git
            cd pikaur
            makepkg -fsri
        
        Source: https://github.com/actionless/pikaur#installation
        
    - Configuration
    
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

---

* aic94xx-firmware wd719x-firmware - missing firmwares for my laptop
dnsmasq -> internet connectivity support tool for LXC NAT bridge interface
* code - Visual Studio Code (VS Code) - multiplatform development editor/tool
* gvim - graphical vim text editor

* dmidecode - RAM info
* lxqt - LXQt desktop environment: REMOVE `pcmanfm-qt` and replace it by `thunar` as a file manager
mousepad -> po instalacii otvorit mousepad, ist do Edit->Preferences->View->Colour scheme->Cobalt (biele pismena na ciernom pozadi)
musescore
* ntfs-3g -> NTFS support

openvswitch -> virtual switch for bridging VMs and containers
opera-ffmpeg-codecs -> predkompilovane na herecura repozitari - kodeky na podporu videoformatov vratane 60fps videi
* p7zip -> command line extraction utility
* parallel - parallelize shell commands

pepper-flash -> podpora adobe flash - security risk; often used by TV streaming

* pulseaudio-bluetooth -> umozni prehravat hudbu od inych zariadeni cez bluetooth

* soundwire pulseaudio-alsa lib32-libpulse lib32-alsa-plugins - SoundWire and its dependencies; enables the use of an Android phone as a wireless speaker; Configuration: open _PulseAudio_ GUI `pavucontrol[-qt]` -\> Recording tab -\> ALSA Capture from `Monitor of Built-in Audio Analog Stereo`

qemu -> generic virtualizer
* redshift / redshift-qt -> color temperature changer (spares eyes) -> run on background in tray with "redshift-gtk&" -> right click on the tray icon and enable Autostart; create configuration file by https://github.com/jonls/redshift/blob/master/redshift.conf.sample; change `temp-day` and `temp-night` to `1800`, `fade` to `0` - TODO add entire config file
shotwell -> image viewer with nice features (crop, rotate, ...)
tigervnc -> VNC client and server
* thunar - favorite file manager
tmux -> Terminal MUltipleXor - watch multiple terminals in one SSH session
* transmission-gtk / transmission-qt -> torrent klient
tk -> tkinter library for Python
unrar -> needed for dtrx to extract RAR archives
* virtualbox -> zvolit "virtualbox-host-modules-arch". po instalacii vykonat prikaz: gpasswd -a $USER vboxusers
* virtualbox-ext-oracle
* virtualbox-guest-iso
virt-manager -> front-end ku QEMU
* vlc -> multimedia player
wget -> terminal downloader utility
* wpa_supplicant -> utility to connect to Wi-Fi networks with WPA/WPA2 encryption
* xclip - terminal clipboard manipulation utility
* xorg-apps - additional utilities for easier Xorg management e.g. brightness adjustment etc.

xfce4
xfce4-pulseaudio-plugin -> Volume control in notification tray
xfce4-screenshooter -> Screenshots for XFCE; to enable PrintScreen key go to Application Menu -> Keyboard -> Application Shortcuts tab -> Add button -> as command enter "xfce4-screenshooter" without quotes -> as key press "PrintScreen (PrtSc)" key.
xfce4-xkb-plugin -> Keyboard layout changer in notification tray

* p7zip - archive manipulation utility
audacity -> audio editing software
bc- > command line calculator => set default scale (decimal precision) - https://askubuntu.com/questions/621017/how-to-set-default-scale-for-bc-calculator
blueman -> then execute: su -c 'systemctl enable bluetooth.service' -> this will enable the Bluetooth icon in notification tray
* evince/okular -> PDF readers; Evince for GTK, Okular for Qt (backend: phonon-qt5-vlc)
* filezilla -> FTP client
* firefox -> recover the ~/.config/mozilla directory

gparted -> disk and partition manager
* gvfs -> enables Trash icon/functionality (trash virtual file system) and automatic mounting of system drives
* gvfs-mtp -> automouning MTP devices, such as smartphones
* gvfs-gphoto2 -> automounting PTP devices, such as cameras
android-file-transfer - transfer data with a mobile device via MTP
* android-tools - Android platform tools; `adb` etc.; make sure to have "USB Debugging" activated on Android device otherwise it will be hidden from `adb devices` command

iw -> Sprava bezdrotovych adapterov (skenovanie Wi-Fi sieti)
* libreoffice-still - office suite

- GRAPHICS DRIVERS
* lib32-mesa -> Intel grafika
* libva-intel-driver -> video hardware acceleration for Intel graphics; for my laptop it is SandyBridge integrated graphics
* mesa -> Intel graphics driver
* xf86-video-intel -> Intel grafika

-VIRTUALIZATION
lxc -> base LXC support
arch-install-scripts -> base LXC support
debootstrap -> support for Debian based LXC containers in Arch Linux
docker -> base Docker support

dtrx -> command line extraction utility
etcher -> bootable USB creator; replacement for dd
google-chrome
* otf-sans-forgetica - font for better memorizing; setup for XFCE4: https://docs.xfce.org/xfce/xfce4-settings/appearance#fonts; setup for Chromium: https://www.techadvisor.co.uk/how-to/software/how-change-font-in-google-chrome-3606119/
skypeforlinux-bin -> skype-legacy sa neda uz nainstalovat - neda sa skompilovat qt4 modul
teamviewer -> na ovladanie vzdialenych ploch - aj pre android :D (https://crazytechtricks.com/remote-control-android-phone-from-another-android-without-root-download-best-apps/)

-DEVELOPMENT
pycharm-professional -> Python/HTML/CSS/JS IDE from JetBrains; the community edition is good, but is lacking the "code coverage" functionality; needs to be activated - use one of the "jetbrains activation servers" << google that ;) or http://xidea.online/servers.html
mono - c# support for linux - see "https://wiki.archlinux.org/index.php/mono" for compilation and run instructions
python -> python3 support
python-xdg -> dependency for redshift-gtk (tray icon) to launch and run correctly
python-virtualenv python2-virtualenv -> virtualne prostredia pre python2 a python3
python-coverage python2-coverage: For support code coverage measurement for Python 2

* clion clion-cmake clion-gdb clion-jre clion-lldb gtest - C/C++ IDE from JetBrains with bundled toolchains and Google Test Framework; all packages must be installed to have a fully functional IDE
perf - profiling tool for Linux kernel; useful for CLion; set it up in CLion under "File -> Settings -> Build, Execution, Deployment -> Dynamic analysis tools" - run profiler via "Run -> Profile '<ProjectName>'"
* valgrind - memory leaks test; useful for CLion; set it up in CLion under "File -> Settings -> Build, Execution, Deployment -> Dynamic analysis tools" - run Valgrind via "Run -> Run '<ProjectName>' with Valgrind Memcheck"

-LXC/LXD containers support
yum -> support for Fedora based LXC containers in Arch Linux
lxd -> base LXD support

**  MANUALNE Z INTERNETU **
pycharm -> skopirovat do /opt adresara
vmware -> bud player alebo workstation


Sources:
XFCE Screenshot utility - https://ubuntuforums.org/showthread.php?t=1716649
SoundWire - https://bbs.archlinux.org/viewtopic.php?pid=1514780#p1514780
