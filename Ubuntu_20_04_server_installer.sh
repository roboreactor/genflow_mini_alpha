wget https://archive.raspberrypi.org/debian/pool/main/r/raspi-config/raspi-config_20221018_all.deb -p /tmp
sudo apt-get install libnewt0.52 whiptail parted triggerhappy lua5.1 alsa-utils -y
sudo apt-get install -fy -y 
sudo dpkg -i /tmp/raspi-config_20221018_all.deb

