#!/bin/bash -x

cd ~

# The bare essentials

sudo apt-get install android-tools-adb android-tools-fastboot htop aspell       \
      aspell-bg aspell-de aspell-en aspell-es audacity python-xdg automake      \
      awesome awesome-extra build-essential calendar-google-provider calibre    \
      chromium cmake cmake-data cryptsetup-bin cups curl dash evince            \
      firefox-esr firmware-linux-free firmware-linux-nonfree flac               \
      flashplugin-nonfree freecad gdal-bin genisoimage geoip-database gfortran  \
      gimp git gnome-disk-utility gocr gocr-tk googleearth-package gparted      \
      handbrake handbrake-cli imagemagick inkscape ipython ipython3 ispell      \
      java-common lame laptop-detect mencoder mplayer2 nco ncview netcdf-bin    \
      netcdf-doc ntfs-3g ntfs-config openssh-client openssh-server p7zip-full   \
      pavucontrol pcmanfm pdftk proj-bin proj-data pulseaudio                   \
      pulseaudio-module-x11 pulseaudio-utils pyflakes python python-cups        \
      python-cupshelpers python-flake8 python-libxml2 python-matplotlib         \
    python-numpy python-openpyxl python-openssl python-pandas python-jsonrpclib \
      python-pyparsing python-scipy python-setuptools python-simplejson         \
      python-unittest2 python3 qpdf qpdfview r-base r-cran-xml2 \
      r-cran-ncdf4 recordmydesktop ristretto   \
      rsync scrot seahorse simple-scan smplayer subversion suckless-tools       \
      synaptic tor tor-arm tor-geoipdb torsocks transmission-gtk trash-cli      \
      udevil unattended-upgrades unoconv vim-gtk wget epiphany-browser          \
      bleachbit wodim wordnet xbindkeys xclip xdg-user-dirs xdg-utils xdotool   \
      xfburn xpdf xsel xul-ext-firebug xul-ext-itsalltext xul-ext-monkeysphere  \
      xul-ext-noscript libssl-dev libgdal-dev python-gdal libmariadb-client-lgpl-dev exfat-utils


# Playonlinux!!
wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
sudo wget http://deb.playonlinux.com/playonlinux_wheezy.list -O /etc/apt/sources.list.d/playonlinux.list
sudo apt-get update
sudo apt-get install playonlinux

## Set default programs
sudo update-alternatives --config x-www-browser
sudo update-alternatives --config gnome-www-browser
sudo update-alternatives --config editor
# setxkbmap -option "compose:caps"

# sudo cat "deb http://download.virtualbox.org/virtualbox/debian jessie contrib" >> /etc/apt/sources.list
# wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install virtualbox-5.1


curl -O http://downloads.rclone.org/rclone-current-linux-amd64.zip
unzip rclone-current-linux-amd64.zip
cd rclone-*-linux-amd64
sudo cp rclone /usr/sbin/
sudo chown root:root /usr/sbin/rclone
sudo chmod 755 /usr/sbin/rclone
sudo mkdir -p /usr/local/share/man/man1
sudo cp rclone.1 /usr/local/share/man/man1/
sudo mandb

pkgs="
 https://github.com/jgm/pandoc/releases/download/1.18/pandoc-1.18-1-amd64.deb
 https://github.com/Aluxian/Whatsie/releases/download/v2.1.0/whatsie-2.1.0-linux-amd64.deb
 https://github.com/Aluxian/Facebook-Messenger-Desktop/releases/download/v1.4.3/Messenger_linux64.deb
"
for p in $pkgs; do
    wget $p
    sudo dpkg -i `basename $p`
    if [ $# -eq 0 ]; then
        sudo apt-get install -f
    fi
    mv `basename $p` /home/oney/bin/src/
done

wget https://updates.tdesktop.com/tlinux/tsetup.0.10.19.tar.xz
mv tsetup.0.10.19.tar.xz /home/oney/bin/src/
cd  /home/oney/bin/src/
tar xJf tsetup.0.10.19.tar.xz
mv Telegram/* ~/bin/src/
rmdir Telegram

wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i386linux_enu.deb
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libgtk2.0-0:i386 libxml2:i386 libstdc++6:i386
sudo dpkg -i AdbeRdr9*.deb
mv AdbeRdr9*.deb ~/bin/src/

# archwiki
wget https://www.archlinux.org/packages/community/any/arch-wiki-docs/download/ -O arch-wiki-docs.tar.xz
tar xJf arch-wiki-docs.tar.xz -C /
wget https://www.archlinux.org/packages/community/any/arch-wiki-lite/download/ -O arch-wiki-lite.tar.xz
tar xJf arch-wiki-lite.tar.xz -C /
mv arch-wiki* ~/bin/src/
sudo rm /.BUILDINFO /.MTREE /.PKGINFO

# skype
wget https://www.skype.com/de/download-skype/skype-for-linux/downloading/?type=debian32 -O skype-`date +%F`.deb
dpkg -i skype-`date +%F`.deb
agi -f
mv skype-`date +%F`.deb ~/bin/src/

# Dropbox


# For LaTeX
if [ -d /media/oney/Vault/texlive/ ];
then
    sudo cp -r /media/oney/Vault/texlive/ /usr/local/src/
else
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar xzf install-tl-unx.tar.gz
    cd install-tl*
    TEXLIVE_INSTALL_PREFIX=$HOME/texlive/
    ./install-tl -portable
fi

# Create the soft links
if [ -d /usr/local/src/texlive/ ];
then
    pwd=$PWD
    cd /usr/local/bin/
    sudo ln -sf /usr/local/src/texlive/bin/x86_64-linux/* .
    cd $pwd
fi

# May change this
sudo localectl set-x11-keymap us pc105 qwerty 'compose:102'
