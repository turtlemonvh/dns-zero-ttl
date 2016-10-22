# Consul DNS Zero TTL Experiment

Consul recommends running with 0 TTL.  However, not all languages and systems behave as expected under 0 TTL.

This is a testbed for characterizing their behavior.


## Setup Instructions

Make sure you have the latest vagrant installed: https://www.vagrantup.com/downloads.html



```bash
# Start and ssh in
vagrant up
vagrant ssh

## Window 1
# Start consul, binding default port for dns
sudo /usr/local/bin/consul agent -dev -config-dir=/etc/consul.d/ -client 0.0.0.0 -dns-port 53 -recursor 8.8.8.8

## Window 2
python -m SimpleHTTPServer 8080

## In another window

# Check that both normal and upstream responses are working
dig @127.0.0.1 web.service.consul
dig @127.0.0.1 google.com



