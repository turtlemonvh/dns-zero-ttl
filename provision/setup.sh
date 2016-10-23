#!/bin/bash

# Install base deps
yum update
yum install -y curl wget unzip bind-utils strace iproute

# Install consul
cd /tmp/
wget https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_linux_amd64.zip
unzip consul_0.7.0_linux_amd64.zip
mv consul /usr/local/bin/

# Set up default resolver
cat <<EOF > /etc/resolv.conf
nameserver 127.0.0.1
nameserver 8.8.8.8
EOF

# Install python packages
cd /tmp/
chown -R vagrant:vagrant /usr/lib/python2.7/site-packages
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install requests

# Install golang
cd /tmp/
export VERSION=1.7.3
export OS=linux
export ARCH=amd64
wget https://storage.googleapis.com/golang/go$VERSION.$OS-$ARCH.tar.gz
tar -C /usr/local -xzf go$VERSION.$OS-$ARCH.tar.gz
export PATH=$PATH:/usr/local/go/bin

# Install nodejs
cd /tmp
wget https://nodejs.org/dist/v4.6.1/node-v4.6.1-linux-x64.tar.xz
tar xf node-v4.6.1-linux-x64.tar.xz
mkdir -p /usr/local/node
mv node-v4.6.1-linux-x64/* /usr/local/node/

# Install sysdig
cd /tmp/
curl -s https://s3.amazonaws.com/download.draios.com/stable/install-sysdig | bash

# Update bashrc
cat <<EOF >> /home/vagrant/.bashrc
export GOPATH=\$HOME/work
export PATH=\$PATH:/usr/local/go/bin:/usr/local/node/bin
EOF
