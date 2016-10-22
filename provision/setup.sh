#!/bin/bash

# Install base deps
yum update
yum install -y curl wget unzip bind-utils strace iproute

# Installl consul
cd /tmp/
wget https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_linux_amd64.zip
unzip consul_0.7.0_linux_amd64.zip
mv consul /usr/local/bin/

# Set up default resolver
cat <<EOF >> /etc/resolv.conf
nameserver 127.0.0.1
nameserver 8.8.8.8
EOF

# Install python packages
chown -R vagrant:vagrant /usr/lib/python2.7/site-packages
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install requests

# Install sysdig
curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | bash

