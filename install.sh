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
mkdir -p ~/.config/ && \
touch ~/.config/starship.toml && \
curl https://raw.githubusercontent.com/NghiepPham-96/fancy-terminal/main/starship.toml -o ~/.config/starship.toml

#Check differentiate between Ubuntu and other Linux platforms 
if [ -f /etc/debian_version ]; then
    #Check dung la Ubuntu
    echo "Đây là Ubuntu, tiến hành cài đặt!"

    if ! apt list gcc &> /dev/null; then
        apt-get update
        apt-get install gcc -y
    fi
elif [ -f /etc/alpine-release ]; then
    echo "Đây là Apline, tiến hành cài đặt!"

    if ! apk list gcc &> /dev/null; then
        apk update
        apk add build-base
    fi
else
    #Check khong phai la Ubuntu | Alpine
    #Con lai la Centos/Redhat | khác
    echo "Bạn da sử dụng sai bản cài đặt!"
    exit 0
fi

# [=exa=]
if ! command -v cargo &> /dev/null; then
    echo "exa could not be found.. Installing exa the mordern 'ls'"

    # [Rust]
    if ! command -v cargo &> /dev/null; then
        echo "Cargo could not be found.. Installing Cargo"
    
        # Install rust and cargo
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi

    cargo install exa
fi

# [bash]
if ! cat ~/.bashrc | grep 'eval "$(starship init bash)"'; then
    echo "Setup automatically load starship to bash terminal"
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

if ! cat ~/.bashrc | grep '. ~/.bash_aliases'; then
    echo "Setup automatically load starship to bash terminal"
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

# [bash alias]
if ! cat ~/.bashrc | grep '^.*\. ~/.bash_aliases$'; then
    echo -en "if [ -f ~/.bash_aliases ]; then\n    . ~/.bash_aliases\nfi" >> ~/.bashrc

    echo '#!/bin/bash' > ~/.bash_aliases
    echo "# More alias to upgrade 'ls'" >> ~/.bash_aliases
    echo "alias ll='exa -abghHlFiS --icons --group-directories-first --git'" >> ~/.bash_aliases
    echo "alias l='exa --icons -F -H --group-directories-first --git -1'" >> ~/.bash_aliases
    echo "alias ltree='exa --long --tree --icons --group-directories-first'" >> ~/.bash_aliases
#    chmod u+x ~/.bash_aliases
fi

# [bash]
echo '#!/bin/bash' > /etc/profile.d/starship.sh
echo 'eval "$(starship init bash)"' >> /etc/profile.d/starship.sh
chmod 777 /etc/profile.d/starship.sh
# . /etc/profile.d/starship.sh
# [bash alias]
echo "# More alias to upgrade 'ls'" > /etc/profile.d/alias.sh
echo "alias ll='exa -abghHlFiS --icons --group-directories-first --git'" >> /etc/profile.d/alias.sh
echo "alias l='exa --icons -F -H --group-directories-first --git -1'" >> /etc/profile.d/alias.sh
echo "alias ltree='exa --long --tree --icons --group-directories-first'" >> /etc/profile.d/alias.sh
chmod 777 /etc/profile.d/alias.sh
# . /etc/profile.d/alias.sh
