#!/usr/bin/env bash
#Bash script that sets up your web servers for the deployment of web_static

sudo apt-get update
sudo apt-get install nginx -y
sudo mkdir -p /data/web_static/shared
sudo mkdir -p /data/web_static/releases/test

sudo touch /data/web_static/releases/test/index.html

echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" >> /data/web_static/releases/test/index.html

if [ -h /data/web_static/current ]; then
    rm /data/web_static/current
else
    sudo ln -s /data/web_static/releases/test/ /data/web_static/current
fi

sudo chown -R ubuntu:ubuntu /data/

# update Nginx config to serve /data/web_static/current at /hbnb_static/
sudo sed -i "26i \\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current;\n\t}\n" /etc/nginx/sites-available/default

#restart the server to load changes
sudo service nginx restart

#sudo systemctl restart nginx