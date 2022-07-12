#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd )"

login="usr_$(openssl rand -base64 3)"
password=$(openssl rand -base64 3)
template="wsr"

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done


if [ -d $SCRIPT_DIR/users/$login ]
then
echo "The '$SCRIPT_DIR/users/$login' directory exists! Choose a different username!" >&2
exit 1
fi

if [ ! -d $SCRIPT_DIR/templates/$template ]; then
echo "Template '$SCRIPT_DIR/templates/$template' not found!" >&2
echo "Choose from the following templates: "$(ls $SCRIPT_DIR/templates/) >&2
exit 1
fi

echo "Create a user: $login, password: $password, template: $template"

echo "Copying the template '$SCRIPT_DIR/templates/$template'..."
cp $SCRIPT_DIR/templates/$template -a -T $SCRIPT_DIR/users/$login
echo "Copy completed"
echo "Applying user setting..."


if [ ! -f $SCRIPT_DIR/users/$login/.env ]; then
echo "The '$SCRIPT_DIR/users/$login/.env' file not exists" >&2
exit 1
fi

sed -i -r "s/^(USER_LOGIN=).*/\1${login}/" $SCRIPT_DIR/users/$login/.env
sed -i -r "s/^(USER_PASSWORD=).*/\1${password}/" $SCRIPT_DIR/users/$login/.env
sed -i -r "s/^(DB_NAME=).*/\1db_${login}/" $SCRIPT_DIR/users/$login/.env


echo "User settings applied"