# Links

- https://www.hackster.io/100311/estimating-pi-with-a-cora-z7-running-linux-03995b
- https://www.xilinx.com/products/design-tools/embedded-software/petalinux-sdk.html

# Directions

1. Download BSP from [GitHub](https://github.com/Digilent/Petalinux-Cora-Z7-07S/releases)
1. Mount SD USB on VirtualBox Ubuntu
1. Run `gparted`
    1. ![](https://i.imgur.com/rM1JOgR.png)
1.  Mount SD Partitions
    ```bash
    sudo mkdir /mnt/SDBOOT /mnt/SDLINUX

    sudo mount /dev/sdb1 /mnt/SDBOOT
    sudo mount /dev/sdb2 /mnt/SDLINUX

    sudo chown -R norton:norton /mnt/SD*
    ```
1. Download [Petalinux Tools Installer](https://www.xilinx.com/member/forms/download/xef.html?filename=petalinux-v2019.2-final-installer.run) & Install
    ```bash
    mkdir -p /opt/pkg/petalinux/2019.2
    sudo mkdir -p /opt/pkg/petalinux/2019.2
    sudo chown -R norton:norton /opt/pkg/

    sudo apt-get install -y python gawk gcc git make net-tools libncurses5-dev \
         tftpd zlib1g:i386 libssl-dev flex bison libselinux1 gnupg wget \
         diffstat\ chrpath socat xterm autoconf libtool tar unzip texinfo \
         zlib1g-dev gcc-multilib build-essential libsdl1.2-dev libglib2.0-dev \
         screen pax gzip

    time ./petalinux-v2019.2-final-installer.run /opt/pkg/petalinux/2019.2/

    # change /bin/sh -> /bin/bash
    sudo dpkg-reconfigure dash

    echo 'source /opt/pkg/petalinux/2019.2/settings.sh' >> ~/.bashrc

    petalinux-create -t project -s ./Petalinux-Cora-Z7-07S-2017.4-1.bsp

    cd Cora-Z7-07S

    cp pre-built/linux/images/BOOT.BIN /mnt/SDBOOT/
    cp pre-built/linux/images/image.ub /mnt/SDBOOT/
    echo 'ethaddr=CO:PY:RE:AL:MA:CA' > /mnt/SDBOOT/uEnv.txt
    ```
1. Continue to follow directions from the [README](https://github.com/Digilent/Petalinux-Cora-Z7-07S#run-the-pre-built-image-from-sd)

    4. Eject the SD card from your computer and insert it into the Cora Z7.
    5. Short the MODE jumper (JP2).
    6. Attach a power source and select it with JP3 (note that using USB for power may not provide sufficient current)
    7. If not already done to provide power, attach a microUSB cable between the computer and the Cora Z7
    8. Open a terminal program (such as `minicom`) and connect to the Cora Z7 with 115200/8/N/1 settings (and no Hardware flow control). The Cora Z7 UART typically shows up as /dev/ttyUSB1
       ```bash
       sudo apt-get install minicom
       # find the name of the device
       dmesg
       # minicom requires root
       sudo minicom -s
       # configure device to select /dev/ttyUSB1
       # save and drop back to root shell
       ```
    9. Optionally attach the Cora Z7 to a network using ethernet.
    10. Press the `SRST` button to restart the Cora Z7. You should see the boot process at the terminal and eventually a root prompt.

![](../gh-assets/coraz7_petalinux.jpeg)
