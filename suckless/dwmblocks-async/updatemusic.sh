#!/bin/bash
# 34 + Signal Number (1) = 35
SIGNAL=35 

# Update once at start
pkill -RTMIN+1 dwmblocks

# Listen for metadata or status changes
playerctl --follow metadata --format '{{status}}' 2>/dev/null | while read -r line; do
    pkill -RTMIN+1 dwmblocks
done
