DOTFILE_PATH := $(CURDIR)

DOTFILES := aliases exports functions zprofile zshrc git-prompt.sh gitconfig digrc
FILES := $(addprefix $(HOME)/.,$(DOTFILES))

OPENCODE_DIR := $(HOME)/.config/opencode

# Global agent instructions: one source, linked to $HOME (parent-dir traversal)
# plus the config dirs of tools that only look there for global rules.
AGENT_LINKS := $(HOME)/AGENTS.md $(HOME)/CLAUDE.md
AGENT_CONFIG_LINKS := $(HOME)/.codex/AGENTS.md $(OPENCODE_DIR)/AGENTS.md

.DEFAULT_GOAL := help

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-10s %s\n", $$1, $$2}'

install: ## Install packages via Homebrew
	brew bundle

sync: $(FILES) agents ## Symlink dotfiles, agent rules and opencode config into $HOME
	mkdir -p $(OPENCODE_DIR)
	ln -sfn $(DOTFILE_PATH)/opencode/opencode.json $(OPENCODE_DIR)/opencode.json
	ln -sfn $(DOTFILE_PATH)/opencode/agents $(OPENCODE_DIR)/agents

agents: $(AGENT_LINKS) $(AGENT_CONFIG_LINKS) ## Symlink AGENTS.md for all agent tools

$(AGENT_LINKS): AGENTS.md
	ln -sfn $(DOTFILE_PATH)/AGENTS.md $@

$(AGENT_CONFIG_LINKS): AGENTS.md
	mkdir -p $(dir $@)
	ln -sfn $(DOTFILE_PATH)/AGENTS.md $@

$(HOME)/.%: %
	ln -sfn $(DOTFILE_PATH)/$< $@

.PHONY: help install sync agents
