#!/bin/bash
# FOR: Linux

#Check quyen root
user=`id | cut -d'=' -f2 | cut -d\( -f1`
if [ $user -ne 0 ]; then
    echo "Needs root authentication to install."
    exit 1
fi

# [fish]
#Check differentiate between Ubuntu and other Linux platforms 
if [ -f /etc/debian_version ]; then
    #Check dung la Ubuntu
    echo "Đây là Ubuntu, tiến hành cài đặt!"

    apt-add-repository ppa:fish-shell/release-3
    apt update
    apt install fish
elif [ -f /etc/alpine-release ]; then
    echo "Đây là Apline, tiến hành cài đặt!"
else
    #Check khong phai la Ubuntu | Alpine
    #Con lai la Centos/Redhat | khác
    echo "Bạn da sử dụng sai bản cài đặt!"
    exit 0
fi
