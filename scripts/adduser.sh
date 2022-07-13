#!/bin/bash

APP_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd )"

login="user_$(openssl rand -base64 3)"
password=$(openssl rand -base64 3)
template="wsr"

function getRandomPort {
   value=0
   while [ "$value" -le $1 ]
   do
   value=$(( $RANDOM * 2 ))
   done

   echo $(( $value ))
}

min_port=10000
web_port=$( getRandomPort $min_port)

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done


if [ -d $APP_DIR/users/$login ]
then
echo "The '$APP_DIR/users/$login' directory exists! Choose a different username!" >&2
exit 1
fi

if [ ! -d $APP_DIR/templates/$template ]; then
echo "Template '$APP_DIR/templates/$template' not found!" >&2
echo "Choose from the following templates: "$(ls $APP_DIR/templates/) >&2
exit 1
fi

echo "Create a user: $login, password: $password, template: $template"

echo "Copying the template '$APP_DIR/templates/$template'..."
cp $APP_DIR/templates/$template -a -T $APP_DIR/users/$login
echo "Copy completed"
echo "Applying user setting..."


if [ ! -f $APP_DIR/users/$login/.env ]; then
echo "The '$APP_DIR/users/$login/.env' file not exists" >&2
exit 1
fi

sed -i -r "s/^(USER_LOGIN=).*/\1${login}/" $APP_DIR/users/$login/.env
sed -i -r "s/^(USER_PASSWORD=).*/\1${password}/" $APP_DIR/users/$login/.env
sed -i -r "s/^(DB_NAME=).*/\1db_${login}/" $APP_DIR/users/$login/.env
sed -i -r "s/^(USER_DB_PASSWORD=).*/\1${password}/" $APP_DIR/users/$login/.env
sed -i -r "s/^(WEB_PORT=).*/\1${web_port}/" $APP_DIR/users/$login/.env

for ARGUMENT in $(grep SSH_PORT_* $APP_DIR/users/$login/.env)
do
   port=$( getRandomPort $min_port)

   while [[ $(grep $port $APP_DIR/users/*/.env) ]]
   do
   port=$( getRandomPort $min_port)
   done 

   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   sed -i -r "s/^($KEY=).*/\1${port}/" $APP_DIR/users/$login/.env
done


echo "User settings applied"