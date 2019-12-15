
.DEFAULT_GOAL := help
.PHONY: help requirements drive authorize info backup update run clean

include env
export $(shell sed 's/=.*//' env)

MKFILE_PATH := $(abspath $(firstword $(MAKEFILE_LIST)))
MAKE_DIR := $(dir $(MKFILE_PATH))

gdrive: ## download gdrive tool 
	wget https://github.com/gdrive-org/gdrive/releases/download/2.1.0/gdrive-linux-x64

build: ## build docker image
	docker build -t minecraft-server .

debug: ## get an interactive shell in the docker container
	docker run --rm -it --entrypoint "" \
		-e BACKUP_GDRIVE_LOC=$(BACKUP_GDRIVE_LOC) \
		-v $(MAKE_DIR)/.gdrive:/root/.gdrive \
		-v $(MAKE_DIR)/server:/home/server/ \
		minecraft-server:latest bash

authorize: ## authorize gdrive to work with your account
	docker run --rm -it --entrypoint "" \
		-e BACKUP_GDRIVE_LOC=$(BACKUP_GDRIVE_LOC) \
		-v $(MAKE_DIR)/.gdrive:/root/.gdrive \
		minecraft-server:latest \
		gdrive about

info: ## get info about backup drive dir
	docker run --rm -it --entrypoint "" \
		-e BACKUP_GDRIVE_LOC=$(BACKUP_GDRIVE_LOC) \
		-v $(MAKE_DIR)/.gdrive:/root/.gdrive \
		minecraft-server:latest \
		gdrive info $(BACKUP_GDRIVE_LOC)

backup: ## backup to remote drive directory 
	docker run --rm -it --entrypoint "" \
		-e BACKUP_GDRIVE_LOC=$(BACKUP_GDRIVE_LOC) \
		-v $(MAKE_DIR)/.gdrive:/root/.gdrive \
		-v $(MAKE_DIR)/server:/home/server/ \
		minecraft-server:latest \
		gdrive sync upload server --keep-local $(BACKUP_GDRIVE_LOC)

update: ## download latest server jar
	bash updatemcjar.sh -y --jar-path server.jar

run-dev: ## remove last container named "minecraft-server" and then run the server
	docker rm minecraft-server
	docker run -it --name minecraft-server \
		-e BACKUP_GDRIVE_LOC=$(BACKUP_GDRIVE_LOC) \
		-p 25565:25565 \
		-v $(MAKE_DIR)/server:/home/server/ \
		-v $(MAKE_DIR)/.gdrive:/root/.gdrive/ \
		minecraft-server:latest

run: ## Run the server as daemon and use auto-restarts
	docker run -d --restart always --name minecraft-server \
		-e BACKUP_GDRIVE_LOC=$(BACKUP_GDRIVE_LOC) \
		-p 25565:25565 \
		-v $(MAKE_DIR)/server:/home/server/ \
		-v $(MAKE_DIR)/.gdrive:/root/.gdrive/ \
		minecraft-server:latest

	
clean: ## stop server, remove docker container, delete image, remove .gdrive folder
	docker stop minecraft-server
	docker rm minecraft-server
	docker rmi minecraft-server
	rm -r .gdrive

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

