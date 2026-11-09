DOTFILE_PATH := $(CURDIR)

DOTFILES := aliases exports functions zprofile zshrc gitconfig digrc
FILES := $(addprefix $(HOME)/.,$(DOTFILES))

# Global agent instructions: one source, linked to $HOME (parent-dir traversal)
# plus the config dirs of tools that only look there for global rules.
AGENT_LINKS := $(HOME)/AGENTS.md $(HOME)/CLAUDE.md
AGENT_CONFIG_LINKS := $(HOME)/.codex/AGENTS.md

.DEFAULT_GOAL := help

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*## ' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-10s %s\n", $$1, $$2}'

install: ## Install packages via Homebrew
	brew bundle

sync: $(FILES) agents ## Symlink dotfiles and agent rules into $HOME

agents: $(AGENT_LINKS) $(AGENT_CONFIG_LINKS) ## Symlink AGENTS.md for all agent tools

$(AGENT_LINKS): AGENTS.md
	ln -sfn $(DOTFILE_PATH)/AGENTS.md $@

$(AGENT_CONFIG_LINKS): AGENTS.md
	mkdir -p $(dir $@)
	ln -sfn $(DOTFILE_PATH)/AGENTS.md $@

$(HOME)/.%: %
	ln -sfn $(DOTFILE_PATH)/$< $@

.PHONY: help install sync agents
