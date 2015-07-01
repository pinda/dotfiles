;; place to save customizations
(setq custom-file "~/.emacs.d/pinda-custom.el")
(require 'cl)

;; load main configuration
(when (file-exists-p custom-file)
  (load custom-file))

;; package repositories
(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("elpy" . "http://jorgenschaefer.github.io/packages/")
                		 ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; my packages
(dolist (p '( ;; fundamentals
             magit gist ack-and-a-half auto-complete
             buffer-move s projectile goto-last-change
             expand-region change-inner powerline surround
             idomenu diminish dired-details multiple-cursors ag
             restclient rainbow-delimiters smex smartparens evil
             exec-path-from-shell flycheck

             ;; modes
             org org-plus-contrib pandoc-mode markdown-mode
             git-commit-mode gitconfig-mode gitignore-mode
             js2-mode yaml-mode ido-ubiquitous flx-ido
             undo-tree ace-jump-mode web-mode
	     go-mode go-eldoc gotest go-projectile

             ;; languages
             nrepl ac-nrepl ac-slime clojure-mode
             clojure-test-mode cljdoc clojurescript-mode
             elpy slime slime-repl anything

	     ;; auto-completion
	     company company-go company-ghc
             
             ;; themes
             zenburn-theme color-theme-sanityinc-tomorrow
             color-theme-sanityinc-solarized))
  (when (not (package-installed-p p))
    (package-install p)))

;; configuration files
(setq config-dir (file-name-directory
                  (or (buffer-file-name) load-file-name)))
(add-to-list 'load-path config-dir)

(require 'pinda-defuns)     ; my functions
(require 'pinda-modes)      ; settings for specific modes
(require 'pinda-bindings)   ; load bindings
(require 'pinda-theme)      ; set the theme and font
(require 'pinda-evil)       ; vim emulation
(require 'pinda-temp)       ; temporary files
(require 'pinda-shell)      ; shell mode
;(require 'pinda-lisp)       ; lisp languages
;(require 'pinda-cocoa)      ; cocoa
(require 'pinda-python)     ; python
(require 'pinda-go)         ; go
(require 'pinda-mac)     ; mac settings

;; email only on my local computer
;(when (string-equal system-name "Pinda.local")
;(require 'pinda-mu4e)
