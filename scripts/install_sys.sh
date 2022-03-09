#!/bin/bash
## install base system
## [JCG] creation d'un script system de base commun à toutes les VMS


IP=$(hostname -I | awk '{print $2}')
#Utilisateur a créer (si vide pas de création)
NOM=""
MDP=""
HDIR=""

APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_sys.log"
DEBIAN_FRONTEND=noninteractive

echo "START - Install Base System on "$IP

echo "=> [1]: Installing required packages..."
sudo apt update $APT_OPT \
  >> $LOG_FILE 2>&1

sudo apt-get install $APT_OPT \
  wget \
  gnupg \
  unzip \
  >> $LOG_FILE 2>&1

echo "=> [2]: Install Apache 2 et Php"
sudo apt-get install $APT_OPT \
  apache2 \
  php \
  libapache2-mod-php \
  php-mysql \
  php-intl \
  php-curl \
  php-xmlrpc \
  php-soap \
  php-gd \
  php-json \
  php-cli \
  php-pear \
  php-xsl \
  php-zip \
  php-mbstring \
  >> $LOG_FILE 2>&1

sudo systemctl restart apache2

#Test avec un ficihier php
cp /vagrant/files/info.php /var/www/html/info.php

echo "=> [3]: Ajout utilisateur"
# ajout utilisateur et autres
if [ -n "$NOM" ] ;then
  mkdir -p $HDIR
  adduser --home $HDIR --disabled-password --no-create-home $NOM
  echo $NOM:$MDP | chpasswd
  chown $NOM $HDIR
  chmod 755 $HDIR
fi

echo "END - Install Base System on "$IP
