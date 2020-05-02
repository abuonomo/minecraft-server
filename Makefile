
.DEFAULT_GOAL := help
.PHONY: help requirements drive authorize info backup update run clean


MKFILE_PATH := $(abspath $(firstword $(MAKEFILE_LIST)))
MAKE_DIR := $(dir $(MKFILE_PATH))
SHASUM=sha1sum
PAPER_URL=https://papermc.io/api/v1/paper/1.15.2/237/download

get-paper: ## Download forge 1.15.2
	cd server; \
	curl $(PAPER_URL) > paper.jar

install: ## Install forge server
	cd server; \
	java -jar forge-installer.jar --installServer
	@echo "Be sure to accept the eula before starting the server. It will not work if you have not accepted the eula."
	@echo "Get recommended jar flags from https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/"

backup: ## backup to remote drive directory
	@echo "Do a backup"

update-vanilla: ## download latest vanilla server jar
	bash updatemcjar.sh -y --jar-path server.jar
	@echo "If you are on a mac, this script's sha1sum will not work. You need to manually validate the download with shasum."

run: ## Run the server as daemon and use auto-restarts
	cd server; \
    java -Xms10G -Xmx10G -XX\:+UseG1GC -XX\:+ParallelRefProcEnabled \
    -XX\:MaxGCPauseMillis=200 -XX\:+UnlockExperimentalVMOptions \
    -XX\:+DisableExplicitGC -XX\:+AlwaysPreTouch -XX:G1NewSizePercent=30 \
    -XX\:G1MaxNewSizePercent=40 -XX\:G1HeapRegionSize=8M -XX\:G1ReservePercent=20 \
    -XX\:G1HeapWastePercent=5 -XX\:G1MixedGCCountTarget=4 -XX\:InitiatingHeapOccupancyPercent=15 \
    -XX\:G1MixedGCLiveThresholdPercent=90 -XX\:G1RSetUpdatingPauseTimePercent=5 \
    -XX\:SurvivorRatio=32 -XX\:+PerfDisableSharedMem -XX\:MaxTenuringThreshold=1 \
    -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true \
    -jar paper.jar nogui	
	
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

