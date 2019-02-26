#!/bin/bash -e

# This script install mssql-server, mssql-server-extensibility, and mssql-mlservices packages.
#

# copy supervisord.conf
cp /tmp/supervisord.conf /usr/local/etc/supervisord.conf

# install dependent packages
#
apt-get update
apt-get install -y --allow-unauthenticated supervisor fakechroot locales iptables sudo wget curl zip unzip make bzip2 m4 apt-transport-https tzdata libnuma-dev libsss-nss-idmap-dev software-properties-common

# register Microsoft SQL Server repository for Preview SQL Server 2019
#
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add - 
add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-preview.list)" 

# install mssql-server
#
apt-get update
apt-get install -y --allow-unauthenticated mssql-server

# install mssql-server-extensibility
# WORKAROUND to skip running postinst script to not start systemd services
# TODO: once mssql-server-extensibility setup pkg is fixed and publish,
#       change this step to 'apt-get install -y mssql-server-extensibility'
cd /tmp/
apt-get -y --allow-unauthenticated download mssql-server-extensibility
dpkg --unpack --ignore-depends="mssql-server" mssql-server-extensibility*.deb
rm /var/lib/dpkg/info/mssql-server-extensibility.postinst -f
dpkg --configure mssql-server-extensibility
apt-get install -yf --allow-unauthenticated

# run checkinstallextensibility
#
/opt/mssql/bin/checkinstallextensibility.sh

# add azure-cli repo to apt sources list
#
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# register microsoft repo
#
wget https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

# install mlservices
# for r, mssql-mlservices-packages-r
# for python, mssql-mlservices-packages-python
#
apt-get update
apt-get install -y --allow-unauthenticated mssql-mlservices-packages-r mssql-mlservices-packages-py

# cleanup
#
apt-get clean
rm -rf /var/apt/cache/* /tmp/* /var/tmp/*
