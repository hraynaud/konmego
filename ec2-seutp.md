
## Step 1: Install Nginx
sudo dnf update -y
sudo dnf install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx


## Step 2: Install Certbot
###install snapd
sudo dnf install -y snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap



###Now install Certbot:
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
certbot --version

### or if on Amazon Linux 2023 (AL2023)
sudo dnf install -y python3 python3-pip
sudo pip3 install certbot certbot-nginx

sudo ln -s /home/ec2-user/.local/bin/certbot /usr/bin/certbot


## Step 3: Configure Nginx Reverse Proxy
sudo vi /etc/nginx/conf.d/api.myapp.com.conf

add this:
```
server {
    listen 80;
    server_name api.myapp.com;

    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

sudo nginx -t
sudo systemctl reload nginx

# Add cron

sudo apt update
sudo apt install cron -y
sudo systemctl enable --now cron
