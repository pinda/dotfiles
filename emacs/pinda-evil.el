;; evil mode
(evil-mode t)
(global-surround-mode t)

;; cursor
(setq evil-default-cursor t)

;; magit
(evil-add-hjkl-bindings magit-branch-manager-mode-map 'emacs
  "K" 'magit-discard-item
  "L" 'magit-key-mode-popup-logging)
(evil-add-hjkl-bindings magit-status-mode-map 'emacs
  "K" 'magit-discard-item
  "l" 'magit-key-mode-popup-logging
  "h" 'magit-toggle-diff-refine-hunk)

;; use emacs in the following modes
(mapc (lambda (mode) (evil-set-initial-state mode 'emacs))
       '(inferior-emacs-lisp-mode
         comint-mode
         shell-mode
         term-mode
         nrepl-mode
         magit-branch-manager-mode))

;; nrepl
(define-key evil-normal-state-map (kbd "M-]") 'find-tag)
(define-key evil-normal-state-map (kbd "M-,") 'nrepl-jump-back)
(define-key evil-normal-state-map (kbd "M-.") 'nrepl-jump)

(provide 'pinda-evil)
