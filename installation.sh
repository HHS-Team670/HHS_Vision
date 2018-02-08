#!/bin/sh

echo -e "adding deb to file"
sudo echo -e "\ndeb http://vontaene.de/raspbian-updates/ . main" >> /etc/apt/sources.list

echo -e "installing gstreamer"
sudo apt update
sudo apt install gstreamer1.0 gstreamer-tools

echo -e "installing pynetworktables"
sudo pip install pynetworktables

echo -e "setting OGStreamer.sh permission"
sudo chmod 777 ./OGStreamer.sh

echo -e "setting OGStreamer.sh as startup script (do not move this file)"
sudo echo -e "#!/bin/sh\nexec $(pwd)/OGStreamer.sh\n" > /etc/init.d/launch_ogstreamer.sh
sudo chmod +x /etc/init.d/launch_ogstreamer.sh
