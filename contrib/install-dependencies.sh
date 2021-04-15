#!/bin/bash
apt update
apt install genisoimage mtools python3-distro-info -y

# if you want this tool to setup pxe server for you
# these packages will be useful when invoking --deploy-dir
apt install apache2 tftpd-hpa -y
