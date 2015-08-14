# Makefile for share/dot-files
#  __  __       _         __ _ _      
# |  \/  | __ _| | _____ / _(_) | ___ 
# | |\/| |/ _` | |/ / _ \ |_| | |/ _ \
# | |  | | (_| |   <  __/  _| | |  __/
# |_|  |_|\__,_|_|\_\___|_| |_|_|\___|
# ---------------------------------------------------------------------------
HEREIAM     = $(shell pwd)

.PHONY: clean
here:
	@echo $(HEREIAM)

push:
	for G in `git remote show -n`; do \
		git push --tags $$G master; \
	done

