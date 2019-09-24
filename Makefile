# ~/etc/Makefile
#  __  __       _         __ _ _      
# |  \/  | __ _| | _____ / _(_) | ___ 
# | |\/| |/ _` | |/ / _ \ |_| | |/ _ \
# | |  | | (_| |   <  __/  _| | |  __/
# |_|  |_|\__,_|_|\_\___|_| |_|_|\___|
# ---------------------------------------------------------------------------
HEREIAM     = $(shell pwd)
DOTFILES    = Rprofile Xresources gitconfig exrc gemrc gvimrc vimrc irbrc kermitrc \
			  mykermrc psqlrc ssh-agent tcshrc xinitrc zshenv zshrc
DOTDIRS     = ssh vim

.DEFAULT_GOAL := git-status

# -----------------------------------------------------------------------------
.PHONY: clean
git-status:
	@ git status

here:
	@ echo $(HEREIAM)

link:
	@ for v in $(DOTFILES); do \
		test -L ~/.$$v || echo .$$v; \
		test -L ~/.$$v || ln -s `echo $(HEREIAM) | sed 's|$(HOME)/||g'`/$$v ~/.$$v || true; \
	done
	@ for v in $(DOTDIRS); do \
		test -L ~/.$$v || echo .$$v; \
		test -L ~/.$$v || ln -s `echo $(HEREIAM) | sed 's|$(HOME)/||g'`/$$v ~/.$$v || true; \
	done

push:
	for G in `git remote show -n`; do \
		git push --tags $$G master; \
	done

clean:
	find . -name '.DS_Store' -delete

