#!/bin/bash

## install Moodle Application
## https://moodle.org/

echo "--------------------------"
echo "|RUNNING install_moodle.sh|"
echo "--------------------------"

IP=$(hostname -I | awk '{print $2}')
APT_OPT="-o Dpkg::Progress-Fancy="0" -q -y"
LOG_FILE="/vagrant/logs/install_moodle.log"
DEBIAN_FRONTEND="noninteractive"
MOODLE_VERSION="311"

echo "START - Configuration Moodle  - "$IP

echo "=> [1]: Download and extract moodle files ..."
# le moteur de moodle
wget -q -O /tmp/moodle.tgz \
http://download.moodle.org/download.php/direct/stable${MOODLE_VERSION}/moodle-latest-${MOODLE_VERSION}.tgz \
>> $LOG_FILE 2>&1

tar xzf /tmp/moodle.tgz -C /var/www/html \
>> $LOG_FILE 2>&1
rm /tmp/moodle.tgz

echo "=> [2]: Create files and permissions"
mkdir /var/www/data
chown www-data:www-data -R /var/www/data
chown www-data:www-data -R /var/www/html/moodle

echo "=> [3]: Moodle Configuration ..."
php /var/www/html/moodle/admin/cli/install.php \
  --lang="en" \
  --wwwroot="http://192.168.5.10/moodle" \
  --dataroot="/var/www/data" \
  --dbtype="mariadb" \
  --dbhost="" \
  --dbuser="moodle_user" \
  --dbpass="1621a9" \
  --dbname="moodle" \
  --fullname="Admin du Site" \
  --shortname="adm" \
  --adminpass="1621a9" \
  --agree-license \
  --non-interactive \
  >> $LOG_FILE 2>&1

chown www-data:www-data -R /var/www/html/moodle/admin/cli/install.php

echo "Restarting Apache..."
service apache2 restart

cat <<EOF
Service installed at http://192.168.56.82/moodle

You will need to add a hosts file entry for:

username: admin
password: 1621a9

EOF
cat <<EOF > /etc/cron.d/moodle
*/30 * * * * www-data /usr/bin/env php /var/www/html/moodle/html/admin/cli/cron.php
EOF

echo "END - Configuration Moodle"
