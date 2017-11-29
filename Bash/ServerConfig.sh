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
sed -i "15d" Bash/bash_aliases    #open
sed -i "23,25d" Bash/bash_aliases #doge
sed -i "64,124d" Bash/bash_aliases #search, slurm, cs, usb
sed -i "72,111d" Bash/bash_aliases #multi

sed -i "16d" Bash/bashrc
sed -i '16iPS1="${HC}${WHI}\\T ${RED} you are in ${WHI}\\h ${RED}\\w $YEL-> $RS"' Bash/bashrc
sed -i "24d" Bash/bashrc

sed -i "s/Github\///g" Bash/bash_aliases

cp Vim/vimrc .vimrc

sed -i "s/Github\///g" .vimrc
