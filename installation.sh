#!/bin/sh

echo "adding deb to file"
sudo echo "\ndeb http://vontaene.de/raspbian-updates/ . main" >> /etc/apt/sources.list

echo "installing gstreamer"
sudo apt update
sudo apt install gstreamer1.0 gstreamer-tools

echo "installing PIP for python"
sudo apt install python-pip
sudo apt install python-opencv

echo "updating PIP for python"
sudo pip install --upgrade pip

echo "installing pynetworktables"
pip install pynetworktables

echo "Power cube python opencv software is being installed (do not move this file)"
sudo mv PowerCuber.py /home/PowerCuber.py

echo "setting OGStreamer.sh permission"
sudo chmod 777 ./launch_ogstreamer.sh

echo "setting launch_ogstreamer.sh location (do not move this file)"
sudo mv launch_ogstreamer.sh /home/launch_ogstreamer.sh
sudo chmod +x /home/launch_ogstreamer.sh

echo "Setting startup script......."
sudo rm -r /etc/rc.local
sudo mv rc.local /etc/rc.local
sudo chmod +x /etc/rc.local

echo "Homestead Pi is installed, congratulations, enjoy your processing adventures"
