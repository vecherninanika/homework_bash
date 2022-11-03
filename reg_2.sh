#!/bin/bash
# скрипт регистрации
flag='False'
while [[ $flag=='False' ]]
do
read -p "Введите логин: " login
if grep -w $login logins.txt
then
    echo "Имя занято"
else
    read -s -p "Введите пароль: " password
    echo "Вы успешно зарегистрировались"
    echo "$login">>logins.txt
    echo "$password" | md5sum>>passwords.txt
    flag='True'
    break
fi
done