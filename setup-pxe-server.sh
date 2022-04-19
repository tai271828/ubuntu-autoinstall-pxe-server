#!/usr/bin/env bash
WORKING_ROOT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NETBOOT_GRUB_CLI_ROOT_PATH="${WORKING_ROOT_PATH}/ubuntu-server-netboot"
NETBOOT_GRUB_CLI="${NETBOOT_GRUB_CLI_ROOT_PATH}/ubuntu-server-netboot.py"
# focal
#TFTP_DIR="/srv/tftp"
# bionic
TFTP_DIR="/var/lib/tftpboot"
WWW_DIR="/var/www/html"


all_arguments=$@
wrapper_name=$(basename $0)
core_cmd_name=$(basename ${NETBOOT_GRUB_CLI})

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --iso)
    iso="$2"
    shift
    ;;
    --autoinstall-url)
    autoinstall_url="$2"
    shift
    ;;
    -h|--help)
    help="1"
    ;;
    *)
      # unknown option
    ;;
esac
shift # past argument or value
done

if [ -n "$help" ]; then
    echo "${wrapper_name} is a wrapper of ${core_cmd_name}"
    echo "It adapts all arguments provided by ${core_cmd_name}"
    echo
    echo "Use ${wrapper_name} by invoking:"
    echo "    sudo ${wrapper_name}"
    echo
    ${NETBOOT_GRUB_CLI} -h

    exit
fi


# try to cactch
#     INFO: Netboot generation complete: /tmp/tmpo54145m2/ubuntu-installer
# and extract /tmp/tmpo54145m2/ubuntu-installer to be
# temp_ubuntu_installer_dir
#
# stack overflow https://stackoverflow.com/questions/962255/how-to-store-standard-error-in-a-variable
netboot_grub_cli_output="$( { ${NETBOOT_GRUB_CLI} ${all_arguments} > /dev/null ; } 2>&1 )'"

temp_ubuntu_installer_dir=$( echo ${netboot_grub_cli_output} | awk -F"Netboot generation complete: " '{print $2}' | awk -F"'" '{print $1}')

# enable PXE
cp -r ${temp_ubuntu_installer_dir}/* ${TFTP_DIR}/

# enable autoinstall
if [ -n "${autoinstall_url}" ]
then
    echo "Enabled: autoinstall ${autoinstall_url}"
    cp ${NETBOOT_GRUB_CLI_ROOT_PATH}/autoinstall/basic.yaml ${WWW_DIR}/user-data
    touch ${WWW_DIR}/meta-data
fi

# enable provision of image locally
if [ -n "${iso}" ]
then
    echo "Enabled: iso cache for autoinstall ${iso}"
    cp ${iso} ${WWW_DIR}/
fi
