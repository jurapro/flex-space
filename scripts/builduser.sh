#!/bin/bash

APP_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd )"

cache=""

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done

if [ -z ${user+x} ]; then
echo "User not selected!" >&2
echo "Choose from the following users: "$(ls $APP_DIR/users/) >&2
exit 1
fi

if [ ! -d $APP_DIR/users/$user ]; then
echo "User '$APP_DIR/users/$user' not found!" >&2
echo "Choose from the following users: "$(ls $APP_DIR/users/) >&2
exit 1
fi

echo "Building user '$APP_DIR/users/$user'"
docker-compose -f $APP_DIR/users/$user/docker-compose.yml build $cache