#!/bin/sh

echo "adding deb to file"
sudo echo "deb http://vontaene.de/raspbian-updates/ . main" >> /etc/apt/sources.list

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
sudo echo "/home/launch_ogstreamer.sh" >> ~/.bashrc


echo "HOMESTEAD PI IS NOW INSTALLED! Please go to Raspi-Config, and enable boot on network connection, so it does not startup until it is connected to the FRC router! ALSO PLEASE ENABLE AUTO LOGIN TO CONSOLE ON THE RASPBERRY PI THROUGH RASPI-CONFIG!"
