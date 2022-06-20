#!/bin/bash


echo "starting services ..."

service ssh start
apache2-foreground

echo "...done!"