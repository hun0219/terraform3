#!/bin/bash
sudo su -
mkdir /web
cd /web
wget https://downloads.apache.org/apr/apr-1.7.0.tar.gz
wget https://downloads.apache.org/apr/apr-util-1.6.1.tar.gz
wget https://downloads.apache.org/httpd/httpd-2.4.51.tar.gz
wget https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz --no-check-certificate
tar xvfz apr-1.7.0.tar.gz
tar xvfz apr-util-1.6.1.tar.gz
tar xvfz httpd-2.4.51.tar.gz
tar xvfz pcre-8.45.tar.gz
yum install -y expat-devel gcc gcc-c++
cd apr-1.7.0 ; ./configure --prefix=/web/apr ; make && make install
cd ../apr-util-1.6.1 ; ./configure --prefix=/web/aprutil --with-apr=/web/apr ; make && make install
cd ../pcre-8.45 ; ./configure --prefix=/web/pcre ; make && make install
cd ../httpd-2.4.51 ; ./configure --prefix=/usr/local/apache2 --with-apr=/web/apr --with-apr-util=/web/aprutil --with-pcre=/web/pcre ; make && make install
curl http://169.254.169.254/latest/meta-data/hostname -o /usr/local/apache2/htdocs/index.html
/usr/local/apache2/bin/apachectl start
