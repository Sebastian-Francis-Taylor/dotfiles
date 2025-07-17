#!/bin/bash

sudo pacman -Syu

sudo pacman -S --noconfirm --needed git 

# Install yay
sudo pacman -S --noconfirm --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Core (change to intel-ucode if there is an intel chip in the system)
sudo pacman -S --noconfirm --needed amd-ucode
# Wifi, bluetooth etc
sudo pacman -S --noconfirm --needed bluez bluez-utils cups
# CLI Tools
sudo pacman -S --noconfirm --needed nvim fzf tree-sitter tree-sitter-cli ripgrep tmux btop tree fastfetch networkmanager networkmanager-applet tldr

sudo pacman -S --noconfirm --needed powertop

#sudo powertop --calibrate
#sudo powertop --auto-tune

sudo pacman -S --noconfirm --needed texlive

git config --global user.name "Raaaainbow"
git config --global user.email "seba7204@gmail.com"


# Autoenv install
cd ~/
curl -#fLo- 'https://raw.githubusercontent.com/hyperupcall/autoenv/main/scripts/install.sh' | sh
cd ~/dotfiles

# Dotfiles
sudo pacman -S --noconfirm --needed stow
mkdir -p ~/.config
cd ~/dotfiles/dots
stow -t ~ * --adopt
cp -r ~/dotfiles/flags/ $HOME/.config/

# ADD IWD DTUSecure CONFIG

# Utils
sudo pacman -S --noconfirm --needed firefox nautilus udiskie thunderbird poppler brightnessctl zathura usbutils unzip pipewire pipewire-pulse iwd

# Dev 
sudo pacman -S --noconfirm --needed gcc nodejs cargo python

# Hyprland
sudo pacman -S --noconfirm --needed kitty wofi waybar wl-clipboard hyprlock hypridle hyprpaper hyprpicker hyprland
yay -S --noconfirm --needed xdg-desktop-portal-hyprland

# AUR packages
yay -S --noconfirm --needed hyprshot zotero visual-studio-code-bin google-chrome vesktop bitwarden bambu-studio paccache-hook

# Cloud storage
sudo pacman -S libsecret gnome-keyring
yay -S filen-desktop
curl -sL https://filen.io/cli.sh | bash

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
sudo systemctl enable pipewire
sudo systemctl enable pipewire-pulse
sudo systemctl enable bluetooth
sudo systemctl enable cups
sudo systemctl --user enable udiskie
sudo systemctl enable fstrim.timer
sudo usermod -aG wheel,audio,video,input,storage $USER
sudo systemctl start NetworkManager

# Configure networkmanager
sudo tee /etc/NetworkManager/NetworkManager.conf <<EOF
[main]
dns=none
[device]
wifi.powersave=2
ethernet.cloned-mac-address=random
wifi.cloned-mac-address=random
[connection]
ipv6.method=auto
EOF

sudo systemctl restart NetworkManager

# Fonts install
sudo pacman -S --needed --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-ibmplex-mono-nerd
fc-cache -f -v

# Python
python -m venv ~/.globalenv
source ~/.globalenv/bin/activate
pip install -r ~/dotfiles/scripts/python-pkgs.txt

#zsh config with Oh My ZSH
sudo pacman -S --noconfirm --needed zsh
echo '/sbin/zsh' | sudo tee -a /etc/shells
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
