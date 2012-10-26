DOTFILES = $(PWD)
all:: git vim zsh mutt

git::
	@ln -fs $(DOTFILES)/git/gitignore       ${HOME}/.gitignore
	@ln -fs $(DOTFILES)/git/gitconfig       ${HOME}/.gitconfig
	@echo Git is symlinked.

vim::
	@echo $(DOTFILES)
	@ln -fs $(DOTFILES)/vim/vimrc        ${HOME}/.vimrc
	@ln -fns $(DOTFILES)/vim/vim         ${HOME}/.vim
	@echo Vim is symlinked.

zsh::
	@ln -fs $(DOTFILES)/zsh/zshrc ${HOME}/.zshrc
	@ln -fs $(DOTFILES)/zsh/zshalias ${HOME}/.zshalias
	@ln -fs $(DOTFILES)/zsh/zshenv ${HOME}/.zshenv
	@ln -fns $(DOTFILES)/zsh/oh-my-zsh ${HOME}/.oh-my-zsh
	@echo ZSH symlinked.

mutt::
	@ln -fs $(DOTFILES)/mutt/offlineimaprc  ${HOME}/.offlineimaprc
	@ln -fs $(DOTFILES)/mutt/muttrc       	${HOME}/.muttrc
	@ln -fs $(DOTFILES)/mutt/msmtprc 		${HOME}/.msmtprc
	@ln -fs $(DOTFILES)/mutt/urlview  		${HOME}/.urlview
	@ln -fs $(DOTFILES)/mutt/sync_mailboxes ${HOME}/.sync_mailboxes
	@echo Mutt is symlinked.


