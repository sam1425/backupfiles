#!/bin/bash
# 34 + Signal Number (1) = 35
SIGNAL=35 

# Update once at start
pkill -RTMIN+1 dwmblocks

# Listen for metadata or status changes
playerctl --follow metadata --format '{{status}}' 2>/dev/null | while read -r line; do
    pkill -RTMIN+1 dwmblocks
done

    X("", "s=$(cat /tmp/x_st 2>/dev/null || echo 0); [ \"$BLOCK_BUTTON\" = \"1\" ] && s=$(((s+1)%2)) && echo \"$s\" > /tmp/x_st; [ \"$s\" = \"1\" ] && echo \"X\" || echo \" \"",   0,                    14) \
