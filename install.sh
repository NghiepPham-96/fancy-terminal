#!/bin/bash
# FOR: Alpine

[starship]
curl -fsSL https://starship.rs/install.sh | sh -s -- -y
curl https://raw.githubusercontent.com/NghiepPham-96/fancy-terminal/android-termux/starship.toml -o ~/.config/starship.toml

[Alpine]
sudo apk update
sudo apk install gcc -y

[Rust]
# Install rust and cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

[=exa=]
cargo install exa

[bash alias]
echo "alias ll='exa -abghHlFiS --icons --group-directories-first --git'" >> ~/.bash_aliases
echo "alias l='exa --icons -F -H --group-directories-first --git -1'" >>  ~/.bash_aliases
echo "alias ltree='exa --long --tree --icons --group-directories-first'" >>  ~/.bash_aliases
