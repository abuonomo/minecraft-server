#!/bin/bash

function main {
	cd /home/server/
    java -Xmx2048M -Xms1024M -jar ../server.jar nogui
}

function backup {
	echo "Backing up server files..."	
	cd /home/
	gdrive sync upload server --keep-local ${BACKUP_GDRIVE_LOC}
	echo "Done."
}

trap backup SIGINT SIGTERM

main &

wait $!
