#!/usr/bin/env bash
WORKING_ROOT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NETBOOT_GRUB_CLI_ROOT_PATH="${WORKING_ROOT_PATH}/ubuntu-server-netboot"
NETBOOT_GRUB_CLI="${NETBOOT_GRUB_CLI_ROOT_PATH}/ubuntu-server-netboot.py"
TFTP_DIR="/srv/tftp"
WWW_DIR="/var/www/html"

# try to cactch
#     INFO: Netboot generation complete: /tmp/tmpo54145m2/ubuntu-installer
# and extract /tmp/tmpo54145m2/ubuntu-installer to be
# temp_ubuntu_installer_dir
#
# stack overflow https://stackoverflow.com/questions/962255/how-to-store-standard-error-in-a-variable
netboot_grub_cli_output="$( { ${NETBOOT_GRUB_CLI} $@ > /dev/null ; } 2>&1 )'"

temp_ubuntu_installer_dir=$( echo ${netboot_grub_cli_output} | awk -F"Netboot generation complete: " '{print $2}' | awk -F"'" '{print $1}')

cp -r ${temp_ubuntu_installer_dir}/* ${TFTP_DIR}/


cp ${NETBOOT_GRUB_CLI_ROOT_PATH}/autoinstall/basic.yaml ${WWW_DIR}/user-data
touch ${WWW_DIR}/meta-data
