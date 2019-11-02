#!/bin/bash -x

cd ~

sudo apt-get update

# ansible-playbook -i tinkbox.local, -u oney ~/bin/.setup_linux.yaml --ask-become-pass

$? == 0 && cppman -c

# sudo loginctl enable-linger $USER

echo "c.InteractiveShellApp.extensions = ['grasp']" >> ~/.ipython/profile_default/ipython_config.py 

# Remove stuff
sudo apt-get remove thunderbird

# Zotero on debian 10
wget https://raw.github.com/oneyb/zotero_installer/master/zotero_installer.sh -O /tmp/zotero_installer.sh
chmod +x /tmp/zotero_installer.sh
sudo /tmp/zotero_installer.sh

# flutter
# wget https://storage.googleapis.com/flutter_infra/releases/beta/linux/flutter_linux_v0.5.1-beta.tar.xz
# sudo tar xJf flutter_linux_v0.5.1-beta.tar.xz -C ~/Android/

# android studio
# sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
# sudo unzip -d /opt/ android-studio-ide-173.4907809-linux.zip
# sudo apt-get install qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils ia32-libs-multiarch
# Playonlinux!!
# wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
# sudo wget http://deb.playonlinux.com/playonlinux_wheezy.list -O /etc/apt/sources.list.d/playonlinux.list
# sudo apt-get update
# sudo apt-get install playonlinux

## Set default programs
sudo update-alternatives --config x-www-browser
# sudo update-alternatives --config gnome-www-browser
sudo update-alternatives --config editor
# setxkbmap -option "compose:caps"

# echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" | sudo tee -a /etc/apt/sources.list
# wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install virtualbox-5.2

mkdir -p documents
git clone git@github.com:oneyb/config.git
bash documents/config/.copy-config.sh in

# curl -O http://downloads.rclone.org/rclone-current-linux-amd64.zip
# unzip rclone-current-linux-amd64.zip
# cd rclone-*-linux-amd64
# sudo cp rclone /usr/sbin/
# sudo chown root:root /usr/sbin/rclone
# sudo chmod 755 /usr/sbin/rclone
# sudo mkdir -p /usr/local/share/man/man1
# sudo cp rclone.1 /usr/local/share/man/man1/
# sudo mandb

pkgs=(
	https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-1-amd64.deb
)

function install_manual_deb ()
{
        [ ! -f $(basename $1) ] && wget $1
        sudo dpkg -i `basename $1`
        if [ $# -eq 0 ]; then
            sudo apt-get install -f
        fi
        mv `basename $1` $HOME/bin/src/
}

for p in ${pkgs[@]}; do
    install_manual_deb $p
done

# anamnesis
cd ~/bin/src/
wget -O anamnesis.tar.gz  https://sourceforge.net/projects/anamnesis/files/latest/download
tar xzf anamnesis.tar.gz
ln -sf ~/bin/src/anamnesis-1.0.4/source/anamnesis.py ~/bin/anamnesis

curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop

# Messenger services with Hamsket
function install-hamsket ()
{
    cd $HOME/bin/src/
    rm Hamsket-latest-x64.tar.gz
    # download=https://github.com/TheGoddessInari/hamsket/releases/download/nightly/Rambox_0.5.18_amd64.deb
    download=https://github.com/TheGoddessInari/hamsket/releases/download/nightly/hamsket_0.6.0_amd64.deb
    [[ ! -f Hamsket-latest-x64.deb ]] && wget $download -O Hamsket-latest-x64.deb
    sudo dpkg -i Hamsket-latest-x64.deb
    [[ ! -f /usr/share/icons/hamsket.png ]] && sudo wget https://github.com/TheGoddessInari/hamsket/raw/master/resources/Icon.png -O /usr/share/icons/hamsket.png
    sudo bash -c "echo -e \"[Desktop Entry]\nEncoding=UTF-8\nName=Hamsket\nComment=Free, Open Source and Cross Platform messaging and emailing app that combines common web applications into one.\nExec=hamsket -- %u\nStartupWMClass=Hamsket hamsket\nTerminal=false\nType=Application\nCategories=Network;\" > /usr/share/applications/hamsket.desktop"
    sudo desktop-file-install /usr/share/applications/hamsket.desktop
    cd -
}
install-hamsket


# archwiki
wget https://www.archlinux.org/packages/community/any/arch-wiki-docs/download/ -O arch-wiki-docs.tar.xz
sudo tar xJf arch-wiki-docs.tar.xz -C /
wget https://www.archlinux.org/packages/community/any/arch-wiki-lite/download/ -O arch-wiki-lite.tar.xz
sudo tar xJf arch-wiki-lite.tar.xz -C /
mv arch-wiki* ~/bin/src/
sudo rm /.BUILDINFO /.MTREE /.PKGINFO

# easy org export
# git clone https://github.com/nhoffman/org-export ~/bin/src/org-export
# ln -s ~/bin/src/org-export/{org-export,*.el} ~/bin/.

# # NodeJS
# if [ -n $(grep nodesource /etc/apt/sources.list) ]; then
#     curl --silent https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
# else
#     curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
#     sudo apt-get install -y nodejs
# fi

# spacemacs!!!
if [ -d ~/.emacs.d ]; then \rm -rf ~/.emacs.d/; fi
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
bash -c "emacs" &

# # i3-py and quickswitch
# sudo pip3 install i3-py
# sudo pip3 install git+https://github.com/OliverUv/quickswitch-for-i3.git
# git clone https://github.com/westurner/i3t.git ~/.config/i3/i3t

# xfce-panel pimping

Terminal="false"
function add_desktop_launcher {
    echo "[Desktop Entry]
Version=1.0
Type=Application
Name=$(basename $1)
Comment=
Exec=$1
Icon=$2
Path=
Terminal=$Terminal
StartupNotify=false" > ~/.config/xfce4/desktop/$(basename $1).desktop
    xfce4-panel --add=launcher ~/.config/xfce4/desktop/$(basename $1).desktop
}

add_desktop_launcher brave-browser              /usr/share/icons/hicolor/16x16/apps/brave-browser.png
add_desktop_launcher $HOME/bin/tb               $HOME/.config/icons/evolution-mail.png
add_desktop_launcher signal-desktop             $HOME/.config/icons/signal.png
add_desktop_launcher pcmanfm                    $HOME/.config/icons/file-manager.png
add_desktop_launcher epiphany-browser           $HOME/.config/icons/web-browser.png
# add_desktop_launcher chromium                   $HOME/.config/icons/chromium.png
add_desktop_launcher chromium-browser           $HOME/.config/icons/chromium.png
add_desktop_launcher $HOME/bin/hamsket.sh        /usr/share/icons/hamsket.png 
add_desktop_launcher $HOME/bin/sync_org.sh      $HOME/.config/icons/orgzly.png
# add_desktop_launcher "emacsclient -c --eval '(org-capture)'" $HOME/.config/icons/emacs22.png
# add_desktop_launcher "emacsclient -c --eval '(switch-to-buffer \"*spacemacs*\")'" $HOME/.config/icons/emacs22.png
# add_desktop_launcher VirtualBox                 $HOME/.config/icons/virtualbox.png
# add_desktop_launcher $HOME/bin/zotero           $HOME/.config/icons/zotero.png 
# Terminal="true"
# add_desktop_launcher $HOME/bin/.backup_file.sh  $HOME/.config/icons/text-x-script.png
# add_desktop_launcher $HOME/bin/.sync_phone.sh   $HOME/.config/icons/stock_cell-phone.png

xdg-settings set default-web-browser chromium.desktop

# Nice grub screen hiding
# https://wiki.archlinux.org/index.php/GRUB/Tips_and_tricks#Hide_GRUB_unless_the_Shift_key_is_held_down
sudo wget https://raw.githubusercontent.com/oneyb/config/master/31_hold_shift -O /etc/grub.d/31_hold_shift
sudo bash -c 'echo -e "GRUB_TIMEOUT=\"0\"\nGRUB_HIDDEN_TIMEOUT=\"0\"\nGRUB_FORCE_HIDDEN_MENU=\"true\"" >> /etc/default/grub'
sudo grub-mkconfig -o /boot/grub/grub.cfg

# emacs as service: from http://blog.refu.co/?p=1296
mkdir -p ~/.config/systemd/user/
# Emacs for faster startup
echo -e  "[Unit]
Description=Emacs: the extensible, self-documenting text editor

[Service]
Type=forking
ExecStart=/usr/bin/emacs --daemon
ExecStop=/usr/bin/emacsclient --eval \"(progn (save-buffers-kill-emacs))\"
Restart=always
# Remove the limit in startup timeout, since emacs
# cloning and building all packages can take time
TimeoutStartSec=0

# [Install]
# WantedBy=multi-user.target" > ~/.config/systemd/user/emacs.service
echo "[Unit]
Description=Delay emacs startup

[Timer]
OnBootSec=26s
# Unit=emacs.service

# [Install]
# WantedBy=default.target" > ~/.config/systemd/user/emacs.timer
systemctl --user enable emacs.timer
systemctl --user start emacs.timer


# set up atom-chrome https://github.com/alpha22jp/atomic-chrome

# # Set up automatic phone sync
# echo -e  '
# # ACTION=="add",ATTRS{idVendor}=="04e8", ATTRS{idProduct}=="6860",MODE="660", GROUP="plugdev",RUN+="/bin/su oney -c /home/oney/bin/.sync_phone.sh | at now"
# # ACTION=="add",ATTRS{idVendor}=="04e8", ATTRS{idProduct}=="6860",TAG+="systemd",ENV{SYSTEMD_WANTS}="sync-phone.service" 
# ACTION=="add",ATTRS{idVendor}=="04e8", ATTRS{idProduct}=="6860",TAG+="systemd",ENV{SYSTEMD_USER_WANTS}="sync-phone.service" 
# ' | sudo tee -a /etc/udev/rules.d/phone-plugin.rule

# echo -e  "
# [Unit]
# Description=Automatically sync phone with udev and systemd

# [Service]
# WorkingDirectory=%h
# Type=oneshot
# ExecStart=%h/bin/.sync_phone.sh
# StandardOutput=journal

# [Install]
# WantedBy=multi-user.target
# " > ~/.config/systemd/user/sync-phone.service
# systemctl --user enable sync-phone.service


# anamnesis
# echo -e  "[Unit]
# Description=Anamnesis is a clipboard manager. It stores all clipboard history and offers an easy interface to do a full-text search on the items of its history.

# [Service]
# Type=forking
# ExecStart=%h/bin/anamnesis --start
# ExecStop=%h/bin/anamnesis --stop --clean
# Restart=always
# TimeoutStartSec=0
# RestartSec=10800
# EnvironmentFile=%h/.profile

# [Install]
# WantedBy=default.target" > ~/.config/systemd/user/anamnesis.service

# echo "[Unit]
# Description=Delay start of anamnesis

# [Timer]
# OnBootSec=39s
# OnUnitActiveSec=10h
# # Unit=anamnesis.service

# [Install]
# WantedBy=default.target" > ~/.config/systemd/user/anamnesis.timer
# systemctl --user start anamnesis.timer
# systemctl --user enable anamnesis.timer

# echo -e  "[Unit]
# Description=Awesomeness with xbindkeys

# [Service]
# Type=forking
# ExecStart=/usr/bin/xbindkeys
# ExecRestart=/usr/bin/killall -HUP xbindkeys
# ExecStop=/usr/bin/killall -w xbindkeys
# Restart=always
# TimeoutStartSec=0
# RestartSec=10800

# [Install]
# WantedBy=default.target" > ~/.config/systemd/user/xbindkeys.service
# systemctl --user start xbindkeys 
# systemctl --user enable xbindkeys

# # skype
# wget https://www.skype.com/de/download-skype/skype-for-linux/downloading/?type=debian32 -O skype-`date +%F`.deb
# dpkg -i skype-`date +%F`.deb
# agi -f/etc/defaults/grub
# mv skype-`date +%F`.deb ~/bin/src/

systemctl --user enable syncthing.service

# For LaTeX
if [ -d /media/oney/stuff/texlive/ ];
then
    sudo cp -r --preserve=timestamps,mode /media/oney/stuff/texlive/ /usr/local/src/
	  # sudo find /usr/local/src/texlive/ -type f -print0 | xargs -0 chmod 655
	  # sudo find /usr/local/src/texlive/ -type d -print0 | xargs -0 chmod 755

else
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar xzf install-tl-unx.tar.gz
    cd install-tl*
    TEXLIVE_INSTALL_PREFIX=$HOME/texlive/
    ./install-tl -portable
fi
echo -e "if [ -d /usr/local/src/texlive/ ]; then\n\tPATH=\"/usr/local/src/texlive/bin/$(uname -m)-$(uname -s | sed "s/.*/\L&/"):\$PATH\"\nfi"

# # systemd-stuff
# sudo systemctl disable tor
# sudo systemctl stop tor

# wget https://raw.githubusercontent.com/raspberrypi-ui/piclone/master/src/backup 
# bash backup /dev/sda
# sudo dbus-launch piclone
# wget http://www.iozone.org/src/current/iozone3_434.tar
# cat iozone3_434.tar | tar -x
# cd iozone3_434/src/current
# make linux-arm
# ~/iozone3_434/src/current/iozone -e -I -a -s 100M -r 4k -i 0 -i 1 -i 2 -f test.txt

sudo apt-get update
sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'

sudo apt-get update
sudo apt-get install dart

# # Terminal pimping https://github.com/afg984/base16-xfce4-terminal.git
# git clone https://github.com/afg984/base16-xfce4-terminal.git ~/.config/base16-xfce4-terminal
# [[ ! -d  ~/.local/share/xfce4/terminal/colorschemes/ ]] && mkdir -p ~/.local/share/xfce4/terminal/colorschemes/ 
# rsync -vurt --delete ~/.config/base16-xfce4-terminal/colorschemes/ ~/.local/share/xfce4/terminal/colorschemes/
# # Choose 'Nord'

sudo add-apt-repository ppa:yubico/stable && sudo apt-get update

# May change this
# echo Permanently: localectl set-x11-keymap us pc104 '' 'compose:102'
echo Permanently: localectl set-x11-keymap us pc104 '' 'compose:prsc,caps:escape'
echo Temporarily: setxkbmap -model pc104 -layout us -option -option 'compose:prsc,caps:escape'


# get scripts from http://www.fmwconcepts.com/imagemagick/index.php
echo "want picture processing scripts? try: \n\tbash ~/bin/download_fmwconcepts.py"

gsettings set org.mate.mate-menu hot-key ''
gsettings set com.solus-project.brisk-menu hot-key ''
gsettings set org.mate.Marco.window-keybindings activate-window-menu ''
gsettings set org.mate.background show-desktop-icons false
