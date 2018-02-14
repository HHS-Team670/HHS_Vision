#!/bin/sh

echo -e "adding deb to file"
sudo echo -e "\ndeb http://vontaene.de/raspbian-updates/ . main" >> /etc/apt/sources.list

echo -e "installing gstreamer"
sudo apt update
sudo apt install gstreamer1.0 gstreamer-tools

echo -e "setting OGStreamer.sh permission"
sudo chmod 777 ./launch_ogstreamer.sh


echo -e "setting launch_ogstreamer.sh as startup script (do not move this file)"
sudo mv launch_ogstreamer.sh /home/launch_ogstreamer.sh
sudo chmod +x /home/launch_ogstreamer.sh
