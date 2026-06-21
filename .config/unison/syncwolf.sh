#!/bin/bash

# --- CONFIGURATION ---
REMOTE_USER="c0mplex"
REMOTE_HOST="192.168.1.12"
REMOTE_PORT="22"

LOCAL_BASE="$HOME/.config/librewolf/librewolf"
REMOTE_BASE="/home/$REMOTE_USER/.config/librewolf/librewolf"
# ---------------------

pick_profile() {
	local ini="$1/profiles.ini"
	for section in Profile1 Profile0; do
		local path
		path=$(grep -xA3 "^\[$section\]" "$ini" 2>/dev/null | sed -n 's/^Path=//p' | head -1)
		[ -n "$path" ] && [ -d "$1/$path" ] && echo "$path" && return 0
	done
	return 1
}

LOCAL_PROFILE=$(pick_profile "$LOCAL_BASE") || {
	echo "Error: no active LibreWolf profile found in $LOCAL_BASE"
	exit 1
}

echo "Finding remote profile..."
REMOTE_PROFILE=$(ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "
	grep -xA3 '^\[Profile1\]' $REMOTE_BASE/profiles.ini 2>/dev/null | sed -n 's/^Path=//p' | head -1
") || REMOTE_PROFILE=""

if [ -z "$REMOTE_PROFILE" ]; then
	REMOTE_PROFILE=$(ssh -p "$REMOTE_PORT" "$REMOTE_USER@$REMOTE_HOST" "
		grep -xA3 '^\[Profile0\]' $REMOTE_BASE/profiles.ini 2>/dev/null | sed -n 's/^Path=//p' | head -1
	") || REMOTE_PROFILE=""
fi

if [ -z "$REMOTE_PROFILE" ]; then
	echo "Error: could not find remote LibreWolf profile"
	exit 1
fi

LOCAL_PATH="$LOCAL_BASE/$LOCAL_PROFILE"
REMOTE_PATH="$REMOTE_BASE/$REMOTE_PROFILE"

echo "Local profile:  $LOCAL_PROFILE"
echo "Remote profile: $REMOTE_PROFILE"
echo "Overwriting remote profile contents from local..."

rsync -avz -e "ssh -p $REMOTE_PORT" \
	--delete \
	--exclude=lock \
	--exclude=.parentlock \
	--exclude=cache2/ \
	--exclude=startupCache/ \
	--exclude=jumpListCache \
	--exclude=OfflineCache \
	--exclude=weave/ \
	--exclude=storage-sync-v2.sqlite* \
	--exclude=places.sqlite* \
	--exclude=favicons.sqlite* \
	--exclude=cookies.sqlite* \
	--exclude=storage.sqlite \
	--exclude=webappsstore.sqlite* \
	--exclude=protections.sqlite \
	--exclude=content-prefs.sqlite \
	--exclude=formhistory.sqlite \
	--exclude=permissions.sqlite \
	--exclude=AlternateServices.bin \
	--exclude=SiteSecurityServiceState.bin \
	--exclude=synced-tabs.db* \
	--exclude=bounce-tracking-protection.sqlite \
	--exclude=signedInUser.json \
	--exclude=sessionstore-backups/ \
	--exclude=sessionCheckpoints.json \
	--exclude=broadcast-listeners.json \
	--exclude=notificationstore.json \
	--exclude=addonStartup.json.lz4 \
	--exclude=serviceworker.txt \
	--exclude=.git/ \
	"$LOCAL_PATH/" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH/"

echo "Sync complete!"
