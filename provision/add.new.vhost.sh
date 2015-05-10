sudo bash -c "cat /vagrant/provision/httpd.conf.add.new.vhost >> /etc/httpd/conf/httpd.conf"
sudo service httpd restart
sudo bash -c "echo '' > /vagrant/provision/httpd.conf.add.new.vhost"
