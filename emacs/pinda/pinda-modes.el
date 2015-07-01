;; show column numbers
(column-number-mode t)

;; don't show the menubar
(menu-bar-mode -1)

;; highlight the current line
(global-hl-line-mode t)

;; projectile for project management
(projectile-global-mode)
(setq projectile-ack-function 'ag)

;; deletes region when starting typing
(pending-delete-mode t)

;; auto revert changes on disk
(global-auto-revert-mode t)

;; enable powerline mode
(setq powerline-arrow-shape 'curve)
(powerline-default-theme)

;; indent after newline
(electric-indent-mode t)

;; auto-completion
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
(add-hook 'after-init-hook 'global-company-mode)     ; auto-complete in every buffer
;; auto completion
(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start nil)    ; don't automatically trigger auto-complete
(ac-set-trigger-key "TAB")  ; only trigger auto-completion on TAB

;; recently opened files
(recentf-mode 1)
(setq recentf-max-saved-items 30)
(add-to-list 'recentf-exclude "\\/tmp\\'" "~/.ido.last")

;; javascript and json
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

;; jinja
(add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode))

;; Use js-mode indentation in js2-mode, I don't like js2-mode's indentation
;;
;; thanks http://mihai.bazon.net/projects/editing-javascript-with-emacs-js2-mode
;; with my own modifications
;;
(defun my-js2-indent-function ()
  (interactive)
  (save-restriction
    (widen)
    (let* ((inhibit-point-motion-hooks t)
           (parse-status (save-excursion (syntax-ppss (point-at-bol))))
           (offset (- (current-column) (current-indentation)))
           (indentation (js--proper-indentation parse-status))
           node)
 
      (save-excursion
 
        (back-to-indentation)
        ;; consecutive declarations in a var statement are nice if
        ;; properly aligned, i.e:
        ;;
        ;; var foo = "bar",
        ;;     bar = "foo";
        (setq node (js2-node-at-point))
        (when (and node
                   (= js2-NAME (js2-node-type node))
                   (= js2-VAR (js2-node-type (js2-node-parent node))))
          (setq indentation ( 4 indentation))))
 
      (indent-line-to indentation)
      (when (> offset 0) (forward-char offset)))))
 
(defun my-indent-sexp ()
  (interactive)
  (save-restriction
    (save-excursion
      (widen)
      (let* ((inhibit-point-motion-hooks t)
             (parse-status (syntax-ppss (point)))
             (beg (nth 1 parse-status))
             (end-marker (make-marker))
             (end (progn (goto-char beg) (forward-list) (point)))
             (ovl (make-overlay beg end)))
        (set-marker end-marker end)
        (overlay-put ovl 'face 'highlight)
        (goto-char beg)
        (while (< (point) (marker-position end-marker))
          ;; don't reindent blank lines so we don't set the "buffer
          ;; modified" property for nothing
          (beginning-of-line)
          (unless (looking-at "\\s-*$")
            (indent-according-to-mode))
          (forward-line))
        (run-with-timer 0.5 nil '(lambda(ovl)
                                   (delete-overlay ovl)) ovl)))))
 
(defun my-js2-mode-hook ()
  (require 'js)
  (setq js-indent-level 2
        indent-tabs-mode nil
        c-basic-offset 2)
  (c-toggle-auto-state 0)
  (c-toggle-hungry-state 1)
  (set (make-local-variable 'indent-line-function) 'my-js2-indent-function)
  (define-key js2-mode-map [(meta control |)] 'cperl-lineup)
  (define-key js2-mode-map [(meta control \;)] 
    '(lambda()
       (interactive)
       (insert "/* -----[ ")
       (save-excursion
         (insert " ]----- */"))
       ))
  (define-key js2-mode-map [(return)] 'newline-and-indent)
  (define-key js2-mode-map [(backspace)] 'c-electric-backspace)
  (define-key js2-mode-map [(control d)] 'c-electric-delete-forward)
  (define-key js2-mode-map [(control meta q)] 'my-indent-sexp)
  (if (featurep 'js2-highlight-vars)
    (js2-highlight-vars-mode))
  (message "My JS2 hook"))
 
(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(custom-set-variables  
 '(js2-basic-offset 4)  
 '(js2-bounce-indent-p t)  
)

;; whitespace
(setq whitespace-style
      '(face tabs spaces trailing lines space-before-tab
             newline indentation space-after-tab tab-mark newline-mark)
      whitespace-display-mappings
      '((space-mark   ?\    [?\xB7]     [?.])     ; space
        (space-mark   ?\xA0 [?\xA4]     [?_])     ; hard space
        (newline-mark ?\n   [?\xAB ?\n] [?$ ?\n]) ; end-of-line
        ))

;; ack
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; ag (the silver searcher)
(require 'ag)
(setq ag-highlight-search t)

;; websites
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-engines-alist '(("django" . "\\.html\\'")))

;; dired
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)

;; ido-mode
(ido-mode t)
(ido-ubiquitous-mode t)
(flx-ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-use-faces nil                ; don't use faces because we have flx
      ido-use-filename-at-point nil
      ido-max-prospects 10
      ido-ignore-buffers
      '("\\` " "^\\*ESS\\*" "^\\*Messages\\*" "^\\*Help\\*" "^\\*Buffer"
        "^\\*.*Completions\\*$" "^\\*Ediff" "^\\*tramp" "^\\*cvs-"
        "_region_" " output\\*$" "^TAGS$" "^\*Ido")
      ido-ignore-directories
      '("\\`auto/" "\\`auto-save-list/" "\\`backups/" "\\`semanticdb/"
        "\\`target/" "\\`\\.git/" "\\`\\.svn/" "\\`CVS/" "\\`\\.\\./"
        "\\`\\./")
      ido-ignore-files
      '("\\`auto/" "\\.prv/" "_region_" "\\.class/"  "\\`CVS/" "\\`#"
        "\\`.#" "\\`\\.\\./" "\\`\\./" "\\.hi$" "\\.org_archive$"))

; auto-fill
(add-hook 'html-mode-hook 'turn-off-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'clojure-mode-hook 'my-auto-fill-prog)

;; flyspell
(add-hook 'clojure-mode-hook 'flyspell-prog-mode)
(add-hook 'haskell-mode-hook 'flyspell-prog-mode)
(add-hook 'python-mode-hook 'flyspell-prog-mode)
(add-hook 'git-commit-mode-hook 'turn-on-flyspell)
(setq flyspell-issue-message-flag nil)             ; don't show a message, slows things down.

;; PO
(setq auto-mode-alist
      (cons '("\\.po\\'\\|\\.po\\." . po-mode) auto-mode-alist))
(autoload 'po-mode "po-mode" "Major mode for translators to edit PO files" t)

;; markdown
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.page" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook 'turn-on-pandoc)

;; edit rest documentation
(add-to-list 'auto-mode-alist '("\\.http$" . restclient-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; window movement
(setq windmove-wrap-around t)

;; nice visualation of undo's
(global-undo-tree-mode t)

;; jump to the last place you were in the file
(require 'saveplace)
(setq save-place-file "~/.emacs.d/saved-places")
(setq-default save-place t)

;; smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(sp-use-paredit-bindings)
;;(sp-local-pair 'web-mode "{%" "%}")
;;(sp-local-pair 'web-mode "{{" "}}")
(sp-local-pair 'web-mode "{" nil :actions nil)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)
(smartparens-global-mode t)

;; cleanup modeline
(diminish 'projectile-mode)
(diminish 'auto-complete-mode)
(diminish 'undo-tree-mode)

(provide 'pinda-modes)
