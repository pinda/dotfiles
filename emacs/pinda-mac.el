;; mac only settings.
;; use the old way of toggling to fullscreen
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "C-c f") 'toggle-frame-fullscreen)

(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; browser
(setq browse-url-browser-function 'browse-url-default-macosx-browser)

;; disable scrollbars and menu bar on the mac. On Linux you can disable it in
;; Xdefaults.
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; extend exec-path for homebrew
(setq exec-path (append exec-path '("/usr/local/bin")))

(provide 'pinda-mac)
