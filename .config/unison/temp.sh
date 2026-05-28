rsync -avz -e "ssh -p 22" --exclude="lock" --exclude=".parentlock" --exclude="cache2/" --exclude="startupCache/" /home/c0mplex/.config/librewolf/librewolf/ c0mplex@192.168.1.12:/home/c0mplex/.config/librewolf/librewolf/

