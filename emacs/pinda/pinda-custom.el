;; default tab-width is two spaces
(setq-default tab-width 2
              js-indent-level 4
              c-basic-offset 2
              indent-tabs-mode nil)

;; email
(setq user-full-name "Joeri Djojosoeparto")
(setq user-mail-address "joeri@gibbon.co")

;; set the editor hardcoded to Emacs. Fixes Magit.
(setenv "EDITOR" "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient")

;; desktop, to automatically save and restore sessions
(setq desktop-dirname             "~/.emacs.d/desktop/"
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                t
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil)

;; unicode
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; warnings
(setq visible-bell t)
(setq ring-bell-function (lambda nil (message "")))

;; scrolling
(setq scroll-conservatively 10000) ; don't jump my screen!

;; autosave
(setq auto-save-interval 500)

;; follow symlinks and don't ask questions
(setq vc-follow-symlinks t)

;; always show the region
(setq transient-mark-mode t)

;; enable clipboard on x
(setq x-select-enable-clipboard t)

;; format the title-bar to always include the buffer name
(setq frame-title-format " %b (%m)")

;; autoselect window with mouse
(setq mouse-autoselect-window t)

;; dont show the GNU splash screen
(setq inhibit-startup-message t)

;; dont ask for yes or no, just use y or n
(fset 'yes-or-no-p 'y-or-n-p)

;; auto-fill
(setq-default fill-column 78)

;; truncate long lines
(setq-default truncate-lines nil)

;; european dates
(setq calendar-date-style 'european)

;; prevents warning when sending mail
(setq gnutls-min-prime-bits 1024)

;; spelling
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

;; set by emacs
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(italic ((t (:slant italic)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("5e6c2e2116c7a72ae0668390f92504fd0b77524cedd387582648b1aa1c582f59" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "c5207e7b8cc960e08818b95c4b9a0c870d91db3eaf5959dd4eba09098b7f232b" default)))
 '(js2-basic-offset 2)
 '(js2-bounce-indent-p t)
 '(send-mail-function (quote smtpmail-send-it)))
