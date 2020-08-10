* aic94xx-firmware wd719x-firmware linux
    - missing firmwares for my laptop
    - install also the `linux` package to load these modules into kernel
* vim
    - create a configuration file with preferred settings

            set tabstop=4
            set shiftwidth=4
            set expandtab
            set display+=lastline

        - Sources
            - https://vi.stackexchange.com/questions/4141/how-to-indent-as-spaces-instead-of-tab/4175#4175
            - https://vim.fandom.com/wiki/Working_with_long_lines
    
* gvim - graphical vim text editor
* atom - text editor
    - Installed packages:
        - asciidoc-preview
            - AsciiDoc support
        
    - Configuration:
        - Disable welcome screen: uncheck the “Show Welcome Guide when opening Atom” box.
        
            Source: https://discuss.atom.io/t/how-to-get-rid-of-welcome-md/12838/10
        - Edit -- Preferences -- Core -- disable _Allow Pending Pane Items_ - temporary preview of files - fixes the bug with opening a file permanently from the tree view
        
            Source: https://discuss.atom.io/t/atom-doesnt-open-file-on-single-click-in-tree-view/27902/9
        - Edit -- Preferences -- Themes -- UI Theme: Atom Light; Syntax Theme: Atom Light
        - Edit -- Preferences -- Editor -- disable _Atomic Soft Tabs_, Font Family: **Source Code Pro** (because of the clear distinction among the characters 'iI1l' 'oO0 - especially the zero :)' 'sS5' 'A4' 'g9' 'B8' ''Z2), Menlo, Consolas, DejaVu Sans Mono, monospace, Tab Length: 4, Tab Type: soft
        
            Source: https://discuss.atom.io/t/how-do-you-use-spaces-instead-of-tabs/64730/2
        - Keybindings -- click on _your keymap file_. Copy this to it:
         
                'atom-workspace atom-text-editor':
                    'ctrl-left': 'editor:move-to-previous-word-boundary'
                    'ctrl-right': 'editor:move-to-next-word-boundary'
                    'ctrl-shift-left': 'editor:select-to-previous-word-boundary'
                    'ctrl-shift-right': 'editor:select-to-next-word-boundary'
                    'ctrl-backspace': 'editor:delete-to-previous-word-boundary'
                    'ctrl-delete': 'editor:delete-to-next-word-boundary'
                    'ctrl-shift-S': 'window:save-all'
                    'ctrl-alt-S': 'core:save-as'
                     
             Sources:
             - https://www.reddit.com/r/Atom/comments/534mno/how_to_configure_atom_to_properly_delete_words/
             - https://discuss.atom.io/t/ctrl-backspace-deletes-last-character-from-line-above/56256/3

    - Keyboard shortcuts:
        - Command Pallete: Ctrl-Shift-P
        - Markdown Preview: Ctrl-Shift-M
        - AsciiDoc Preview: Ctrl-Shift-A
        - Duplicate Line: Ctrl + Shift + D
        
* vlc - multimedia player
    - Youtube network streaming fix
        
            # Go to the VLC directory
            cd /usr/lib/vlc/intf/playlist/
            
            # Backup the original script for youtube streaming
            sudo mv youtube.luac youtube.luac.bak
            
            # Download the fixed Youtube streaming plugin from the master branch ...
            sudo curl https://raw.githubusercontent.com/videolan/vlc/master/share/lua/playlist/youtube.lua --output youtube.lua
            # ... or directly from the commit I tested it from
            sudo curl https://raw.githubusercontent.com/videolan/vlc/8bbb13419d4bc5505cb75416d5b8049142a27358/share/lua/playlist/youtube.lua --output youtube.lua
            
        Sources:
        - [YouTube VLC Stream LUA Fix](https://www.youtube.com/watch?v=jg4Og5ra_F0)
        - [tested fixed script for youtube streaming](https://raw.githubusercontent.com/videolan/vlc/8bbb13419d4bc5505cb75416d5b8049142a27358/share/lua/playlist/youtube.lua)
        - [latest script for youtube streaming - master branch](https://raw.githubusercontent.com/videolan/vlc/master/share/lua/playlist/youtube.lua)
        
    - Disable cover art for audio files in normal mode
    
        Disable cover art in the playback panel by editing the VLC configuration file.  
        The VLC configuration file is located in:
        - Linux: `~/.config/vlc/vlcrc`
        - Windows: `%HOMEPATH\AppData\Roaming\vlc\vlcrc`
        
                $ sed -i 's/.*qt-bgcone=.*/qt-bgcone=0/' ~/.config/vlc/vlcrc
                $ #Source: https://forum.videolan.org/viewtopic.php?t=129402#p433995
    
    - Disable cover art for any file in playlist mode
    
        1. Show playlist by pressing _Ctrl + L_ or in _View - Playlist_
        1. Find the cover art panel. In my case it was in the bottom left corner.
        1. Drag the upper border of the cover art panel all the way down. This will hide the panel with the cover art, and leave the left menu panel visible.
    
    - Disable automatic window resizing and scaling
    
        - Disable variable window size in the VLC configuration file
    
                $ sed -i 's/.*qt-video-autoresize=.*/qt-video-autoresize=0/' ~/.config/vlc/vlcrc
            
            This will also uncheck the checkbox for _Tools - Preferences - Interface - Resize interface to video size_
            
            When it won't work, continue with the other options. Otherwise continue with next steps.
            
            Sources:
            - https://superuser.com/questions/368743/how-to-prevent-vlc-from-automatically-resizing-its-window-according-to-viewed-co/412290#412290
            - https://superuser.com/questions/368743/how-to-prevent-vlc-from-automatically-resizing-its-window-according-to-viewed-co/368759#368759
            
        - Tools - Preferences - Show settings (in bottom left corner): All - Video
        
            In _Window properties_ section uncheck _Video Auto Scaling_.
            
            Source: https://superuser.com/questions/368743/how-to-prevent-vlc-from-automatically-resizing-its-window-according-to-viewed-co/687776#687776
            
    - Specify default video resolution - useful for streams with multiple resolutions available
    
        1. Tools - Preferences - Show settings (in bottom left corner): All - Input / Codecs
        1. In _Track settings_ section find option _Preferred video resolution_. 
        1. Click on the drop-down menu
        1. Choose the preferred video resolution. I selected option _Full HD (1080p)_ because it matches with the resolution of my display.
        
        Sources:
        - https://www.quora.com/How-do-I-select-the-video-quality-in-VLC-while-playing-a-YouTube-stream
            
* chromium
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

* dcfldd
* p7zip - archive creation and extraction utility
* evince/**okular**
    - PDF readers
    - Evince (GTK)
    - Okular (Qt)
        - backend: **phonon-qt5-gstreamer**/phonon-qt5-vlc
        - Text-to-Speech packages: `espeak-ng 1.49.2-6 speech-dispatcher 0.9.1-1`
        - Sources
            - https://www.reddit.com/r/kde/comments/5w9wty/gstreamer_or_vlc_as_phonon_backend/
            - https://wiki.archlinux.org/index.php/KDE#Which_backend_should_I_choose.3F
            - TTS: https://bugs.archlinux.org/task/62629
            
* ocrmypdf tesseract-data-eng tesseract-data-slk tesseract-data-dan tesseract-data-ces - utility to make a PDF document searchable with trained datasets for the `tesseract` utility; 
    - trained datasets are stored in firectory `/usr/share/tessdata/`
    - A document is unsearchable, if it's composed of images, or the text cannot be searched, e.g. by `Ctrl + F`, or text cannot by selected
    - The command to make a PDF document searchable
    
            ocrmypdf --verbose --language eng --sidecar -O 0 --png-quality 100 --force-ocr document_in_english-nonsearchable.pdf document_in_english-searchable.pdf
            ocrmypdf --verbose --language eng -O 1 --png-quality 100 document_in_english-nonsearchable.pdf document_in_english-searchable.pdf
            
        - The `--language` option explicitely specifies the dataset that will be used for OCR (Optical Character Recognition); e.g. for `eng` it will use the  `tesseract-data-eng` dataset, i.e. the dataset for English language.
        - The `-O` option optimizes the final document. With value `1` the utility performs lossless optimizations which affect the size of the final document.
        - `sidecar` outputs the decoded text into a separate `txt` file
    
    - Sources
        - https://unix.stackexchange.com/questions/301318/how-to-ocr-a-pdf-file-and-get-the-text-stored-within-the-pdf/421686#421686
        - https://aur.archlinux.org/packages/ocrmypdf/
        - https://ocrmypdf.readthedocs.io/en/latest/jbig2.html#jbig2
        - https://aur.archlinux.org/packages/jbig2enc-git/
        - https://www.archlinux.org/packages/?sort=&q=tesseract-data&maintainer=&flagged=
        - https://stackoverflow.com/questions/39037823/tesseract-data-language-codes-with-country-name/39040220#39040220
        - https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes
        - https://www.archlinux.org/packages/community/any/tesseract-data-eng/
        - https://www.archlinux.org/packages/community/any/tesseract-data-slk/
        - https://www.archlinux.org/packages/community/any/tesseract-data-dan/
        - `ocrmypdf --help`
- jbig2enc-git - optional dependency for `ocrmypdf` utility - takes advantage of the lossy compression to JPEG image format in order to reduce the size of the final document to the minimum
    
* libreoffice-still - office suite
* ntfs-3g -> NTFS support
* gvfs -> enables Trash icon/functionality (trash virtual file system) and automatic mounting of system drives
* **gvfs-mtp** gvfs-gphoto2
    - automouning MTP devices, such as smartphones + automounting PTP devices, such as cameras
    - issue the command below to mount all MTP devices
    
            gio mount -li | awk -F= '{if(index($2,"mtp") == 1)system("gio mount "$2)}'
            
        All MTP devices will be mounted in their respective directories in `/run/user/$UID/gvfs/`, e.g. `/run/user/1000/gvfs/`
        
    - reboot
        
        Source: https://wiki.archlinux.org/index.php/Media_Transfer_Protocol#gvfs-mtp

* make cmake gdb lldb libc++ gtest perf valgrind - C/C++ toolchain; `libc++`is a C++ standard library for LLVM
* clion clion-cmake clion-gdb clion-jre clion-lldb - C/C++ IDE from JetBrains with bundled toolchains and Google Test Framework; all packages must be installed to have a fully functional IDE
    - perf - profiling tool for Linux kernel; useful for CLion; set it up in CLion under "File -> Settings -> Build, Execution, Deployment -> Dynamic analysis tools" - run profiler via "Run -> Profile '<ProjectName>'"
    - valgrind - memory leaks test; useful for CLion; set it up in CLion under "File -> Settings -> Build, Execution, Deployment -> Dynamic analysis tools" - run Valgrind via "Run -> Run '<ProjectName>' with Valgrind Memcheck"
    - gdb: I chose to disable colors in the GDB because I found some words harder to read on Terminal with black background, e.g. the `auto` keyword which was blue. Therefore, I created a file `~/.gdbinit` with this content
    
            set style enabled off
            
        The setting will be loaded for each gdb session, unless a project-specific configuration file for GDB is present in the directory of the project, which is the directory where we'll be launching the GDB utility.
    
        - Sources:
            - https://sourceware.org/gdb/current/onlinedocs/gdb/Output-Styling.html
            - https://stackoverflow.com/questions/2045509/how-to-save-settings-in-gdb/2045532#2045532
            - https://github.com/gdbinit/Gdbinit/blob/master/gdbinit
* qtcreator - IDE for Qt Framework
* python-pip - pip package installer
    
---

* musescore - music notation software. For development, uninstall `musescore` package via `sudo pacman -R musescore`. This will leave only one copy of the application installed on the system when we build it. The dependent packages will still remain present which will be helpful when compiling the application. For `musescore` dependencies see the [Arch-Based OS Compilation Instructions](https://musescore.org/en/handbook/developers-handbook/compilation/compile-instructions-archlinux-based-distros-git)
* doxygen - documentation generator for software projects; UML and text docs
* graphviz - utility for graphically generating UML diagrams

---

* parallel - utility for parallel execution of commands
* ttf-vlgothic - Japanese font to support Japanese characters in the operating system and apps like webbrowsers etc.; https://wiki.archlinux.de/title/Schriftarten
* xclip - terminal clipboard manipulation utility

---

* dmidecode - RAM info
* lxqt - LXQt desktop environment: REMOVE `pcmanfm-qt` and replace it by `thunar` as a file manager
mousepad -> po instalacii otvorit mousepad, ist do Edit->Preferences->View->Colour scheme->Cobalt (biele pismena na ciernom pozadi)
* parallel - parallelize shell commands
* thunar - favorite file manager
* transmission-gtk / transmission-qt -> torrent klient
* filezilla -> FTP client
* gparted -> disk and partition manager
* xorg-apps - additional utilities for easier Xorg management e.g. brightness adjustment etc.

---

openvswitch -> virtual switch for bridging VMs and containers
opera-ffmpeg-codecs -> predkompilovane na herecura repozitari - kodeky na podporu videoformatov vratane 60fps videi
dnsmasq -> internet connectivity support tool for LXC NAT bridge interface

pepper-flash -> podpora adobe flash - security risk; often used by TV streaming

pulseaudio-bluetooth -> umozni prehravat hudbu od inych zariadeni cez bluetooth

soundwire pulseaudio-alsa lib32-libpulse lib32-alsa-plugins - SoundWire and its dependencies; enables the use of an Android phone as a wireless speaker; Configuration: open _PulseAudio_ GUI `pavucontrol[-qt]` -\> Recording tab -\> ALSA Capture from `Monitor of Built-in Audio Analog Stereo`

qemu -> generic virtualizer
shotwell -> image viewer with nice features (crop, rotate, ...)
tigervnc -> VNC client and server
tmux -> Terminal MUltipleXor - watch multiple terminals in one SSH session
tk -> tkinter library for Python
unrar -> needed for dtrx to extract RAR archives
virt-manager -> front-end ku QEMU
wget -> terminal downloader utility
xfce4
xfce4-pulseaudio-plugin -> Volume control in notification tray
xfce4-screenshooter -> Screenshots for XFCE; to enable PrintScreen key go to Application Menu -> Keyboard -> Application Shortcuts tab -> Add button -> as command enter "xfce4-screenshooter" without quotes -> as key press "PrintScreen (PrtSc)" key.
xfce4-xkb-plugin -> Keyboard layout changer in notification tray

audacity -> audio editing software
bc- > command line calculator => set default scale (decimal precision) - https://askubuntu.com/questions/621017/how-to-set-default-scale-for-bc-calculator
blueman -> then execute: su -c 'systemctl enable bluetooth.service' -> this will enable the Bluetooth icon in notification tray

android-file-transfer - transfer data with a mobile device via MTP
android-tools - Android platform tools; `adb` etc.; make sure to have "USB Debugging" activated on Android device otherwise it will be hidden from `adb devices` command

iw -> Sprava bezdrotovych adapterov (skenovanie Wi-Fi sieti)

wireshark-qt - network traffic inspector

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

-LXC/LXD containers support
yum -> support for Fedora based LXC containers in Arch Linux
lxd -> base LXD support

**  MANUALNE Z INTERNETU **
pycharm -> skopirovat do /opt adresara
vmware -> bud player alebo workstation


Sources:
XFCE Screenshot utility - https://ubuntuforums.org/showthread.php?t=1716649
SoundWire - https://bbs.archlinux.org/viewtopic.php?pid=1514780#p1514780
