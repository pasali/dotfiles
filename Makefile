
DOTFILE_PATH := $(shell pwd)

FILES := $(HOME)/.aliases $(HOME)/.exports $(HOME)/.functions $(HOME)/.zshrc $(HOME)/.git-prompt.sh $(HOME)/.gitconfig $(HOME)/.digrc

$(HOME)/.%: %
	ln -sf $(DOTFILE_PATH)/$^ $@

install:
	brew bundle
	code --install-extension github.github-vscode-theme
	code --install-extension eamodio.gitlens
	code --install-extension golang.go
	code --install-extension hashicorp.terraform
	code --install-extension ms-vscode-remote.remote-containers
	code --install-extension k--kato.intellij-idea-keybindings

sync: $(FILES)
	ln -sf "${DOTFILE_PATH}/vscode/settings.json" "${HOME}/Library/Application\ Support/Code/User/settings.json"

.PHONY: sync install