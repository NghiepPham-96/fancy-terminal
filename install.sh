#!/bin/bash
# FOR: Linux

#Check quyen root
user=`id | cut -d'=' -f2 | cut -d\( -f1`
if [ $user -ne 0 ]; then
    echo "Needs root authentication to install."
    exit 1
fi

# [starship]
curl -fsSL https://starship.rs/install.sh | sh -s -- -y
curl https://raw.githubusercontent.com/NghiepPham-96/fancy-terminal/main/starship.toml -o ~/.config/starship.toml

#Check differentiate between Ubuntu and other Linux platforms 
if [ -f /etc/debian_version ]; then
    #Check dung la Ubuntu
    echo "Đây là Ubuntu, tiến hành cài đặt!"
    apt-get update
    apt-get install gcc -y
elif [ -f /etc/alpine-release ]; then
    echo "Đây là Apline, tiến hành cài đặt!"
    apk update
    apk install gcc -y
else
    #Check khong phai la Ubuntu | Alpine
    #Con lai la Centos/Redhat | khác
    echo "Bạn da sử dụng sai bản cài đặt!"
    exit 0
fi

# [Rust]
# Install rust and cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# [=exa=]
cargo install exa

# [bash alias]
echo "# More alias to upgrade 'ls'" >> /etc/profile.d/alias.sh
echo "alias ll='exa -abghHlFiS --icons --group-directories-first --git'" >> /etc/profile.d/alias.sh
echo "alias l='exa --icons -F -H --group-directories-first --git -1'" >> /etc/profile.d/alias.sh
echo "alias ltree='exa --long --tree --icons --group-directories-first'" >> /etc/profile.d/alias.sh
. /etc/profile.d/alias.sh
