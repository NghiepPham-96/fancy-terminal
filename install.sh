#!/bin/bash
# FOR: Window

[starship]
winget install --id Starship.Starship
curl https://raw.githubusercontent.com/NghiepPham-96/fancy-terminal/android-termux/starship.toml -o ~/.config/starship.toml

[bash]
echo 'eval "$(starship init bash)"' >> ~/.bashrc
[powershell]
echo 'Invoke-Expression (&starship init powershell)' >> $PROFILE
