#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

userName=$1

if [ ! -n "$userName" ]; then
    echo "Undefined user name"
    exit
fi

echo "AddUserRun"

if [ ! $(getent group hosting) ]; then
  addgroup "hosting"
fi

# eval "useradd $userName";

passwordBase64=$(openssl rand -base64 32)
password=${passwordBase64//[=\/]/X}
useradd "-m" "-U" "-p" $password $userName
# echo "$password" | passwd "$userName" "--stdin"
echo -e "$password\n$password" | (passwd $userName)
echo $password
usermod "-aG" "hosting" "$userName" 
userDirectory="/var/www/$userName"

mkdir $userDirectory
mkdir "$userDirectory/www"
chown "-R" "$userName:$userName" "$userDirectory"
chmod "-R" "711" "$userDirectory"
usermod "-d" "$userDirectory" "$userName"

currentPath=$PWD

# echo $currentPath
cp -v fpm.conf "$currentPath/$userName.conf"
sed -i "s/userName/$userName/" "$userName.conf"
mv "$userName.conf" "/etc/php/8.1/fpm/pool.d/$userName.conf"
service php8.1-fpm restart
