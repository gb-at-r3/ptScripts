#!/bin/bash

network_prefix=$1

if [[ -z "$network_prefix" || ! "$network_prefix" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Please provide a valid network prefix (e.g., 192.168.1)"
    exit 1
fi

current_date=$(date +%Y%m%d)
output_file=~/${current_date}_activeHosts.txt
> $output_file  # Clear the output file

for ip in $(seq 1 254); do
    ping -c 1 -W 1 ${network_prefix}.${ip} > /dev/null
    if [ $? -eq 0 ]; then
        echo "${network_prefix}.${ip}" >> $output_file
    fi
done

echo "Ping sweep completed. Active hosts saved to $output_file."
