#!/usr/bin/env bash

#substitute public_html dir to the one synced from the host
rm -rf /var/www/logistic-engine
ln -fs /vagrant/logistic-engine/application /var/www/logistic-engine

#install required packages
sudo yum -y update
sudo yum -y install git
sudo yum -y install yum-plugin-replace
sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum -y install nginx
sudo yum -y install php55w php55w-opcache php55w-common php55w-cli php55w-mcrypt php55w-mysql php55w-pdo php55w-fpm php55w-xml
sudo yum -y install vim

#configure mysql pass for phpMyAdmin not accepting an empty password
sudo mysqladmin -u root password root

#configure php
sudo sed -i 's/session\.save_path = "\/var\/lib\/php\/session"/session\.save_path = "\/tmp"/g' /etc/php.ini
sudo sed -i 's/display_errors = Off/display_errors = On/g' /etc/php.ini
sudo sed -i 's/& ~E_NOTICE/\| E_STRICT/g' /etc/php.ini
sudo sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php.ini

#configure nginx
sudo sed -i 's/user = apache/user = nginx/g' /etc/php-fpm.d/www.conf
sudo sed -i 's/group = apache/group = nginx/g' /etc/php-fpm.d/www.conf
sudo sed -i 's/worker_processes  1/worker_processes  4/g' /etc/nginx/nginx.conf
sudo sed -i s'/listen = 127.0.0.1:9000/listen = \/var\/run\/php-main.socket/' /etc/php-fpm.d/www.conf
sudo sed -i s'/;listen.owner = nobody/listen.owner = nginx/' /etc/php-fpm.d/www.conf
sudo sed -i s'/;listen.group = nobody/listen.group = nginx/' /etc/php-fpm.d/www.conf
sudo sed -i s'/;listen.mode = 0660/listen.mode = 0660/' /etc/php-fpm.d/www.conf
sudo bash -c "cat /vagrant/provision/nginx.conf.append >> /etc/nginx/conf.d/default.conf"

sudo chmod -R 777 /vagrant/application/app/cache
sudo chmod -R 777 /vagrant/application/app/logs
sudo chown -R nginx:nginx /vagrant/application/app/cache
sudo chown -R nginx:nginx /vagrant/application/app/logs

#stop apache
#sudo service httpd stop

#start nginx
sudo service php-fpm restart
sudo service nginx start
