SRC_DIR = src


all:
	@echo "Usage:"
	@echo "\tmake install: install git daemon startup script."
.PHONY: all


install:
	sudo install -m 0755 $(SRC_DIR)/git-daemon.sh /etc/init.d/git-daemon
	sudo update-rc.d git-daemon defaults
.PHONY: install
