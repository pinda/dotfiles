;; default tab-width is two spaces
(setq-default tab-width 2
              js-indent-level 2
              c-basic-offset 2
              indent-tabs-mode nil)

;; email
(setq user-full-name "Joeri Djojosoeparto")
(setq user-mail-address "joeri@gibbon.co")

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

;; set by emacs
(custom-set-faces
 '(default ((t (:background nil))))
 '(italic ((t (:slant italic)))))
