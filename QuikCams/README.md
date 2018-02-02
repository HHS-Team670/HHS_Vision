# Setting up the RPI to stream using GStreamer

Use the following instructions to install G-Streamer on Raspberry Pi:

  1) sudo nano /etc/apt/sources.list

  2) deb http://vontaene.de/raspbian-updates/ . main

  3) sudo apt-get update 

  4) sudo apt-get install gstreamer1.0

  5) sudo apt-get install gstreamer-tools
  
  6) *Change the $1 variable in the runMJPG.sh file to the hostname of the driver station, then run the script on the RPI during startup


