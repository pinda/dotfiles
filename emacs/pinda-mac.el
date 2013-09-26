;; mac only settings.
;; use the old way of toggling to fullscreen
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "<f3>") 'toggle-frame-fullscreen)
(set-face-attribute 'default nil :height 160)

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
