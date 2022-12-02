#!/bin/bash
# run genflow mini service with out install lib
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

NC='\033[0m' 		     # No Color
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Cyan='\033[0;36m'         # Cyan

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

echo -e "${Yellow}
======================================================================================
${NC}"
echo -e "${Cyan}
     
                        ╣╢╢╣╢╢╗╦╗╗╗╗╗╗╗╗╗╗╗╗╗╗╗╗╗╦╦
                         ╙╝▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░╗
                            ╙╣▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░╕
                                                ╚░▒░░░░
                              ╓╣╢╢╢╢╢╢╢╢╢╢╢╢╗╦   ╚▒░░░░
                            ╫▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒   ╒░░░░▒
                           ╔▒▒▒▒▒▒╨╜╙╙╙╙         ╢░░░░╜
                           ║▒▒▒▒▒╜       ╓╥╦╦╦╦╬░░░░░▒░
                           ║▒▒▒▒▒      ╬▒▒▒▒▒▒▒▒░░░░▒░
                           ║▒▒▒▒▒     ╫▒▒▒▒▒▒▒╜╙╙╙╙
                           ║▒▒▒▒▒     ╙▒▒▒▒▒▒╣
                           ▒▒▒▒▒▒      ╙▒▒▒▒▒▒╢
                           ▒▒▒▒▒▒       └╢▒▒▒▒▒▒╖
                           ▒▒▒▒▒▒         ╫▒▒▒▒▒▒╗
                           ▒▒▒▒▒▒          ╙▒▒▒░░░╣
                           ▒▒▒▒▒▒            ╢▒▒░░░▒┐
                           ▒▒▒▒▒▒             ╫▒░░░░░╗
                           ║▒▒▒▒▒              ╙▒░░░░░╣
 
              █▀▀█ █▀▀█ █▀▀▄ █▀▀█ █▀▀█ █▀▀ █▀▀█ █▀▀ ▀▀█▀▀ █▀▀█ █▀▀█ 
              █▄▄▀ █░░█ █▀▀▄ █░░█ █▄▄▀ █▀▀ █▄▄█ █░░ ░░█░░ █░░█ █▄▄▀ 
              ▀░▀▀ ▀▀▀▀ ▀▀▀░ ▀▀▀▀ ▀░▀▀ ▀▀▀ ▀░░▀ ▀▀▀ ░░▀░░ ▀▀▀▀ ▀░▀▀ 
                        █▀▀▀ █▀▀ █▀▀▄ █▀▀ █░░ █▀▀█ █░░░█ 
                        █░▀█ █▀▀ █░░█ █▀▀ █░░ █░░█ █▄█▄█ 
                        ▀▀▀▀ ▀▀▀ ▀░░▀ ▀░░ ▀▀▀ ▀▀▀▀ ░▀░▀░ 
                                   🅼 🅸 🅽 🅸  
${NC}"
echo -e "${Yellow}
======================================================================================
${NC}"

# keyboardinterrupt force installer to stop and remove all possible generated file
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Stop() {
       echo -e "${Yellow}
======================================================================================
       ${NC}"
       sudo rm -r ./RoboreactorGenFlow/data_token_secret.json ~/Face_db/ ~/Printrun/ ~/Roboreactor_Gen_config/ ~/RoboreactorGenFlow/ ~/Roboreactor_library/ ~/Roboreactor_projects/ > /dev/null 2>&1
       exit 0 
}
trap Stop INT

# coppy roboreactor files to final dir
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
for dir in \
        "$PWD/Face_db/" \
        "$PWD/Printrun/" \
        "$PWD/Roboreactor_Gen_config/" \
        "$PWD/RoboreactorGenFlow/" \
        "$PWD/Roboreactor_library/" \
        "$PWD/Roboreactor_projects/" 
do
    if ! [ -d "$dir" ]; then
       echo -e "${Red}
${dir} not found
please re download it from https://roboreactor.com/download
       ${NC}"
       echo -e "${Yellow}
======================================================================================
       ${NC}"
       exit 0 
    fi
done
if [ ! -f data_token_secret.json ]; then
    echo -e "${Red}
${PWD}/data_token_secret.json not found
please download it from your project page
    ${NC}"
    echo -e "${Yellow}
======================================================================================
    ${NC}"
    exit 0 
fi
sudo rm -r ./RoboreactorGenFlow/data_token_secret.json ~/Face_db/ ~/Printrun/ ~/Roboreactor_Gen_config/ ~/RoboreactorGenFlow/ ~/Roboreactor_library/ ~/Roboreactor_projects/ > /dev/null 2>&1
mkdir -p  ~/
sudo cp data_token_secret.json ./RoboreactorGenFlow/data_token_secret.json
sudo cp -r Face_db/ Printrun/ Roboreactor_Gen_config/ RoboreactorGenFlow/ Roboreactor_library/ Roboreactor_projects/ ~/
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
echo 'Initiate the roboreactor webclient '
cd ~/Printrun
sudo python3 -m pip install Cython
sudo python3 setup.py build_ext --inplace
sudo python3 setup.py install   # install click module at the python3 
cd ~/
#sudo apt-get install gparted -y 
git clone https://github.com/uoip/g2opy
cd ~/g2opy/
mkdir build && cd build  
sudo apt-get install build-essential cmake libeigen3-dev -y
sudo apt-get install -y libqglviewer-dev-qt5 -y 
#cmake configuretion 
make -j8
cd ~/
git clone -b alsapatch https://github.com/gglockner/portaudio
cd ~/portaudio
./configure && make
sudo make install
sudo ldconfig
cd ~/RoboreactorGenFlow
sudo apt install python3.8-venv 
sudo mkdir Face_db
sudo chmod -R 777 Face_db
sudo mkdir RoboreactorGenFlow_env
sudo chmod -R 777 RoboreactorGenFlow_env
sudo python3 -m venv RoboreactorGenFlow_env
cd ~/
sudo chmod +x /home/$USER/RoboreactorGenFlow/gunicorn
sudo mv /home/$USER/RoboreactorGenFlow/gunicorn -t /home/$USER/RoboreactorGenFlow/RoboreactorGenFlow_env/bin
sudo chmod -R 777 /var/log/
sudo mkdir /var/log/RoboreactorGenFlow
sudo chmod -R 777 /var/log/RoboreactorGenFlow
cd ~/RoboreactorGenFlow
sudo python3 configwriter_systemd.py
echo 'Start the roboreactor webclient'
sudo systemctl daemon-reload 
sudo systemctl enable RoboreactorGenFlow.service
sudo systemctl restart RoboreactorGenFlow.service 
sudo systemctl status RoboreactorGenFlow.service
sudo systemctl daemon-reload 
sudo systemctl enable Remote_request_config.service
sudo systemctl restart Remote_request_config.service
sudo systemctl status Remote_request_config.service
sudo chmod -R 777 /home/$USER/Roboreactor_projects 

echo -e "${Yellow}
======================================================================================	
${Green}
Roboreactor genflow service
${NC}"
sudo systemctl status RoboreactorGenFlow.service
echo -e "${Yellow}
======================================================================================	
${NC}"
