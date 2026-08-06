DOTFILE_PATH := $(CURDIR)

DOTFILES := aliases exports functions zshrc git-prompt.sh gitconfig digrc
FILES := $(addprefix $(HOME)/.,$(DOTFILES))

OPENCODE_DIR := $(HOME)/.config/opencode

.DEFAULT_GOAL := help

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-10s %s\n", $$1, $$2}'

install: ## Install packages via Homebrew
	brew bundle

sync: $(FILES) ## Symlink dotfiles and opencode config into $HOME
	mkdir -p $(OPENCODE_DIR)
	ln -sfn $(DOTFILE_PATH)/opencode/opencode.json $(OPENCODE_DIR)/opencode.json
	ln -sfn $(DOTFILE_PATH)/opencode/agents $(OPENCODE_DIR)/agents

$(HOME)/.%: %
	ln -sfn $(DOTFILE_PATH)/$< $@

.PHONY: help install sync
