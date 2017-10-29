#!/bin/bash -x

cd ~

# The bare essentials

sudo pacman -S --noconfirm android-tools aspell aspell-de aspell-en aspell-es \
          audacity automake calibre chromium cmake cryptsetup cups curl dash  \
          evince firefox flac freecad geoip-database gcc-fortran gimp git     \
          gnome-disk-utility gparted handbrake handbrake-cli imagemagick      \
          inkscape ispell lame laptop-detect mencoder mplayer ntfs-3g openssh \
          p7zip pavucontrol pcmanfm pdftk-bin pulseaudio qpdf qpdfview r      \
          recordmydesktop ristretto rsync scrot seahorse simple-scan smplayer \
          subversion tor transmission-gtk trash-cli udevil unoconv gvim wget  \
          epiphany bleachbit xbindkeys xclip xdg-user-dirs xdg-utils xdotool  \
          xfburn xpdf xsel exfat-utils xclip python-xdg rclone nodejs         \
          linux49-virtualbox-host-modules virtualbox-guest-iso pandoc         \
          youtube-dl emacs gdal

yaourt -S --noconfirm arch-wiki-man pdftk-bin franz-bin dropbox zotero 

# python packages 

yaourt -S --noconfirm python-xdg ipython ipython2 python-pyflakes python2-pycups  \
          flake8 python2-lxml python-lxml python2-matplotlib python2-numpy        \
          python2-openpyxl python2-pandas python2-jsonrpclib python2-pyparsing    \
          python2-scipy python2-simplejson python2-unittest2 python-gdal

## Set default programs
sudo update-alternatives --config x-www-browser
# sudo update-alternatives --config gnome-www-browser
sudo update-alternatives --config editor
# setxkbmap -option "compose:caps"

mkdir -p documents
git clone https://github.com/oneyb/config.git documents/config
bash documents/config/.copy-config.sh in

# archwiki
wget https://www.archlinux.org/packages/community/any/arch-wiki-docs/download/ -O arch-wiki-docs.tar.xz
sudo tar xJf arch-wiki-docs.tar.xz -C /
wget https://www.archlinux.org/packages/community/any/arch-wiki-lite/download/ -O arch-wiki-lite.tar.xz
sudo tar xJf arch-wiki-lite.tar.xz -C /
mv arch-wiki* ~/bin/src/
sudo rm /.BUILDINFO /.MTREE /.PKGINFO


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
add_desktop_launcher epiphany                   $HOME/.config/icons/web-browser.png
add_desktop_launcher chromium                   $HOME/.config/icons/chromium.png
add_desktop_launcher $HOME/bin/sync_org.sh      $HOME/.config/icons/orgzly.png
add_desktop_launcher "emacsclient -c --eval '(switch-to-buffer \"*spacemacs*\")'" $HOME/.config/icons/emacs22.png
# add_desktop_launcher VirtualBox                 $HOME/.config/icons/virtualbox.png
add_desktop_launcher $HOME/bin/zotero           $HOME/.config/icons/zotero.png 
Terminal="true"
add_desktop_launcher $HOME/bin/.backup_file.sh  $HOME/.config/icons/text-x-script.png
add_desktop_launcher $HOME/bin/.sync_phone.sh   $HOME/.config/icons/stock_cell-phone.png

# PDF-tools awesomeness
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

[Install]
WantedBy=default.target" > ~/.config/systemd/user/emacs.timer
systemctl --user enable emacs.timer
systemctl --user start emacs.timer

# anamnesis
echo -e  "[Unit]
Description=Anamnesis is a clipboard manager. It stores all clipboard history and offers an easy interface to do a full-text search on the items of its history.

[Service]
Type=forking
ExecStart=/usr/bin/anamnesis --restart --clean
ExecStop=/usr/bin/anamnesis --stop
Restart=always
TimeoutStartSec=0
RestartSec=10800

# [Install]
# WantedBy=default.target" > ~/.config/systemd/user/anamnesis.service
echo "[Unit]
Description=Delay start of anamnesis

[Timer]
OnBootSec=19s
OnUnitActiveSec=10h
# Unit=anamnesis.service

[Install]
WantedBy=default.target" > ~/.config/systemd/user/anamnesis.timer
systemctl --user start anamnesis.timer
systemctl --user enable anamnesis.timer

echo "
[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=xbindkeys
Comment=Start xbindkeys service.
Exec=xbindkeys
OnlyShowIn=XFCE;
StartupNotify=false
Terminal=false
Hidden=false
" > ~/.config/autostart/xbindkeys.desktop

# For LaTeX
if [ -d /run/media/oney/stuff/texlive/ ];
then
    sudo cp -a /run/media/oney/stuff/texlive/ /usr/local/src/
else
    wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    tar xzf install-tl-unx.tar.gz
    cd install-tl*
    TEXLIVE_INSTALL_PREFIX=$HOME/texlive/
    ./install-tl -portable
fi
echo -e "if [ -d /usr/local/src/texlive/ ]; then\n\tPATH=\"/usr/local/src/texlive/bin/$(uname -m)-$(uname -s | sed "s/.*/\L&/"):\$PATH\"\nfi"


# May change this
echo "Wanna? sudo localectl set-x11-keymap us pc105 qwerty 'compose:102'"
echo "Wanna? sudo localectl set-x11-keymap us pc105 qwerty 'compose:prsc,caps:escape'"
