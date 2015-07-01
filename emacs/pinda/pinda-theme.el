;; active theme
(load-theme 'sanityinc-tomorrow-night)

;; FONT
(set-frame-font "DejaVu Sans Mono-15")
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-15"))

(defun toggle-dark-light-theme ()
  "Switch between dark and light theme."
  (interactive)
  (if (eq (frame-parameter (next-frame) 'background-mode) 'dark)
      (load-theme 'sanityinc-solarized-light)
    (load-theme 'zenburn)))

(provide 'pinda-theme)
