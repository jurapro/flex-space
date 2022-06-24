#!/bin/bash
echo "Starting django"

if [ -f /web_django/manage.py ]; then echo "Directory not empty" 
else
django-admin startproject web_django /web_django;
fi
chmod 777 -R /web_django

service ssh start