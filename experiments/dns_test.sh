#!/bin/bash

for i in {1..100}; do 
    curl -XGET http://web.service.consul:8080 -o /dev/null 2>/dev/null
done
