#!/bin/bash

# --- CONFIGURATION ---
REMOTE_USER="c0mplex"
REMOTE_HOST="192.168.1.12"
REMOTE_PORT="22"  # <-- Change this to your remote SSH port

# Native Arch AUR packages use ~/.mozilla/librewolf
LOCAL_BASE="$HOME/.config/librewolf/librewolf"
REMOTE_BASE="/home/$REMOTE_USER/.config/librewolf/librewolf"
# ---------------------

# 1. Dynamically find the specific profile folder (handles mr7i5ncw.default-default-1)
LOCAL_PROFILE=$(command find "$LOCAL_BASE" -maxdepth 1 -type d -name "*.default-default*" | head -n 1)

if [ -z "$LOCAL_PROFILE" ]; then
    echo "Error: Local LibreWolf profile not found in $LOCAL_BASE"
    exit 1
fi

# Extract the directory name (mr7i5ncw.default-default-1)
PROFILE_FOLDER=$(basename "$LOCAL_PROFILE")

echo "Found local profile: $PROFILE_FOLDER"
echo "Ensuring remote directory structure exists on port $REMOTE_PORT..."

# 2. Ensure the directory path exists on the remote machine
ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "mkdir -p $REMOTE_BASE/$PROFILE_FOLDER"

# 3. Fire up Unison with the explicit absolute paths
unison librewolf \
    -root "$LOCAL_BASE/$PROFILE_FOLDER" \
    -root "ssh://$REMOTE_USER@$REMOTE_HOST:$REMOTE_PORT//$REMOTE_BASE/$PROFILE_FOLDER" \
    -batch

echo "Sync complete!"
