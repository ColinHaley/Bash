#!/bin/bash

if [[$EUID -ne 0]]; then
echo "This script must be run as root"
exit 1

else

check_command() {
type "$1" &> /dev/null ;
}

if check_command python ; then
apt-cyg install python
fi


fi
