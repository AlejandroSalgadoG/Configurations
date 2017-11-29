#!/bin/bash

echo -n "Copying gitconfig..."
cp ~/Github/Configurations/Bash/gitconfig ~/.gitconfig
echo done

echo -n "Configuring bashrc..."
cat << EOF > ~/.bashrc
source ~/Github/Configurations/Bash/bashrc
EOF
echo done

echo -n "Configuring bash_aliases..."
cat << EOF > ~/.bash_aliases
source ~/Github/Configurations/Bash/bash_aliases
EOF
echo done

echo -n "Configuring vimrc..."
cat << EOF > ~/.vimrc
so ~/Github/Configurations/Vim/vimrc
EOF
echo done

echo
echo "Configuration complete"
