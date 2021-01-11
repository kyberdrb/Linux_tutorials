Installation

    sudo pacman -S xorg xfce4 xfce4-goodies

If you have a multimedia keyboard, go to terminal and enter command to activate multimedia keys:

    pactl list sinks short

---

To disable annoying "Keyring" popup dialog when opening e.g. a web browser [uninstall gnome-keyring](http://askubuntu.com/questions/243397/xubuntu-disable-gnome-keyring)

    sudo pacman -Runs gnome-keyring

and then reboot.
