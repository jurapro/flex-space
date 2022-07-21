#!/bin/bash

APP_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}")/.." &> /dev/null && pwd )"

if [[ $1 = "all" ]]; then
   for USER in $(ls $APP_DIR/users/)
   do
      module=""     
      if [[ $# -eq 2 ]] ; then
         module="$2"
      fi
      if [[ -e $APP_DIR/users/$USER/docker-compose.yml  ]]; then
         echo ""
         echo "Starting user '$USER'"
         docker-compose -f $APP_DIR/users/$USER/docker-compose.yml up -d $module
      fi
   done
   exit 0
fi

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

echo "Starting user '$user'"
docker-compose -f $APP_DIR/users/$user/docker-compose.yml up -d $module