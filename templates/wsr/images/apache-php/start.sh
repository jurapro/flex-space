#!/bin/bash


echo "starting services ..."
chmod 777 -R /var/www/html
service ssh start
apache2-foreground

echo "...done!"