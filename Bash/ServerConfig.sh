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

sed -i "10,12d" Bash/bash_aliases
sed -i "14d" Bash/bash_aliases
sed -i "15,21d" Bash/bash_aliases
sed -i "19,21d" Bash/bash_aliases
sed -i "21,24d" Bash/bash_aliases
sed -i "21,54d" Bash/bash_aliases
sed -i "26,44d" Bash/bash_aliases
sed -i "26,49d" Bash/bash_aliases
sed -i "34,73d" Bash/bash_aliases

sed -i "s&alejandro/Github&$USER&g" Bash/bash_aliases

cp Vim/vimrc .vimrc

sed -i "s&alejandro/Github&$USER&g" .vimrc
sed -i "s&Github&&g" Vim/VimPlugin/Main.vim
