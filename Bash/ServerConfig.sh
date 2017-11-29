#!/bin/bash

cd

if grep -iq centos /etc/*-release; then
    sudo yum install -y git
else
    sudo apt-get install -y git
fi

git clone https://github.com/AlejandroSalgadoG/Vim.git
git clone https://github.com/AlejandroSalgadoG/Bash.git

echo "source ~/Bash/bashrc" > .bashrc
echo "source ~/Bash/bash_aliases" > .bash_aliases

sed -i "10,12d" Bash/bash_aliases #i3 aliases
sed -i "14d" Bash/bash_aliases    #open
sed -i "15,21d" Bash/bash_aliases #deb, msg, rf, rm -i, moo, put bin
sed -i "23,25d" Bash/bash_aliases #doge
sed -i "26,86d" Bash/bash_aliases #search, slurm, cs, usb
sed -i "33,72d" Bash/bash_aliases #multi

sed -i "7d" Bash/bashrc
sed -i '7iFRED="\\[\\033[31m\\]" # foreground red' Bash/bashrc
sed -i "10d" Bash/bashrc
sed -i '10iPS1="${FWHI}\\T ${HC}${FRED}you are in ${FWHI}\\h ${FRED}on \\w $FYEL-> $RS"' Bash/bashrc
sed -i "23d" Bash/bashrc

sed -i "s/Github\///g" Bash/bash_aliases

cp Vim/vimrc .vimrc

sed -i "s/Github\///g" .vimrc
