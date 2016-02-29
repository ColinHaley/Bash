#!/bin/bash

if [[$EUID -ne 0]]; then
	echo "This script must be run as root"
	exit 1
else

check_command() {
	type "$1" &> /dev/null ;
}

# Python Requirement
if check_command python ; then
	echo "Python already installed"
else
	apt-get install python
fi

# Git Requirement
if check_command git ; then
	echo "Git already installed"
else
	apt-get install git
fi

#create ansible dir
if check_command ansible ; then
	echo "Ansible already installed."
	exit 1
else
cd /
git clone git://github.com/ansible/ansible.git --recursive
cd ansisble/playbooks
source .hacking/env-setup
fi




fi
