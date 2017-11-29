#!/usr/bin/bash

cd
sudo yum install -y git

git clone https://github.com/AlejandroSalgadoG/Vim.git
git clone https://github.com/AlejandroSalgadoG/Bash.git

echo "source ~/Bash/bashrc" > .bashrc
echo "source ~/Bash/bash_aliases" > .bash_aliases

sed -i "8,15d" Bash/bash_aliases
sed -i "11,12d" Bash/bash_aliases
sed -i "12,13d" Bash/bash_aliases
sed -i "13,16d" Bash/bash_aliases
sed -i "15,17d" Bash/bash_aliases
sed -i "21,118d" Bash/bash_aliases
sed -i "29,68d" Bash/bash_aliases
sed -i '38,$d' Bash/bash_aliases

sed -i "s&alejandro/Github&$USER&g" Bash/bash_aliases

cp Vim/vimrc .vimrc

sed -i "s&alejandro/Github&$USER&g" .vimrc
sed -i "s&Github&&g" Vim/VimPlugin/Commands.vim
