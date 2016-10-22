#!/bin/bash

# Trace python code looking for dns lookups
# Shows 100 lookups
echo "Testing python"
strace -f -e poll,select,connect,recvfrom,sendto python dns_test.py 2>&1 | grep '(53)' | grep connect | wc -l

# Trace curl code looking for dns lookups
# Shows 100 lookups
echo "Testing curl"
strace -f -e poll,select,connect,recvfrom,sendto bash dns_test.sh 2>&1 | grep '(53)' | grep connect | wc -l

