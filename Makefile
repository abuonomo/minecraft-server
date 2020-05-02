
.DEFAULT_GOAL := help
.PHONY: help requirements drive authorize info backup update run clean


MKFILE_PATH := $(abspath $(firstword $(MAKEFILE_LIST)))
MAKE_DIR := $(dir $(MKFILE_PATH))
SHASUM=sha1sum
FORGE_URL=https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.15.2-31.1.0/forge-1.15.2-31.1.0-installer.jar

get-forge: ## Download forge 1.15.2
	curl $(FORGE_URL) > forge-installer.jar
	@echo "Make sure forge intalled version matches your vanilla server version."

install: ## Install forge server
	java -jar forge-installer.jar --installServer

backup: ## backup to remote drive directory
	@echo "Do a backup"

update-vanilla: ## download latest vanilla server jar
	bash updatemcjar.sh -y --jar-path server.jar
	@echo "If you are on a mac, this script's sha1sum will not work. You need to manually validate the download with shasum."

run: ## Run the server as daemon and use auto-restarts
	cd server && java -Xmx2048M -Xms1024M -jar ../forge-1.15.2-31.1.0.jar nogui
	
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

