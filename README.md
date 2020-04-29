# Minecraft Server 

This project helps you set up a minecraft-server docker container that uploads the server data to google drive whenever the machine shuts down.

### TODO:
- Need entirely new backup strategy. Gdrive tool does not work anymore. Need to take another route for automatic backups : (
- server.jar should not be posted to repo, but update command does not work without it. There is surely a better way. 

## Installation
*Note: this instructions were tested on amazon linux.*


```bash
make help
```

Install requirements with:
```bash
make requirements
```

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

Run the server with:
```bash
make run
```

