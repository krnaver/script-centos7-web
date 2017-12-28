#!/bin/bash
################################################################################
#
#	Xavatar / Tatar
#
################################################################################


	# Mise à jour du system
	
	clear
    echo ""
    echo "Updating system and installing required packages."
    echo ""
	sleep 3
	
	sudo yum -y update
	sudo yum -y upgrade
	sudo yum -y groupinstall "Development Tools" 
	sudo yum -y install gmp-devel mysql-devel curl-devel libidn-devel libssh2-devel python-devel openldap-devel vim memcached wget git epel-release net-tools bind-utils
	echo ""
    echo "Arret du Firewall :"
	echo ""
	sudo systemctl stop firewalld
	echo ""
	sudo systemctl status firewalld
	echo ""
	echo "Vérifixation de SeLinux :"
	echo ""
	sudo sestatus
	echo ""
	sleep 5
	clear
	
	
	# Installation NGINX
	echo ""
    echo "Installation NGINX :"
    echo ""
	sleep 3
	sudo yum -y install nginx
	echo ""
	systemctl start nginx.service
	systemctl enable nginx.service
	echo ""
    echo "Vérification de NGINX :"
	echo ""
	sudo systemctl status nginx.service
	echo ""
	sleep 5
	clear
	
		
	# Installation DB (MariaDB)
	clear
	echo ""
    echo "Installation MariaDB :"
    echo ""
	sleep 3
	sudo yum -y install mariadb-server mariadb
	sudo systemctl start mariadb 
	sudo systemctl enable mariadb
	echo ""
    echo "Vérification de DB :"
	echo ""
	sudo systemctl status mariadb.service
	echo "Mise en route DB :"
	sudo mysql_secure_installation
	echo ""
	sleep 5
	clear
	
	# Installation PHP
	clear
	echo ""
    echo "Installation PHP :"
    echo ""
	sleep 3
	sudo yum -y install php70 php70-php-mysqlnd php70-php-common php70-php-fpm php70-php-gd php70-php-ldap php70-php-odbc php70-php-pear php70-php-xml php70-php-xmlrpc php70-php-mbstring php70-php-snmp php70-php-soap php70-php-mcrypt php70-php-pecl-memcache
	sudo systemctl start memcached
	sudo systemctl enable memcached
	sudo systemctl start php-fpm
	sudo systemctl enable php-fpm
	echo ""
    echo "Vérification de Memcache :"
	echo ""
	sudo systemctl status memcached
	echo ""
	sudo systemctl status php-fpm
	echo ""
	sleep 5
	clear
	
	
	# Installation APC
	clear
	echo ""
    echo "Installation APC :"
    echo ""
	sleep 3
	sudo yum -y install php-pear php-devel pcre-devel gcc make
	cd
	sudo pecl install apc
	echo "extension=apc.so" >> /etc/php.d/apc.ini
	echo ""
	sleep 5
	clear
	
	
	# Installation phpMyAdmin
	clear
	echo ""
    echo "Installation phpMyAdmin :"
    echo ""
	sleep 3
	sudo yum -y install phpMyAdmin
	echo ""
	echo ""
    echo "Relance Apache + PHP-FPM :"
	echo ""
	sudo systemctl restart nginx
	sudo systemctl restart php-fpm 
	echo ""
	echo ""
	sudo systemctl status nginx
	echo ""
	sudo systemctl status php-fpm
	echo ""
	sudo systemctl status memcached
	echo ""
	echo ""
	echo "Installation Finish. Voir le readme pour la conf."