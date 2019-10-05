* aic94xx-firmware wd719x-firmware linux
    - missing firmwares for my laptop
    - install also the `linux` package to load these modules into kernel
* gvim - graphical vim text editor
* chromium/chromium-vaapi-bin - web browser
    - Settings
        1. Click on the three-dots-icon in the upper right corner
        1. Click on `Settings`
        1. Section `On startup`
            - Continue where you left off
    - for video hardware acceleration see https://wiki.archlinux.org/index.php/Chromium#Hardware_video_acceleration
    - Hardware video acceleration
        Accelerated video decoding using VA-API can be used with community made patches [1], packages are available in AUR as chromium-vaapi or chromium-vaapi-bin.

        Warning: Wayland support is not enabled in above packages yet. XWayland is broken on libva-intel-driver.
        Be sure to install correct VA-API driver for your video card and verify VA-API has been enabled and working correctly, see Hardware video acceleration#Verifying VA-API.

        To enable video acceleration, append the following flags to persistent configuration:

            $ ~/.config/chromium-flags.conf
    
            --enable-accelerated-mjpeg-decode
            --enable-accelerated-video
            --disable-gpu-driver-bug-workarounds

        **Note:** `--disable-gpu-driver-bug-workarounds` is a optional flag.

        To check if it's working play a video which is using a codec supported by your VA-API driver (vainfo tell you which codecs are supported) go to chrome://media-internals/ and check video_decoder :

        Hardware acceleration: MojoVideoDecoder, GpuVideoDecoder
        Software acceleration: VpxVideoDecoder, FFmpegVideoDecoder (some say it's Hardware acceleration?)
        Also chrome://gpu should read Video Decode: Hardware accelerated

        Source: https://wiki.archlinux.org/index.php/Chromium#Hardware_video_acceleration

* firefox
    - in the upper right corner click on a hamburger icon with a label `Open menu`
    - click on `Preferences`
    - Tab `General`
        - check `Restore previous session`
        - uncheck `Ctrl+Tab cycles through tabs in recently used order`
* redshift-minimal -> color temperature changer (spares eyes) -> run on background in tray with "redshift&"
    - Create environment for the config file
    
            mkdir -p ~/.config/redshift/
            cd ~/.config/redshift/
            vim redshift.conf
    
    - Sample `redshift.conf`
    
            [redshift]
            temp-day=2600
            temp-night=2600
            fade=0
            gamma=0.8
            location-provider=manual
            adjustment-method=randr

            [manual]
            lat=48
            lon=11

            [randr]
            screen=0
            
    - Add to autostart XFCE4 if you want in `Applications -> Settings -> Session and Startup -> Application autostart`. Set command as `redshift &`. I assume that the configuration file is present and correct.

    - Sources
        - [Redshift config file location](https://wiki.archlinux.org/index.php/Redshift#Configuration)
        - [Sample redshift config file](https://github.com/jonls/redshift/blob/master/redshift.conf.sample)
        - If you want to create the config file from scratch
            - [`cp redshift.conf redshift.conf.original && sed -e '/^;/d' redshift.conf.original > redshift.conf.config_with_removed_comments`](https://unix.stackexchange.com/questions/13525/sed-one-liner-to-delete-any-line-that-begins-with-a-digit/13526#13526)
            - [`sed '/^$/d' redshift.conf.config_with_removed_comments > redshift.conf` - then open the file manually and insert a new line before each section for better readability](https://www.cyberciti.biz/faq/using-sed-to-delete-empty-lines/)

---

* virtualbox
    - choose the option `2) virtualbox-host-modules-arch`, see https://wiki.archlinux.org/index.php/VirtualBox#Install_the_core_packages
    - after installation add the user to the VirtualBox group. This allows for USB mounting for the virtual machine
    
            sudo gpasswd -a $USER vboxusers
            
        Source: https://wiki.archlinux.org/index.php/VirtualBox#Accessing_host_USB_devices_in_guest    
        
    - reboot
            
            reboot
            
* virtualbox-ext-oracle
* virtualbox-guest-iso

---

* vlc -> multimedia player
* dcfldd
* p7zip - archive creation and extraction utility
* **evince**/okular -> PDF readers; Evince for GTK, Okular for Qt (backend: phonon-qt5-vlc)
* libreoffice-still - office suite
* ntfs-3g -> NTFS support
* gvfs -> enables Trash icon/functionality (trash virtual file system) and automatic mounting of system drives
* gvfs-mtp
    - automouning MTP devices, such as smartphones
    - issue the command below to mount all MTP devices
    
            gio mount -li | awk -F= '{if(index($2,"mtp") == 1)system("gio mount "$2)}'
            
        All MTP devices will be mounted in their respective directories in `/run/user/$UID/gvfs/`, e.g. `/run/user/1000/gvfs/`
        
        Source: https://wiki.archlinux.org/index.php/Media_Transfer_Protocol#gvfs-mtp
* gvfs-gphoto2 -> automounting PTP devices, such as cameras
android-file-transfer - transfer data with a mobile device via MTP

---

dnsmasq -> internet connectivity support tool for LXC NAT bridge interface
* code - Visual Studio Code (VS Code) - multiplatform development editor/tool

* dmidecode - RAM info
* lxqt - LXQt desktop environment: REMOVE `pcmanfm-qt` and replace it by `thunar` as a file manager
mousepad -> po instalacii otvorit mousepad, ist do Edit->Preferences->View->Colour scheme->Cobalt (biele pismena na ciernom pozadi)
musescore

openvswitch -> virtual switch for bridging VMs and containers
opera-ffmpeg-codecs -> predkompilovane na herecura repozitari - kodeky na podporu videoformatov vratane 60fps videi
* parallel - parallelize shell commands

pepper-flash -> podpora adobe flash - security risk; often used by TV streaming

* pulseaudio-bluetooth -> umozni prehravat hudbu od inych zariadeni cez bluetooth

* soundwire pulseaudio-alsa lib32-libpulse lib32-alsa-plugins - SoundWire and its dependencies; enables the use of an Android phone as a wireless speaker; Configuration: open _PulseAudio_ GUI `pavucontrol[-qt]` -\> Recording tab -\> ALSA Capture from `Monitor of Built-in Audio Analog Stereo`

qemu -> generic virtualizer
shotwell -> image viewer with nice features (crop, rotate, ...)
tigervnc -> VNC client and server
* thunar - favorite file manager
tmux -> Terminal MUltipleXor - watch multiple terminals in one SSH session
* transmission-gtk / transmission-qt -> torrent klient
tk -> tkinter library for Python
unrar -> needed for dtrx to extract RAR archives
virt-manager -> front-end ku QEMU
wget -> terminal downloader utility
* xclip - terminal clipboard manipulation utility
* xorg-apps - additional utilities for easier Xorg management e.g. brightness adjustment etc.

xfce4
xfce4-pulseaudio-plugin -> Volume control in notification tray
xfce4-screenshooter -> Screenshots for XFCE; to enable PrintScreen key go to Application Menu -> Keyboard -> Application Shortcuts tab -> Add button -> as command enter "xfce4-screenshooter" without quotes -> as key press "PrintScreen (PrtSc)" key.
xfce4-xkb-plugin -> Keyboard layout changer in notification tray

audacity -> audio editing software
bc- > command line calculator => set default scale (decimal precision) - https://askubuntu.com/questions/621017/how-to-set-default-scale-for-bc-calculator
blueman -> then execute: su -c 'systemctl enable bluetooth.service' -> this will enable the Bluetooth icon in notification tray
* filezilla -> FTP client

gparted -> disk and partition manager

* android-tools - Android platform tools; `adb` etc.; make sure to have "USB Debugging" activated on Android device otherwise it will be hidden from `adb devices` command

iw -> Sprava bezdrotovych adapterov (skenovanie Wi-Fi sieti)

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
