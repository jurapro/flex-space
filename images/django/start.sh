#!/bin/bash
echo "Starting django"

if [ -f /web_django/manage.py ]; then echo "Directory not empty" 
else
django-admin startproject web_django /web_django;
touch /web_django/db.sqlite3
chmod 777 -R /web_django
fi