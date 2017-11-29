#!/bin/bash

sudo apt-get -y upgrade
sudo apt-get -y update
sudo apt-get install -y vim
sudo apt-get install -y git
sudo apt-get install -y g++
sudo apt-get install -y texlive
sudo apt-get install -y openjdk-7-jre
sudo apt-get install -y xclip

cd

mkdir Github
cd Github

git clone https://github.com/AlejandroSalgadoG/Bash.git
git clone https://github.com/AlejandroSalgadoG/Zpp.git
git clone https://github.com/AlejandroSalgadoG/Vim.git
git clone https://github.com/AlejandroSalgadoG/Haskell.git
git clone https://github.com/AlejandroSalgadoG/Android.git

cd ..

sudo apt-get install -y i3
sudo apt-get install -y feh

sudo apt-get autoremove --purge -y compiz
sudo apt-get autoremove --purge -y compiz-gnome
sudo apt-get autoremove --purge -y compiz-plugins-default
sudo apt-get autoremove --purge -y libcompizconfig0
sudo apt-get autoremove --purge -y unity
sudo apt-get autoremove --purge -y unity-common
sudo apt-get autoremove --purge -y unity-services
sudo apt-get autoremove --purge -y unity-lens-*
sudo apt-get autoremove --purge -y unity-scope-*
sudo apt-get autoremove --purge -y libunity-core-6*
sudo apt-get autoremove --purge -y libunity-misc4
sudo apt-get autoremove --purge -y appmenu-gtk
sudo apt-get autoremove --purge -y appmenu-gtk3
sudo apt-get autoremove --purge -y appmenu-qt*
sudo apt-get autoremove --purge -y overlay-scrollbar*
sudo apt-get autoremove --purge -y activity-log-manager-control-center
sudo apt-get autoremove --purge -y thunderbird-globalmenu
sudo apt-get autoremove --purge -y firefox-globalmenu

echo "exec i3" >> ~/.xinitrc
sudo chown alejandro:alejandro ~/.Xauthority

cd Pictures
wget https://yt3.ggpht.com/-LTQA9tGJ9iQ/AAAAAAAAAAI/AAAAAAAAAAA/TMe7n4EKEf8/s900-c-k-no/photo.jpg
mv photo.jpg doge.jpg

cd ..

cp Github/Bash/bash_aliases .
mv bash_aliases .bash_aliases

cp Github/Bash/bashrc .
mv bashrc .bashrc

cp Github/Bash/config .i3/
sudo cp Github/Bash/i3status.conf /etc

cp Github/Vim/vimrc .
mv vimrc .vimrc
