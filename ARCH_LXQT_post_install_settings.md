- Audio
    - pavucontrol-qt
        - reboot afterwards otherwise the _PulseAudio Sound Mixer_ will get stuck on _Establishing connection to PulseAudio. Please wait..._

LXQt
- added German (German) and Slovak keyboard layout; Order: Slovak, German, English
- added _Keyboard state indicator_ to the _Panel_ + TODO:add screenshot
- configured _Task Manager (taskbar)_: _**Show only windows from desktop**_: _Current_
- changed configuration of _World Clock_ widget on _Panel_ to fix alignment
    - Time
        - Format: Custom
        - untick everything
- _Panel_
    - right click on _Panel_ -- _Configure Panel_
        - Size: 35px - increase Panel size beacuse of proper displaying _World Clock_ widget

- Fonts
    - sudo pacman -S ttf-freefont
    - After installing _Sans Forgetica_ font with `otf-sans-forgetica` package set it as default in

            _LXQt menu_ -\> _Preferences_ -\> _Appearance_ -\> _Font_

    Parameters:
    - **Font name:** Sans Forgetica
    - **Style:** Normal
    - **Point size:** 10

Confirm font settings by clicking on _Apply_.

    - Firefox
    
            Menu in the right hand corner -\> Preferences -\> General -\> Language and Appearance -\> Fonts and Colors

        Parameters:
        - **Default font** Sans Forgetica
        - **Size** 16
        - **Advanced**
            - set _Serif_ and _Sans-serif_ fonts to _Sans Forgetica_
            - uncheck _Allow pages to choose their own fonts, instead of your selections above_
            - OK

Restart Firefox

- wifi-menu backup
    - /etc/netctl/
