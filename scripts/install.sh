#!/bin/bash

sudo pacman -Syu

sudo pacman -S --noconfirm --needed git 

# Install yay
sudo pacman -S --noconfirm --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Core (change to intel-ucode if there is an intel chip in the system)
sudo pacman -S --noconfirm --needed amd-ucode
# Wifi, bluetooth etc
sudo pacman -S --noconfirm --needed bluez bluez-utils cups networkmanager 
# CLI Tools
sudo pacman -S --noconfirm --needed nvim fzf tree-sitter tree-sitter-cli ripgrep tmux btop fastfetch tldr tree

sudo pacman -S --noconfirm --needed powertop cpupower

#sudo powertop --calibrate
#sudo powertop --auto-tune

sudo pacman -S --noconfirm --needed texlive

git config --global user.name "Sebastian-Francis-Taylor"
git config --global user.email "me@sebastian-taylor.com"


# Autoenv install
cd $HOME/
curl -#fLo- 'https://raw.githubusercontent.com/hyperupcall/autoenv/main/scripts/install.sh' | sh
cd $HOME/dotfiles

# Dotfiles
sudo pacman -S --noconfirm --needed stow
mkdir -p $HOME/.config
stow -d $HOME/dotfiles -t $HOME dots
cp -r $HOME/dotfiles/flags/ $HOME/.config/

# ADD IWD DTUSecure CONFIG

# Utils
sudo pacman -S --noconfirm --needed firefox nautilus udiskie thunderbird poppler brightnessctl zathura usbutils unzip pipewire pipewire-pulse iwd eog pandoc
yay -S --noconfirm --needed zen-browser-bin

# Dev 
sudo pacman -S --noconfirm --needed gcc nodejs cargo python

# Hyprland
sudo pacman -S --noconfirm --needed kitty wofi waybar wl-clipboard hyprlock hypridle hyprpaper hyprpicker hyprland
yay -S --noconfirm --needed xdg-desktop-portal-hyprland

# AUR packages
yay -S --noconfirm --needed hyprshot zotero visual-studio-code-bin google-chrome vesktop bitwarden bambustudio-bin paccache-hook

# Cloud storage
sudo pacman -S --needed --noconfirm libsecret gnome-keyring pika-backup
yay -S --needed --noconfirm filen-desktop
curl -sL https://filen.io/cli.sh | bash

# consider updated to restore from pika-backup
mkdir -p $HOME/Cloud
if filen mount $HOME/Cloud; then
    # Only copy if directories exist in cloud storage
    [ -d "$HOME/Cloud/Documents" ] && cp -r $HOME/Cloud/Documents $HOME/
    [ -d "$HOME/Cloud/Pictures" ] && cp -r $HOME/Cloud/Pictures $HOME/
    
    # Unmount when done
    fusermount -u $HOME/Cloud
else
    echo "Warning: Failed to mount cloud storage, skipping sync"
fi

# Misc
sudo pacman -S --noconfirm --needed maven obs-studio signal-desktop krita libsecret dotnet-sdk batsignal

# Time & Date
sudo timedatectl set-timezone Europe/Copenhagen
sudo localectl set-locale LANG=en_GB.UTF-8

# Enable services
systemctl --user --enable --now batsignal
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
sudo systemctl enable cups
sudo systemctl enable fstrim.timer
sudo usermod -aG wheel,audio,video,input,storage $USER
sudo systemctl start NetworkManager
systemctl --user enable --now pipewire pipewire-pulse
systemctl enable --user udiskie  

# Configure networkmanager
sudo tee /etc/NetworkManager/NetworkManager.conf <<EOF
[main]
dns=none
plugins=keyfile
[device]
wifi.powersave=2
ethernet.cloned-mac-address=random
wifi.cloned-mac-address=random
[connection]
ipv6.method=auto
[device]
wifi.backend=iwd
EOF

sudo systemctl restart NetworkManager

# Fonts install
sudo pacman -S --needed --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-ibmplex-mono-nerd
fc-cache -f -v

# Python
python -m venv $HOME/.globalenv
$HOME/.globalenv/bin/pip install -r $HOME/dotfiles/scripts/python-pkgs.txt

# Scripts
mkdir -p $HOME/.local/bin

chmod +x $HOME/dotfiles/scripts/fcd.sh
ln -s $HOME/dotfiles/scripts/fcd.sh $HOME/.local/bin/fcd

chmod +x $HOME/dotfiles/scripts/filen-automount.sh
ln -s $HOME/dotfiles/scripts/filen-automount.sh $HOME/.local/bin/filen-automount

chomod +x $HOME/dotfiles/dots/.config/monitor.sh

#zsh config with Oh My ZSH
sudo pacman -S --noconfirm --needed zsh
echo '/sbin/zsh' | sudo tee -a /etc/shells
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
