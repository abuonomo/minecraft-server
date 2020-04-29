
.DEFAULT_GOAL := help
.PHONY: help requirements drive authorize info backup update run clean


MKFILE_PATH := $(abspath $(firstword $(MAKEFILE_LIST)))
MAKE_DIR := $(dir $(MKFILE_PATH))
SHASUM=sha1sum

backup: ## backup to remote drive directory 
	@echo "Do a backup"

update: ## download latest server jar
	alias sha1sum=$(SHASUM); \
	sha1sum server.jar; \
	bash updatemcjar.sh -y --jar-path server.jar

run: ## Run the server as daemon and use auto-restarts
	cd server && java -Xmx2048M -Xms1024M -jar ../server.jar nogui
	
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

