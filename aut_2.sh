

# При авторизации даётся 3 попытки на ввод пароля. Пароли в файле хранятся 
#в виде хэшей. Направлять ошибки в файл, 
#а сообщения о неуспешной авторизации (3 попытки прошли не успешно) в особенный новый файл.

count=0
while read -p 'Введите логин: ' login
do 
    count=$(($count+1))
    if [[ $(grep -w $login logins.txt) ]]
    then
        index_line=$(grep -n -w $login logins.txt | cut -d: -f1) # получаем номер строки для пароля 
        user_password=$(cat passwords.txt | head -n$index_line | tail -n1 ) # получаем пароль по номеру строки
        read  -s -t 5 -p 'Введите пароль: ' password <&1
        password_hash=$(echo "$password" | md5sum)
        if [[ $password_hash == $user_password ]]
        then
            echo "Вы успешно авторизовались"
            break
        else
            echo "Вы ввели неправильный пароль"
            echo "Ошибка: неверный пароль">>errors.txt
        fi
    else
        echo "Нет такого логина"
        echo "Несуществующий логин">>errors.txt
    fi
    if [[ $count -eq 3 ]]
    then
        echo "Неуспешная авторизация"
        echo "3 попытки прошли не успешно">>threeattempts.txt
        break
    fi
    
done
