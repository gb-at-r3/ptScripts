#!/bin/bash

network_prefix=$1

for ip in $(seq 1 254); do
    ping -c 1 -W 1 ${network_prefix}.${ip} > /dev/null
    if [ $? -eq 0 ]; then
        echo "${network_prefix}.${ip} is active"
    fi
done
