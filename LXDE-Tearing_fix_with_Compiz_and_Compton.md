# Fix tearing on LXDE with Compton

Installation steps are for Debian, but the procedure is mainly LXDE specific. The names of the packages may vary with distributions, but is very likely that they have the same names.

## Compiz (recommended)

Compiz works the same as compton. The reason, why I didn't include the tutorial is that Compiz is substantialy harder to install on Debian than on Arch.

To install Compiz on Arch, you have to type:

    yaourt -S compiz

Wait until it compiles. Then run the compositor:

	compiz --replace
    
and modify Session preferences -> Compositor / Windows manager to 'compiz'. Click OK to save the settings, close all open programs and reboot.

Enjoy smooth animations and window movement without tearing and stuttering.

## COMPTON

Install `compton`

    sudo apt-add-repository ppa:richardgv/compton
    sudo apt-get update
    sudo apt-get install compton
    leafpad ~/.compton.conf

Copy this into the file:

    backend = "glx";
    paint-on-overlay = true;
    glx-no-stencil = true;
    glx-no-rebind-pixmap = true;
    vsync = "opengl-swc"; 

    # These are important. The first one enables the opengl backend. The last one is the vsync method. Depending on the driver you might need to use a different method.
    # The other options are smaller performance tweaks that work well in most cases. 
    # You can find the rest of the options here: https://github.com/chjj/compton/wiki/perf-guide, and here: https://github.com/chjj/compton/wiki/vsync-guide


    # Shadow
    shadow = true;			# Enabled client-side shadows on windows.
    no-dock-shadow = true;		# Avoid drawing shadows on dock/panel windows.
    no-dnd-shadow = true;		# Don't draw shadows on DND windows.
    clear-shadow = true;		# Zero the part of the shadow's mask behind the window (experimental).
    shadow-radius = 7;		# The blur radius for shadows. (default 12)
    shadow-offset-x = -7;		# The left offset for shadows. (default -15)
    shadow-offset-y = -7;		# The top offset for shadows. (default -15)
    shadow-exclude = [
    "! name~=''",
    "n:e:Notification",
    "n:e:Plank",
    "n:e:Docky",
    "g:e:Synapse",
    "g:e:Kupfer",
    "g:e:Conky",
    "n:w:*Firefox*",
    "n:w:*Chrome*",
    "n:w:*Chromium*",
    "class_g ?= 'Notify-osd'",
    "class_g ?= 'Cairo-dock'",
    "class_g ?= 'Xfce4-notifyd'",
    "class_g ?= 'Xfce4-power-manager'"
    ];

    # The shadow exclude options are helpful if you have shadows enabled. Due to the way compton draws its shadows, certain applications will have visual glitches 
    # (most applications are fine, only apps that do weird things with xshapes or argb are affected). 
    # This list includes all the affected apps I found in my testing. The "! name~=''" part excludes shadows on any "Unknown" windows, this prevents a visual glitch with the XFWM alt tab switcher.

    # Fading
    fading = true; # Fade windows during opacity changes.
    fade-delta = 4; # The time between steps in a fade in milliseconds. (default 10).
    fade-in-step = 0.03; # Opacity change between steps while fading in. (default 0.028).
    fade-out-step = 0.03; # Opacity change between steps while fading out. (default 0.03).
    #no-fading-openclose = true; # Fade windows in/out when opening/closing

    detect-client-opacity = true; # This prevents opacity being ignored for some apps. For example without this enabled my xfce4-notifyd is 100% opacity no matter what.

    # Window type settings
    wintypes:
    {
    tooltip = { fade = true; shadow = false; };
    };

to run compton after start, type command:
leafpad /home/andrej/.config/lxsession/LXDE/autostart

and add this to the file:

@compton -b


Save file and reboot.

## Troubleshooting

If from whatever reason something didn't work out, you can fix it in multiple ways.

Either restore the previous compositor in Application menu - Preferences - Desktop Session Preferences - (tab) Advanced Settings. In the text field replace current compositor's name with `compiz` or `openbox`

The configuration file for changing compositor is `` [Arch Wiki - LXDE - Use a different window manager](https://wiki.archlinux.org/index.php/LXDE#Use_a_different_window_manager), [1](https://forum.lxde.org/viewtopic.php?p=53256#p53256), [2](https://github.com/lxde/lxsession/blob/master/data/desktop.conf.example)

Example configuration:

    autostart :::
    @lxpanel --profile LXDE

    desktop.conf :::
    [Session]
    window_manager=openbox-lxde
    windows_manager/command=openbox
    windows_manager/session=LXDE
    disable_autostart=no
    polkit/command=lxpolkit
    clipboard/command=
    xsettings_manager/command=build-in
    proxy_manager/command=build-in
    keyring/command=ssh-agent
    notification/command=/usr/libexec/notification-daemon
    notification/autostart=true
    quit_manager/command=lxsession-logout
    quit_manager/image=/usr/share/lxde/images/logout-banner.png
    quit_manager/layout=top
    lock_manager/command=lxlock
    terminal_manager/command=lxterminal
    launcher_manager/command=lxpanelctl

    [GTK]
    sNet/ThemeName=Clearlooks
    sNet/IconThemeName=Fedora
    sGtk/FontName=Sans 10
    iGtk/ToolbarStyle=3
    iGtk/ButtonImages=1
    iGtk/MenuImages=1
    iGtk/CursorThemeSize=18
    iXft/Antialias=1
    iXft/Hinting=1
    sXft/HintStyle=hintslight
    sXft/RGBA=rgb
    iNet/EnableEventSounds=0
    iNet/EnableInputFeedbackSounds=0
    sGtk/ColorScheme=
    iGtk/ToolbarIconSize=3
    sGtk/CursorThemeName=Adwaita
    sGtk/IMModule=gtk-im-context-simple:xim

    [Mouse]
    AccFactor=20
    AccThreshold=10
    LeftHanded=0

    [Keyboard]
    Delay=500
    Interval=30
    Beep=1

    [State]
    guess_default=true

    [Dbus]
    lxde=true

    [Environment]
    menu_prefix=lxde-



