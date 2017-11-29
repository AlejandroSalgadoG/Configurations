#!/bin/bash

error?(){
	if [ $? != 0 ]; then 
		echo "#############################################"
		echo 
		echo "ERROR INSTALLING $@ "
		echo
		echo "#############################################"
		echo 
		exit 1
	fi
}

sudo yum install -y mlocate; error? MLOCATE							#install locaate and updatedb
sudo yum install -y vim; error? VIM								#install the best text editor available
sudo yum install -y wget; error? WGET 								#install wget
sudo yum install -y firefox; error? FIREFOX
sudo yum install -y epel-release; error? EPEL

wget https://copr.fedoraproject.org/coprs/admiralnemo/i3wm-el7/repo/epel-7/admiralnemo-i3wm-el7-epel-7.repo; error? I3 REPO
sudo mv admiralnemo-i3wm-el7-epel-7.repo /etc/yum.repos.d/; error? I3 REPO

sudo yum install -y xorg-x11-server-Xorg; error? X SERVER 					#install the x
sudo yum install -y xorg-x11-drv-vmware; error? X VMWARE					#the x vmware video driver
sudo yum install -y xorg-x11-drv-vmmouse; error? X VMMOUSE					#the x vmmouse input driver 
sudo yum install -y xorg-x11-drv-evdev; error? X EVDEV						#the x evdev input driver
sudo yum install -y xorg-x11-drv-intel; error? X INTEL DRIVER					# the x intel driver
sudo yum install -y xorg-x11-xinit-session; error? X SESSION 					#allows to use .xsession and .Xclients

sudo yum install -y mesa-dri-drivers; error? DRI DRIVERS					#the mesa DRI drivers

sudo yum install -y lightdm; error? LIGHTDM							#install the lightdm service

sudo yum install -y i3; error? i3								#install the i3 window manager
sudo yum install -y i3status; error? I3STATUS							#install the i3 status bar

echo "exec i3" > ~/.xinitrc

startx 
