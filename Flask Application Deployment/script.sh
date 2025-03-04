#!/bin/bash

# Resources
# 1. https://www.linode.com/docs/guides/flask-and-gunicorn-on-ubuntu/
# 2. https://www.geeksforgeeks.org/deploying-python-applications-with-gunicorn/

# Cloning the Repo                                                                                                      
sudo yum update                                                                                        
sudo yum install git -y                                                                                                 
git clone https://github.com/nada-086/ToDo-App.git ToDo-App         


# Setting Up Python Environement                                                                                        
sudo yum install python3 python3-pip -y                                                                                                                                                                                            
## Setting Up the Virtual Enviroment                                                                                    
cd ToDo-App                                                                                                             
python3 -m venv venv                                                                                                    
source venv/bin/activate                                                                                                
pip install -r requirements.txt

# Database Setup                                                                                                        
sudo yum install sqlite -y    
flask db init
flask db migrate -m "Initial migration."
flask db upgrade


# Setting Up Gunicorn                                                                                                   
pip install gunicorn                                                                                                    
gunicorn -w 1 -b 0.0.0.0:8000 main:app &

# Setting Up Nginx                                                                                                      
sudo yum install nginx -y            
sudo systemctl start nginx
sudo systemctl enable nginx    

## Nginx Configuration                                                                                                  
sudo touch /etc/nginx/conf.d/flask_app.conf                                                                                  
cat > /etc/nginx/conf.d/flask_app.conf << EOF                                                                          
server {
    listen 80;
    server_name localhost;

     location / {
        proxy_pass http://127.0.0.1:8000;
    }
}
EOF
sudo nginx -s reload

# Firewall Configuration
sudo yum install firewalld -y
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

# Setting SeBoolean
sudo setsebool -P httpd_can_network_connect on