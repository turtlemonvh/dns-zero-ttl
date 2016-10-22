#!/bin/bash

# Trace python code looking for dns lookups
# Shows 100 lookups
echo "Testing python"
strace -f -e poll,select,connect,recvfrom,sendto python test_dns.py 2>&1 | grep '(53)' | grep connect | wc -l

# Trace curl code looking for dns lookups
# Shows 100 lookups
echo "Testing curl"
strace -f -e poll,select,connect,recvfrom,sendto bash test_dns.sh 2>&1 | grep '(53)' | grep connect | wc -l

# Shows 200 lookups...?
echo "Testing go"
strace -f -e poll,select,connect,recvfrom,sendto go run test_dns.go 2>&1 | grep '(53)' | grep connect | wc -l
