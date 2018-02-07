# Setting up the RPI to stream using GStreamer

Use the following instructions to install G-Streamer on Raspberry Pi:

  1) sudo nano /etc/apt/sources.list

  2) deb http://vontaene.de/raspbian-updates/ . main

  3) sudo apt-get update 

  4) sudo apt-get install gstreamer1.0

  5) sudo apt-get install gstreamer-tools
  
  6) transfer OGStreamer.sh to startup on RPI
  
# Setting up the DriverStation to recieve images from GStreamer

Use the following instructions to install G-Streamer on Windows:

  1) https://gstreamer.freedesktop.org/data/pkg/windows/1.12.4/
  
  2) Select the latest MSI program and install Gstreamer
  
  3) Verify location of Gstreamer folder in C: drive
  
  4) Put receiver.bat on the Desktop, and run it once on the field to instantly view all cameras

