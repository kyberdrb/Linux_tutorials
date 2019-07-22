1. Install and configure SoundWire on PC and phone.

1. Share phone's internet connection via USB.

    Assuming you already had internet on your PC, you now have 2 network adapters. You need to make sure you are using your old adapter for internet access. As far as I could find to do this you need to change the metric of your default adapter to 1 so that it is the preferred adapter by Windows (Windows 7 in my case).

    You can check the server IP by typing ipconfig in the command prompt.

    OR

    Disconnect from the current wireless network

        wpa_cli disconnect

    Enable USB Tethering on the Android phone

    Connect to the USB Tethering network adapter by requesting a new IP address from DHCP:

       sudo dhcpcd enp0s29u1u1

1. Connect from the SoundWire app on your phone. You might need to enter the IP address of the SoundWire server. You might also get a message that WiFi is disabled, but it still works fine.

**Sources**

https://android.stackexchange.com/questions/112496/can-i-use-my-android-phone-as-a-usb-speaker/113863#113863

