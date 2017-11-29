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

sed -i "6,13d" Bash/bash_aliases
sed -i "9,10d" Bash/bash_aliases
sed -i "10,11d" Bash/bash_aliases
sed -i "11,14d" Bash/bash_aliases
sed -i "15,17d" Bash/bash_aliases #end of aliases
sed -i "17,50d" Bash/bash_aliases
sed -i "21,118d" Bash/bash_aliases
sed -i "29,68d" Bash/bash_aliases
sed -i '38,$d' Bash/bash_aliases

sed -i "s&alejandro/Github&$USER&g" Bash/bash_aliases

cp Vim/vimrc .vimrc

sed -i "s&alejandro/Github&$USER&g" .vimrc
sed -i "s&Github&&g" Vim/VimPlugin/Commands.vim
