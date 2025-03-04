# Flask To-Do App Deployment

The following guide explains the deployment process of a Flask ToDo Application using a Bash script on a Linux server (CentOS/RHEL-based systems).

## Deployment Script Overview
The provided script automates the deployment process by:
- Cloning the repository
- Setting up SQLite for database management
- Configuring a Python virtual environment
- Installing Gunicorn for running the Flask app
- Setting up and configuring Nginx as a reverse proxy
- Configuring the firewall and SELinux settings

## Deployment Steps
The deployment script executes the following steps:

### 1. System Update & Repository Cloning
```bash
sudo yum update -y
sudo yum install git -y
git clone https://github.com/nada-086/ToDo-App.git ToDo-App
```
- Updates system packages.
- Installs Git.
- Clones the Flask To-Do App repository.

### 2. Setting Up Python Environment
```bash
sudo yum install python3 python3-pip -y
cd ToDo-App
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```
- Installs Python 3 and pip.
- Creates and activates a Python virtual environment.
- Installs project dependencies from `requirements.txt`.

### 5. Database Setup
```bash
sudo yum install sqlite -y
flask db init
flask db migrate -m "Initial migration."
flask db upgrade
```
- Installs SQLite, the database used by the Flask application.
- Initializes Flask Migrator to build the database tables.

### 4. Running Gunicorn
```bash
pip install gunicorn
gunicorn -w 1 -b 0.0.0.0:8000 main:app &
```
- Installs Gunicorn, a WSGI server for running the Flask app.
- Starts Gunicorn with 1 worker, binding to port `8000`.

### 5. Setting Up Nginx
```bash
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
```
- Installs and starts Nginx.
- Enables Nginx to start on boot.

### 6. Configuring Nginx
```bash
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
```
- Creates a new Nginx configuration file for the Flask app.
- Configures Nginx to reverse proxy requests to Gunicorn on port `8000`.
- Reloads Nginx to apply the new configuration.

### 7. Configuring Firewall
```bash
sudo yum install firewalld -y
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
```
- Installs and starts `firewalld`.
- Enables HTTP traffic through the firewall.

### 8. Configuring SELinux
```bash
sudo setsebool -P httpd_can_network_connect on
```
- Configures SELinux to allow HTTPD (Nginx) to connect to network services.

## Running the Application
After running the script, the Flask To-Do application should be accessible via:
```
http://<server-ip>/
```

## References
- [Flask & Gunicorn Deployment Guide](https://www.linode.com/docs/guides/flask-and-gunicorn-on-ubuntu/)
- [Deploying Python Applications with Gunicorn](https://www.geeksforgeeks.org/deploying-python-applications-with-gunicorn/)
- [ToDo App Repo](https://github.com/nada-086/ToDo-App.git)