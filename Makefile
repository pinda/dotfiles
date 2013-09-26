DOTFILES = $(PWD)
all:: git vim emacs zsh mutt

git::
	@ln -fs $(DOTFILES)/git/gitignore       ${HOME}/.gitignore
	@ln -fs $(DOTFILES)/git/gitconfig       ${HOME}/.gitconfig
	@echo Git is symlinked.

vim::
	@echo $(DOTFILES)
	@ln -fs $(DOTFILES)/vim/vimrc        ${HOME}/.vimrc
	@ln -fns $(DOTFILES)/vim/vim         ${HOME}/.vim
	@echo Vim is symlinked.

emacs::
	@ln -fs $(DOTFILES)/emacs/emacs.el		${HOME}/.emacs
	@ln -fns $(DOTFILES)/emacs						${HOME}/.emacs.d
	@echo Emacs is symlinked.

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

slate::
	@ln -fs $(DOTFILES)/slate/slate 	${HOME}/.slate
	@echo Slate is symlinked.

tmux::
	@ln -fs $(DOTFILES)/tmux/tmux.conf 	${HOME}/.tmux.conf
	@echo tmux is symlinked.
