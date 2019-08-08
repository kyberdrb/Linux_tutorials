1. Install and configure SoundWire on PC and phone.

1. Share phone's internet connection via USB.

    Assuming you already had internet on your PC, you now have 2 network adapters. You need to make sure you are using your old adapter for internet access. As far as I could find to do this you need to change the metric of your default adapter to 1 so that it is the preferred adapter by Windows (Windows 7 in my case).

    You can check the server IP by typing ipconfig in the command prompt.

    1. Enable USB Tethering on the Android phone

    1. Connect to the USB Tethering network adapter by requesting a new IP address from DHCP. The tethered interface name is, in my case, variable according to which USB port the phone is plugged in.

        sudo dhcpcd enp0s29u1u3

    The routing table looks like this

	Kernel IP routing table
	Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
	0.0.0.0         192.168.42.129  0.0.0.0         UG    205    0        0 enp0s29u1u3
	0.0.0.0         192.168.0.1     0.0.0.0         UG    303    0        0 wlo1
	192.168.0.0     0.0.0.0         255.255.255.0   U     303    0        0 wlo1
	192.168.42.0    0.0.0.0         255.255.255.0   U     205    0        0 enp0s29u1u3 

    1. Set the Wi-Fi network connection to higher priority by lowering the metric value. Otherwise the tethered adapter will be prioritized.

    Delete the route for the wireless network adapter.

        sudo route del -net 0.0.0.0 gw 192.168.0.1 netmask 0.0.0.0 dev wlo1

    1. Routing table entries after removing the route.

	Kernel IP routing table
	Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
	0.0.0.0         192.168.42.129  0.0.0.0         UG    205    0        0 enp0s29u1u3
	192.168.0.0     0.0.0.0         255.255.255.0   U     303    0        0 wlo1
	192.168.42.0    0.0.0.0         255.255.255.0   U     205    0        0 enp0s29u1u3

    1. Add the same route again with changed metric. In my case I needed to lower the metric value to 200 in order to make it a higher priority.

        sudo route add -net 0.0.0.0 gw 192.168.0.1 metric 200 netmask 0.0.0.0 dev wlo1

    Routing table entries after re-adding the route.

Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.0.1     0.0.0.0         UG    200    0        0 wlo1
0.0.0.0         192.168.42.129  0.0.0.0         UG    205    0        0 enp0s29u1u3
192.168.0.0     0.0.0.0         255.255.255.0   U     303    0        0 wlo1
192.168.42.0    0.0.0.0         255.255.255.0   U     205    0        0 enp0s29u1u3

1. Install the _SoundWire_ app. For Arch:

    pikaur -S soundwire # Prepare for a long compilation of an entire Qt universe ;)

1. Run the _SoundWire_ server.

    SoundWireServer &

Ignore the IP address you see in the `Server Address:` filed. 

1. Connect from the SoundWire app on the phone. You might need to enter the IP address of the SoundWire server. The IP address is in the output of `ip a` under the tethered interface. You might also get a message that WiFi is disabled, but it still works without the wireless connection.

**Sources**

https://android.stackexchange.com/questions/112496/can-i-use-my-android-phone-as-a-usb-speaker/113863#113863

https://serverfault.com/questions/181094/how-do-i-delete-a-route-from-linux-routing-table

