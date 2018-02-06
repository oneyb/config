#!/bin/bash -x

cd ~


sudo apt-get install android-tools-adb android-tools-fastboot htop aspell       \
      aspell-bg aspell-de aspell-en aspell-es audacity automake awesome         \
      awesome-extra build-essential calendar-google-provider calibre chromium   \
      cmake cmake-data cryptsetup-bin cups curl dash evince firefox-esr         \
      firmware-linux-free firmware-linux-nonfree flac freecad gdal-bin          \
      genisoimage geoip-database gfortran gimp git gnome-disk-utility gocr      \
      gocr-tk googleearth-package gparted handbrake handbrake-cli imagemagick   \
      inkscape ispell java-common lame laptop-detect mplayer2 nco ncview        \
      netcdf-bin netcdf-doc ntfs-3g ntfs-config openssh-client openssh-server   \
      p7zip-full pavucontrol pcmanfm pdftk proj-bin proj-data pulseaudio        \
      pulseaudio-utils qpdf qpdfview r-base r-cran-xml2 r-cran-ncdf4            \
      recordmydesktop ristretto rsync scrot seahorse simple-scan smplayer       \
      subversion suckless-tools synaptic tor tor-arm autoconf automake g++ gcc  \
      libpng-dev libpoppler-dev libpoppler-glib-dev libpoppler-private-dev      \
      libz-dev make pkg-config tor-geoipdb torshplipocks transmission-gtk trash-cli  \
      udevil unattended-upgrades unoconv vim-gtk wget epiphany-browser          \
      bleachbit wodim wordnet xbindkeys xclip xdg-user-dirs xdg-utils xdotool   \
      xfburn xpdf xsel xul-ext-firebug xul-ext-itsalltext xul-ext-monkeysphere  \
      xul-ext-noscript libssl-dev libgdal-dev libmariadb-client-lgpl-dev        \
      exfat-utils libxft-dev libfreetype6-dev rclone evolution                  \
      breeze-cursor-theme bash-completion lshw libimage-exiftool-perl           \
      broadcom-sta-dkms picard hplip dialog mupdf mupdf-tools socat


# python packages
sudo apt-get install python-xdg ipython ipython3 pyflakes python python-cups  \
      python3-cupshelpers python-flake8 python-libxml2                        \
      python-numpy python-openpyxl python-openssl                             \
      python-jsonrpclib python-pyparsing python-scipy python-setuptools       \
      python-simplejson python-unittest2 python3 python-gdal python-pdfminer  \
      pdfminer-data python-pip python3-pip jupyter-notebook 

sudo pip3 install -U grasp pandas xlrd xlrt openpyxl beautifulsoup4 html5lib reportlab

echo "c.InteractiveShellApp.extensions = ['grasp']" >> ~/.ipython/profile_default/ipython_config.py 

# Remove stuff
sudo apt-get remove thunderbird

function add_desktop {
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
}


# Zotero on debian 9
wget -O $HOME/bin/src/Zotero_linux-x86_64.tar.bz2 'https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=5.0.24'
cd  ~/bin/src/
tar xjf Zotero_linux-x86_64.tar.bz2
cd Zotero_linux-x86_64/
./set_launcher_icon
sed -ri "s_^Exec=.*_Exec=$PWD/zotero -url %U_" zotero.desktop
desktop-file-install zotero.desktop --dir=~/.local/share/applications/

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
    https://github.com/jgm/pandoc/releases/download/2.0.1/pandoc-2.0.1-1-amd64.deb
)

function install_manual_deb ()
{
        wget $1
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

# Messenger services with Franz
cd $HOME/bin/src/
[[ ! -f Franz-linux-x64-4.0.4.tgz ]] && wget https://github.com/meetfranz/franz-app/releases/download/4.0.4/Franz-linux-x64-4.0.4.tgz
sudo mkdir /opt/franz
sudo tar xzf Franz-linux*.tgz -C /opt/franz
sudo ln -s /opt/franz/Franz /usr/bin/franz
sudo wget https://cdn-images-1.medium.com/max/360/1*v86tTomtFZIdqzMNpvwIZw.png -O /usr/share/icons/franz.png
sudo bash -c "echo -e \"[Desktop Entry]\nEncoding=UTF-8\nName=Franz\nComment=A free messaging app for WhatsApp, Facebook Messenger, Telegram, Slack and more.\nExec=franz -- %u\nStartupWMClass=Franz franz\nTerminal=false\nType=Application\nCategories=Network;\" > /usr/share/applications/franz.desktop"
cd -

wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libgtk2.0-0:i386 libxml2:i386 libstdc++6:i386
sudo dpkg -i AdbeRdr9*.deb
mv AdbeRdr9*.deb ~/bin/src/

# archwiki
wget https://www.archlinux.org/packages/community/any/arch-wiki-docs/download/ -O arch-wiki-docs.tar.xz
sudo tar xJf arch-wiki-docs.tar.xz -C /
wget https://www.archlinux.org/packages/community/any/arch-wiki-lite/download/ -O arch-wiki-lite.tar.xz
sudo tar xJf arch-wiki-lite.tar.xz -C /
mv arch-wiki* ~/bin/src/
sudo rm /.BUILDINFO /.MTREE /.PKGINFO

# easy org export
git clone https://github.com/nhoffman/org-export ~/bin/src/org-export
ln -s ~/bin/src/org-export/{org-export,*.el} ~/bin/.

# NodeJS
if [ -n $(grep nodesource /etc/apt/sources.list) ]; then
    curl --silent https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
else
    curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
    sudo apt-get install -y nodejs
fi

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

add_desktop_launcher $HOME/bin/tb               $HOME/.config/icons/evolution-mail.png
add_desktop_launcher $HOME/bin/franz.sh         $HOME/.config/icons/franz.png
add_desktop_launcher $HOME/bin/signal           $HOME/.config/icons/signal.png
add_desktop_launcher pcmanfm                    $HOME/.config/icons/file-manager.png
add_desktop_launcher firefox                    $HOME/.config/icons/firefox.png
add_desktop_launcher epiphany-browser           $HOME/.config/icons/web-browser.png
add_desktop_launcher chromium                   $HOME/.config/icons/chromium.png
add_desktop_launcher $HOME/bin/sync_org.sh      $HOME/.config/icons/orgzly.png
add_desktop_launcher "emacsclient -c --eval '(switch-to-buffer \"*spacemacs*\")'" $HOME/.config/icons/emacs22.png
# add_desktop_launcher VirtualBox                 $HOME/.config/icons/virtualbox.png
# add_desktop_launcher $HOME/bin/zotero           $HOME/.config/icons/zotero.png 
Terminal="true"
add_desktop_launcher $HOME/bin/.backup_file.sh  $HOME/.config/icons/text-x-script.png
add_desktop_launcher $HOME/bin/.sync_phone.sh   $HOME/.config/icons/stock_cell-phone.png

# configuration
git clone git@github.com:oneyb/qpdfview-shortcuts-config.git ~/.config/qpdfview

# # PDF-tools awesomeness
# sudo aptitude install libpng-dev libz-dev libpoppler-glib-dev  \
#      libpoppler-private-dev
# git clone https://github.com/politza/pdf-tools
# cd pdf-tools
# # make install-server-deps # optional
# make -s
# if [ -f pdf-tools-*.tar ]; then
#    sudo make install-package
# fi
# make clean
# cd ..
# mv pdf-tools ~/bin/src/
echo "much easier to install pdf-tools layer and then:"
emacsclient -e "(pdf-tools-install)"

# Nice grub screen hiding
wget https://raw.githubusercontent.com/hobarrera/grub-holdshift/master/31_hold_shift -O /etc/grub.d/31_hold_shift
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

# anamnesis
echo -e  "[Unit]
Description=Anamnesis is a clipboard manager. It stores all clipboard history and offers an easy interface to do a full-text search on the items of its history.

[Service]
Type=forking
ExecStart=%h/bin/anamnesis --start
ExecStop=%h/bin/anamnesis --stop --clean
Restart=always
TimeoutStartSec=0
RestartSec=10800
EnvironmentFile=%h/.profile

[Install]
WantedBy=default.target" > ~/.config/systemd/user/anamnesis.service

echo "[Unit]
Description=Delay start of anamnesis

[Timer]
OnBootSec=39s
OnUnitActiveSec=10h
# Unit=anamnesis.service

[Install]
WantedBy=default.target" > ~/.config/systemd/user/anamnesis.timer
systemctl --user start anamnesis.timer
systemctl --user enable anamnesis.timer

echo -e  "[Unit]
Description=Awesomeness with xbindkeys

[Service]
Type=forking
ExecStart=/usr/bin/xbindkeys
ExecRestart=/usr/bin/killall -HUP xbindkeys
ExecStop=/usr/bin/killall -w xbindkeys
Restart=always
TimeoutStartSec=0
RestartSec=10800

[Install]
WantedBy=default.target" > ~/.config/systemd/user/xbindkeys.service
systemctl --user start xbindkeys 
systemctl --user enable xbindkeys

# # skype
# wget https://www.skype.com/de/download-skype/skype-for-linux/downloading/?type=debian32 -O skype-`date +%F`.deb
# dpkg -i skype-`date +%F`.deb
# agi -f/etc/defaults/grub
# mv skype-`date +%F`.deb ~/bin/src/


# For LaTeX
if [ -d /media/oney/stuff/texlive/ ];
then
    sudo cp -a /media/oney/stuff/texlive/ /usr/local/src/
else
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar xzf install-tl-unx.tar.gz
    cd install-tl*
    TEXLIVE_INSTALL_PREFIX=$HOME/texlive/
    ./install-tl -portable
fi
echo -e "if [ -d /usr/local/src/texlive/ ]; then\n\tPATH=\"/usr/local/src/texlive/bin/$(uname -m)-$(uname -s | sed "s/.*/\L&/"):\$PATH\"\nfi"

# systemd-stuff
sudo systemctl disable tor
sudo systemctl stop tor

# Terminal pimpinghttps://github.com/afg984/base16-xfce4-terminal.git
git clone https://github.com/afg984/base16-xfce4-terminal.git ~/.config/base16-xfce4-terminal
[[ ! -d  ~/.local/share/xfce4/terminal/colorschemes/ ]] && mkdir -p ~/.local/share/xfce4/terminal/colorschemes/ 
rsync -vurt --delete ~/.config/base16-xfce4-terminal/colorschemes/ ~/.local/share/xfce4/terminal/colorschemes/
# Choose 'Nord'

git clone https://github.com/google/adb-sync ~/bin/src/adb-sync/
ln -sf ~/bin/src/adb-sync/adb-* ~/bin/.


# May change this
echo "Wanna? sudo localectl set-x11-keymap us pc105 qwerty 'compose:102'"
echo "Wanna? sudo localectl set-x11-keymap us pc105 qwerty 'compose:prsc,caps:escape'"
