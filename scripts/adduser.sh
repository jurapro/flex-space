#!/bin/bash

for ARGUMENT in "$@"
do
   KEY=$(echo $ARGUMENT | cut -f1 -d=)

   KEY_LENGTH=${#KEY}
   VALUE="${ARGUMENT:$KEY_LENGTH+1}"

   export "$KEY"="$VALUE"
done


echo "Создаем пользователя: $login, пароль: $password, шабон: $template"

echo "Копируем шаблон"
cp templates/$template -a -T users/$login

echo "Копирование завершено"

sed -i -r "s/^(USER_LOGIN=).*/\1${login}/" users/$login/.env
sed -i -r "s/^(USER_PASSWORD=).*/\1${password}/" users/$login/.env
sed -i -r "s/^(DB_NAME=).*/\1db_${login}/" users/$login/.env