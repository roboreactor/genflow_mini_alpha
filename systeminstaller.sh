echo 'Initiate the roboreactor webclient installer'
git clone https://github.com/KornbotDevUltimatorKraton/RoboreactorGenFlow
cd ~/RoboreactorGenFlow 
sudo mkdir Face_db
sudo chmod -R 777 Face_db
sudo mkdir RoboreactorGenFlow_env 
sudo chmod -R 777 RoboreactorGenFlow_env
sudo python3 -m venv RoboreactorGenFlow_env 
cd ~
sudo chmod +x /home/$USER/RoboreactorGenFlow/gunicorn
sudo mv /home/$USER/RoboreactorGenFlow/gunicorn -t /home/$USER/RoboreactorGenFlow/RoboreactorGenFlow_env/bin
sudo chmod -R 777 /var/log/
sudo mkdir /var/log/RoboreactorGenFlow
sudo chmod -R 777 /var/log/RoboreactorGenFlow
cd ~/RoboreactorGenFlow
sudo python3 configwriter_systemd.py 

sudo systemctl daemon-reload 
sudo systemctl enable RoboreactorGenFlow.service
sudo systemctl restart RoboreactorGenFlow.service 
sudo systemctl status RoboreactorGenFlow.service

sudo systemctl daemon-reload 
sudo systemctl enable Remote_request_config.service
sudo systemctl restart Remote_request_config.service
sudo systemctl status Remote_request_config.service
