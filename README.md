# Minecraft Server 

This project helps you set up a minecraft-server docker container that uploads the server data to google drive whenever the machine shuts down.

### TODO:
Figure out why there are conflicts when trying to upload server data. Find a safe way. --> resolved by just keeping the local copy

Not enough time to upload. Needs more time to shutdown in order to actually update.


## Installation
*Note: this instructions were tested on amazon linux.*

This project requires Docker and GNU Make.

Then, you can see some options by running:
```bash
make help
```

Install requirements with:
```bash
make requirements
```

Then, in order to backup the server data to google drive, you must authorize the gdrive command line tool to work with your google drive. **You may want to make a separate google account and share your chosen folder with that account. This better protects your main account.**

```bash
make authorize
```
Follow the instructions provided.

Then, find the ID of the folder you want to upload your server data to. See [here](https://ploi.io/documentation/mysql/where-do-i-get-google-drive-folder-id).

Make a file called `env` with these contents:
```
BACKUP_FOLDER_ID=<YOUR_FOLDER_ID>
```

You should now be able to run `make info` to get information about your folder. 

If you run `make backup`, the contents of the local `server` directory will be sync uploaded to the provided google drive folder.

If you are running this server with an existing world, you must put your server data into the `server` directory so that the structure looks like this:
```
.
├── Dockerfile
├── Makefile
├── README.md
├── server
│   ├── banned-ips.json
│   ├── banned-players.json
│   ├── eula.txt
│   ├── logs
│   ├── ops.json
│   ├── server.properties
│   ├── usercache.json
│   ├── whitelist.json
│   └── world
├── server.jar
├── start-server.sh
└── updatemcjar.sh
```

To set up the system so it automatically backs up your `server` folder on shutdown and reboot, first run `make autobackup`.

Then run `service minecraft-server start`. Follow instructions for authorizing the script to upload.

After completing these steps, the server should automatically backup to the specified drive upon shutdown and reboot.
