#!/bin/bash

# Trace python
echo "Testing python"
strace -f -e poll,select,connect,recvfrom,sendto python test_dns.py 2>&1 | grep '(53)' | grep connect | wc -l

# Trace curl
echo "Testing curl"
strace -f -e poll,select,connect,recvfrom,sendto bash test_dns.sh 2>&1 | grep '(53)' | grep connect | wc -l

# Trace go
# https://golang.org/pkg/net/#hdr-Name_Resolution
echo "Testing go; pure go resolver"
export GODEBUG=netdns=go
strace -f -e poll,select,connect,recvfrom,sendto go run test_dns.go 2>&1 | grep '(53)' | grep connect | wc -l

echo "Testing go; cgo resolver"
export GODEBUG=netdns=cgo
strace -f -e poll,select,connect,recvfrom,sendto go run test_dns.go 2>&1 | grep '(53)' | grep connect | wc -l

# Trace node
# https://nodejs.org/api/dns.html
echo "Testing node"
strace -f -e poll,select,connect,recvfrom,sendto node test_dns.js 2>&1 | grep '(53)' | grep connect | wc -l


