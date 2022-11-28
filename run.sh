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

# force installer to stop and remove all possible generated file
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Stop() {
       echo -e "${Yellow}
======================================================================================
       ${NC}"
       sudo rm -r ~/Face_db/ ~/Printrun/ ~/Roboreactor_Gen_config/ ~/RoboreactorGenFlow/ ~/Roboreactor_library/ ~/Roboreactor_projects/ > /dev/null 2>&1
}
trap Stop EXIT

# coppy roboreactor files to final dir
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
sudo rm -r ~/Face_db/ ~/Printrun/ ~/Roboreactor_Gen_config/ ~/RoboreactorGenFlow/ ~/Roboreactor_library/ ~/Roboreactor_projects/ > /dev/null 2>&1
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
       exit 0 
    fi
done
if [ ! -f data_token_secret.json ]; then
    echo -e "${Red}
${PWD}/data_token_secret.json not found
please download it from your project page
    ${NC}"
    exit 0 
fi
mkdir -p  ~/
sudo cp -r Face_db/ Printrun/ Roboreactor_Gen_config/ RoboreactorGenFlow/ Roboreactor_library/ Roboreactor_projects/ ~/
sudo cp data_token_secret.json ~/RoboreactorGenFlow/data_token_secret.json
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
echo 'Initiate the roboreactor webclient '
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