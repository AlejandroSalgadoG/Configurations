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

sed -i "s/Github\///g" Bash/bash_aliases

cp Vim/vimrc .vimrc

sed -i "s/Github\///g" .vimrc
