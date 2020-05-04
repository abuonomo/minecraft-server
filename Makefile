
.DEFAULT_GOAL := help
.PHONY: help requirements drive authorize info backup update run clean

MKFILE_PATH := $(abspath $(firstword $(MAKEFILE_LIST)))
MAKE_DIR := $(dir $(MKFILE_PATH))
MC_VERSION=1.15
PAPER_URL=https://papermc.io/ci/job/Paper-$(MC_VERSION)/lastSuccessfulBuild/artifact/paperclip.jar
RAM=2

get-paper: ## Download paper.jar
	cd server; \
	curl $(PAPER_URL) > paper.jar

backup: ## DEPRECATED: backup to remote drive directory
	@echo "Do a backup"

run: ## Run the server as daemon and use auto-restarts
	cd server; \
    java -Xms$(RAM)G -Xmx$(RAM)G -XX\:+UseG1GC -XX\:+ParallelRefProcEnabled \
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

