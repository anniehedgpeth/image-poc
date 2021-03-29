#!/usr/bin/env bash

install_jq() {
	echo "[$(date +"%FT%T")] Install JQ" | tee -a /var/log/ptfe.log

	curl --silent -Lo /bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
	chmod +x /bin/jq
}

apt_packages() {
	echo "[$(date +"%FT%T")] Install Ubuntu packages" | tee -a /var/log/ptfe.log
	
	apt-get update -y
	apt-get install unzip -y
	apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y
	curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
	AZ_REPO=$(lsb_release -cs)
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    	tee /etc/apt/sources.list.d/azure-cli.list
	apt-get update -y
	apt-get install azure-cli -y
}

yum_packages() {
	echo "[$(date +"%FT%T")] Install RHEL packages" | tee -a /var/log/ptfe.log
	
	yum update -y
	yum install unzip -y
	rpm --import https://packages.microsoft.com/keys/microsoft.asc
	echo -e "[azure-cli]
name=Azure CLI
baseurl=https://packages.microsoft.com/yumrepos/azure-cli
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc" | tee /etc/yum.repos.d/azure-cli.repo
	yum install azure-cli -y
	lvresize -r -L +20G /dev/mapper/rootvg-varlv
}

echo "[$(date +"%FT%T")] Determine distribution" | tee -a /var/log/ptfe.log
DISTRO_NAME=$(grep "^NAME=" /etc/os-release | cut -d"\"" -f2)

install_jq
if [[ $DISTRO_NAME == *"Red Hat"* ]]
then
	yum_packages
else
	apt_packages
fi
