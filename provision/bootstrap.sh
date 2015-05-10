#!/usr/bin/env bash

#substitute public_html dir to the one synced from the host
rm -rf /var/www/public
ln -fs /vagrant/public /var/www/public

#install required packages
#sudo yum install -y php53u-mbstring
sudo yum -y install yum-plugin-replace
sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum -y install php55w php55w-opcache php55w-common php55w-cli php55w-mcrypt php55w-mysql php55w-pdo
sudo yum -y replace php53u --replace-with php55w
#sudo yum -y install nano
#sudo yum -y install phpMyAdmin

#configure phpmyadmin
sudo cp /vagrant/provision/config.inc.php /usr/share/phpMyAdmin
sudo chmod 644 /usr/share/phpMyAdmin/config.inc.php
#allow access from host
sudo sed -i 's/Allow from 127\.0\.0\.1/Allow from 10\.0\.2\.2/g' /etc/httpd/conf.d/phpMyAdmin.conf

#configure mysql pass for phpMyAdmin not accepting an empty password
sudo mysqladmin -u root password root

#configure apache
sudo sed -i 's/"\/var\/www\/public"/"\/vagrant\/public"/g' /etc/httpd/conf/httpd.conf
sudo sed -i 's/\#NameVirtualHost/NameVirtualHost/g' /etc/httpd/conf/httpd.conf
sudo bash -c "cat /vagrant/provision/httpd.conf.append >> /etc/httpd/conf/httpd.conf"

#configure php
sudo sed -i 's/session\.save_path = "\/var\/lib\/php\/session"/session\.save_path = "\/tmp"/g' /etc/php.ini
sudo sed -i 's/display_errors = Off/display_errors = On/g' /etc/php.ini
sudo sed -i 's/& ~E_NOTICE/\| E_STRICT/g' /etc/php.ini

#restart apache
sudo service httpd restart
