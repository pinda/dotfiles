;;; package --- Setup Python development environment
(elpy-enable)

;; enable flycheck
(when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))

;; disable certain modes
(setq elpy-modules (delq 'elpy-module-highlight-indentation elpy-modules))

(provide 'pinda-python)
