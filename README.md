# Setting up the RPI to stream using GStreamer

Use the following instructions to install G-Streamer on Raspberry Pi:

  1) Download this project through git clone
  
  2) add "deb http://vontaene.de/raspbian-updates/ . main" to the file /etc/apt/sources.list

  3) run "sudo vi /boot/cmdline.txt", and add "boot_delay=20" before the 'rootfstype'
  
  4) run installation.sh
  
  5) Go to raspi-config, and set the system to auto login to the console as well as boot once the network is connected
  
  6) Make sure you setup the Windows streamer as well as the RoboRIO end (get networktable data)
  
# Setting up the DriverStation to recieve images from GStreamer

Use the following instructions to install G-Streamer on Windows:

  1) https://gstreamer.freedesktop.org/data/pkg/windows/1.12.4/
  
  2) Select the latest MSI program and install Gstreamer
  
  3) Verify location of Gstreamer folder in C: drive
  
  4) Put receiver.bat on the Desktop, and run it once on the field to instantly view all cameras

