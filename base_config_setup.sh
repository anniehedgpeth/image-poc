#!/usr/bin/env bash

install_jq() {
	echo "[$(date +"%FT%T")] Install jq" | tee -a /var/log/ptfe.log
  curl --silent -Lo /bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
  chmod +x /bin/jq
}

apt_packages() {
	echo "[$(date +"%FT%T")] Install Ubuntu packages" | tee -a /var/log/base.log
	
	apt-get update -y
	apt-get install unzip -y
	apt-get install curl -y
	apt-get install chrony -y
	apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y
	curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
	AZ_REPO=$(lsb_release -cs)
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    	tee /etc/apt/sources.list.d/azure-cli.list
	apt-get update -y
	apt-get install azure-cli -y
}

apt_packages
install_jq
