'''
Author: Chanapai Chuadchum 
Project: Roboreactor_cponfig_writer_systemd 
Description: The software to write the configuretion file to system running at boot 
Latest_update:2022/11/23 
'''
import os
import pwd
import time
import configparser 

user =  os.listdir("/home/")[0]
try:
   os.mkdir("/usr/lib/systemd/system",mode=0o777)
except:
    print("System directory was created")
Generate_path = "/usr/lib/systemd/system/" 
os.system("sudo chmod -R 777 "+Generate_path)
project_name = 'Project:RoboreactorGenFlow'
mode = 'multi-user.target' 
Python_exc_path = "/bin/bash "
Working_path = "/home/"+user+"/RoboreactorGenFlow"
Execute_path = "/home/"+user+"/RoboreactorGenFlow/runsystem.sh"   #Change username over the platform 
Execute_path1 = "/home/"+user+"/RoboreactorGenFlow/request_config.py"
config = configparser.ConfigParser() 
config.optionxform = str
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Running Roboreactor_installer
settings = ['Unit','Service','Install']
#Unit
config.add_section(settings[0]) # Getting the section added into the list topic 
config.set(settings[0],'Description',str(project_name)) 
config.set(settings[0],'After',str(mode))
#Service 
config.add_section(settings[1])
config.set(settings[1],'Type','idle')
config.set(settings[1],'WorkingDirectory',Working_path)
config.set(settings[1],'User',str(user))
config.set(settings[1],'ExecStart',str(Python_exc_path+Execute_path))
config.set(settings[1],'WantedBy','always')
#Install 
config.add_section(settings[2])
config.set(settings[2],'WantedBy',str(mode))
configfile = open(Generate_path+"RoboreactorGenFlow.service",'w')
config.write(configfile)
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
config1 = configparser.ConfigParser() 
config1.optionxform = str
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Running remote_request_config
#Unit
config1.add_section(settings[0]) # Getting the section added into the list topic 
config1.set(settings[0],'Description',"Request_remote_config") 
config1.set(settings[0],'After',str(mode))
#Service 
config1.add_section(settings[1])
config1.set(settings[1],'Type','idle')
config1.set(settings[1],'WorkingDirectory',Working_path)
config1.set(settings[1],'User',str(user))
config1.set(settings[1],'ExecStart',str(Python_exc_path+Execute_path1))
config1.set(settings[1],'WantedBy','always')
#Install 
config1.add_section(settings[2])
config1.set(settings[2],'WantedBy',str(mode))
configfile1 = open(Generate_path+"Remote_request_config.service",'w')
config1.write(configfile1)





