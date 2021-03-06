#!/bin/bash

set -e
alias echo='echo -e'
ERROR='\033[0;31m'
INFO='\033[0;36m' 
NC='\033[0m'

if [[${EUID} -ne 0]]; then
	echo -e "${RED}This script must be run as root${NC}" 1>&2
	exit 1
else

check_command() {
	type "$1" &> /dev/null ;
}

werr(){
	printf "${ERROR}$1${NC}\n"
}

winfo(){
	printf "${INFO}$1${NC}\n"
}

# Python Requirement
if check_command python ; then
	winfo "Python already installed"
	if check_command pip ; then
		winfo "Pip already installed"
	else
		winfo "Installing Pip"
		wget https://bootstrap.pypa.io/get-pip.py > /tmp/get-pip.py
		python /tmp/get-pip.py
		pip install paramiko PyYAML Jinja2 httplib2 six
	fi
else
	winfo "Installing Python"
	apt-get install python

# Pip installer?
	winfo "Installing pip"
	wget https://bootstrap.pypa.io/get-pip.py > /tmp/get-pip.py
	python /tmp/get-pip.py
	pip install paramiko PyYAML Jinja2 httplib2 six
fi

# Git Requirement
if check_command git ; then
	winfo "Git already installed"
else
	apt-get install git
fi

# Java Requirements
if check_command java ; then
	winfo "Java already installed"
else
	apt-get install java
fi

#create ansible dir and check if it exists.
if ls /ansible > /dev/null; then
	winfo "Ansible already installed."
	exit 1
else
	echo "[localhost]" >> /ansible/inventory_hosts
	echo "127.0.0.1" >> /ansible/inventory_hosts
	export ANSIBLE_INVENTORY=/ansible/inventory_hosts
	cd /
	git clone git://github.com/ansible/ansible.git --recursive
	cd ansisble/
	
	source ./hacking/env-setup


fi




fi
