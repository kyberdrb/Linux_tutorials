**  PACMAN **

7z - archive manipulation utility
audacity -> audio editing software
bc- > command line calculator => set default scale (decimal precision) - https://askubuntu.com/questions/621017/how-to-set-default-scale-for-bc-calculator
blueman -> then execute: su -c 'systemctl enable bluetooth.service' -> this will enable the Bluetooth icon in notification tray
* evince/okular -> PDF readers; Evince for GTK, Okular for Qt (backend: phonon-qt5-vlc)
filezilla -> FTP client
* firefox -> recover the ~/.config/mozilla directory
git -> recover the ~/.gitconfig file
gparted -> disk and partition manager
gvfs -> enables Trash icon/functionality (trash virtual file system) and automatic mounting of system drives
gvfs-mtp -> automouning MTP devices, such as smartphones
gvfs-gphoto2 -> automounting PTP devices, such as cameras
iw -> Sprava bezdrotovych adapterov (skenovanie Wi-Fi sieti)
lib32-mesa -> Intel grafika
* libreoffice-still
libva-intel-driver -> Intel grafika

-VIRTUALIZATION
lxc -> base LXC support
arch-install-scripts -> base LXC support
debootstrap -> support for Debian based LXC containers in Arch Linux
docker -> base Docker support

-GENERAL
android-file-transfer - transfer data with a mobile device via MTP
dnsmasq -> internet connectivity support tool for LXC NAT bridge interface
* code - Visual Studio Code (VS Code) - multiplatform development editor/tool
* base-devel - development tools for Arch Linux
* gvim - graphical vim text editor
* lxqt - LXQt desktop environment
* mesa -> Intel graphics driver
mousepad -> po instalacii otvorit mousepad, ist do Edit->Preferences->View->Colour scheme->Cobalt (biele pismena na ciernom pozadi)
musescore
ntfs-3g -> NTFS support
openssh -> SSH client and server
openvswitch -> virtual switch for bridging VMs and containers
opera-ffmpeg-codecs -> predkompilovane na herecura repozitari - kodeky na podporu videoformatov vratane 60fps videi
p7zip -> command line extraction utility
pavucontrol -> pulseaudio frontend (gui)
#pepper-flash -> podpora adobe flash - nemam ho rad, ale vela televiznych stanic ho pouzivaju na streamovanie
pulseaudio -> audio server
pulseaudio-bluetooth -> umozni prehravat hudbu od inych zariadeni cez bluetooth
qemu -> generic virtualizer
redshift -> color temperature changer (spares eyes) -> run on background in tray with "redshift-gtk&" -> right click on the tray icon and enable Autostart
shotwell -> image viewer with nice features (crop, rotate, ...)
tigervnc -> VNC client and server
tmux -> Terminal MUltipleXor - watch multiple terminals in one SSH session
* transmission-gtk / transmission-qt -> torrent klient
tk -> tkinter library for Python
unrar -> needed for dtrx to extract RAR archives
virtualbox -> zvolit "virtualbox-host-modules-arch". po instalacii vykonat prikaz: gpasswd -a $USER vboxusers
virtualbox-ext-oracle
virtualbox-guest-iso
virt-manager -> front-end ku QEMU
vlc -> multimedia player
wget -> terminal downloader utility
* wpa_supplicant -> utility to connect to Wi-Fi networks with WPA/WPA2 encryption
* xf86-video-intel -> Intel grafika
* xorg-apps - additional utilities for easier Xorg management e.g. brightness adjustment etc.

xfce4
xfce4-pulseaudio-plugin -> Volume control in notification tray
xfce4-screenshooter -> Screenshots for XFCE; to enable PrintScreen key go to Application Menu -> Keyboard -> Application Shortcuts tab -> Add button -> as command enter "xfce4-screenshooter" without quotes -> as key press "PrintScreen (PrtSc)" key.
xfce4-xkb-plugin -> Keyboard layout changer in notification tray

** AUR **
yaourt - the AUR helper utility to install `pikaur`; never touch yaourt again beacuse it's a discontinued project
pikaur -> AUR helper utility; the only AUR helper I need; Installation: `sudo pacman -Syyuu && sudo pacman -S base-devel yaourt -Syyuu && yaourt -S pikaur` installs packages from AUR; yaourt alternative; according to https://wiki.archlinux.org/index.php/AUR_helpers it's a more stable alternative to other AUR helpers like yaourt/aurman/bauerbill

dtrx -> command line extraction utility
etcher -> bootable USB creator; replacement for dd
google-chrome
otf-sans-forgetica - font for better memorizing; setup for XFCE4: https://docs.xfce.org/xfce/xfce4-settings/appearance#fonts; setup for Chromium: https://www.techadvisor.co.uk/how-to/software/how-change-font-in-google-chrome-3606119/
skypeforlinux-bin -> skype-legacy sa neda uz nainstalovat - neda sa skompilovat qt4 modul
teamviewer -> na ovladanie vzdialenych ploch - aj pre android :D (https://crazytechtricks.com/remote-control-android-phone-from-another-android-without-root-download-best-apps/)

-DEVELOPMENT
pycharm-professional -> Python/HTML/CSS/JS IDE from JetBrains; the community edition is good, but is lacking the "code coverage" functionality; needs to be activated - use one of the "jetbrains activation servers" << google that ;) or http://xidea.online/servers.html
mono - c# support for linux - see "https://wiki.archlinux.org/index.php/mono" for compilation and run instructions
python -> python3 support
python-xdg -> dependency for redshift-gtk (tray icon) to launch and run correctly
python-virtualenv python2-virtualenv -> virtualne prostredia pre python2 a python3
python-coverage python2-coverage: For support code coverage measurement for Python 2

clion clion-cmake clion-gdb clion-jre clion-lldb gtest - C/C++ IDE from JetBrains with bundled toolchains and Google Test Framework; all packages must be installed to have a fully functional IDE; to reset trial period see "https://gist.github.com/kyberdrb/28ee3454b3fc42c262bf9e0e455fc22d"
perf - profiling tool for Linux kernel; useful for CLion; set it up in CLion under "File -> Settings -> Build, Execution, Deployment -> Dynamic analysis tools" - run profiler via "Run -> Profile '<ProjectName>'"
valgrind - memory leaks test; useful for CLion; set it up in CLion under "File -> Settings -> Build, Execution, Deployment -> Dynamic analysis tools" - run Valgrind via "Run -> Run '<ProjectName>' with Valgrind Memcheck"

-LXC/LXD containers support
yum -> support for Fedora based LXC containers in Arch Linux
lxd -> base LXD support

**  MANUALNE Z INTERNETU **
pycharm -> skopirovat do /opt adresara
vmware -> bud player alebo workstation


Sources:
https://ubuntuforums.org/showthread.php?t=1716649
