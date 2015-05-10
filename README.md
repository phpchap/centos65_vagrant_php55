centos-6.5-lamp-plus
====================

A simple modification of the https://vagrantcloud.com/smallhadroncollider/centos-6.5-lamp vagrant box 

A PHP 5.3/MySQL developer environment with virtual hosts for separate parallel projects.

one time provisioning
---------------------
* additional port forwarding, host: 80 to guest: 80
* php53u-mbstring
* nano
* phpMyAdmin
* password for mysql (required by phpMyAdmin)
* virtual hosts
* php session.save_path changed
* php error reporting changed

provisioning done on every startup
----------------------------------
* add new virtual host from a local file
* restart httpd

tools
-----
* phpMyAdmin is available via [localhost/phpMyAdmin](http://localhost/phpMyAdmin)

additional vhosts HOW-TO
------------------------
1. create a new project dir under the public directory, i.e. *public/myproj*
2. edit the *provision/httpd.conf.add.new.vhost* file by copying the contents of httpd.conf.append and replacing the lines 
  1. *DocumentRoot /vagrant/public* to *DocumentRoot /vagrant/public/myproj*
  2. *ServerName localhost* to *ServerName myproj.localhost*
3. edit your **host's** *hosts file* and add the new *myproj.localhost* domain targeted to 127.0.0.1
4. run *vagrant reload*
5. have fun :)

requirements
------------
the original box requires the virtualizastion turned on in BIOS