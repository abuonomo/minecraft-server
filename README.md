# Minecraft Server 

Convenience Makefile for running minecraft server. Uses [paper](https://papermc.io/).

## Installation
*Note: this instructions were tested on amazon linux.*

Simply run:
```bash
make get-paper run 
```
You will see a message like this:
```txt
You need to agree to the EULA in order to run the server. Go to eula.txt for more info.
```
You can agree to the eula by changing the value of `eula` in `server/eula.txt` from 'false' to `true`.
Then run:
```
make run
```
The server should start running.

## Configuration
You can change the minecraft version to download by changing the MC_VERSION argument in the Makefile. For example, you could run:
```bash
make get-paper MC_VERSION=1.15
```
You can also changing the amount of ram allocated to the server with the RAM arg. For example:
```bash
make run RAM=1
```

See options with:
```bash
make help
```

If you are running this server with an existing world, you must put your world data into the `server` directory with the name `world`. So you will have `server/world`.

The structure looks something like this:
```txt
├── Makefile
├── README.md
├── server
│   ├── banned-ips.json
│   ├── banned-players.json
│   ├── bukkit.yml
│   ├── cache
│   ├── commands.yml
│   ├── eula.txt
│   ├── help.yml
│   ├── logs
│   ├── ops.json
│   ├── paper.jar
│   ├── paper.yml
│   ├── permissions.yml
│   ├── plugins
│   ├── server.properties
│   ├── spigot.yml
│   ├── usercache.json
│   ├── version_history.json
│   ├── whitelist.json
│   ├── world
│   ├── world_nether
│   └── world_the_end
└── updatemcjar.sh
```
You might notice there are several world folders: `world`, `world_nether`, and `world_the_end`. Paper will automatically create the `world_nether` and `world_the_end` folders for you when running paper with a vanilla `world` folder. Read more [here](https://paper.readthedocs.io/en/latest/server/getting-started.html#migrating-from-vanilla).

## Installing plugins
Drop plugin jar into the server/plugins directory.


### TODO:
- Need entirely new backup strategy. Gdrive tool does not work anymore. Need to take another route for automatic backups : (
