#!/bin/sh

echo -e "adding deb to file"
sudo echo -e "\ndeb http://vontaene.de/raspbian-updates/ . main" >> /etc/apt/sources.list

echo -e "installing gstreamer"
sudo apt update
sudo apt install gstreamer1.0 gstreamer-tools

echo -e "installing PIP for python"
sudo apt install python-pip

echo -e "updating PIP for python"
sudo pip install --upgrade pip

echo -e "installing pynetworktables"
pip install pynetworktables

echo -e "Power cube python opencv software is being installed (do not move this file)"
sudo mv PowerCuber.py /home/PowerCuber.py

echo -e "setting OGStreamer.sh permission"
sudo chmod 777 ./launch_ogstreamer.sh

echo -e "setting launch_ogstreamer.sh location (do not move this file)"
sudo mv launch_ogstreamer.sh /home/launch_ogstreamer.sh
sudo chmod +x /home/launch_ogstreamer.sh

echo -e "Setting startup script......."
sudo rm -r /etc/rc.local
sudo mv rc.local /etc/rc.local
sudo chmod +x /etc/rc.local

echo -e "Homestead Pi is installed, congratulations, enjoy your processing adventures"
