;; load and fire
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)
(require 'sendmail)

;; hooks
(add-hook 'mu4e-compose-mode-hook
          (defun my-compose-stuff ()
            (set-fill-column 72)
            (flyspell-mode)))

;; my e-mail addresses
(setq mu4e-user-mail-address-list '("jsoejitno@gmail.com"
                                    "joeri@gibbon.co"
                                    "joeri@breadandpepper.com"))

;; reply attribution line
(setq message-citation-line-format "On %a, %b %d %Y, %N wrote:")
(setq message-citation-line-function 'message-insert-formatted-citation-line)

;; general settings
(setq mail-user-agent 'mu4e-user-agent                   ; mu4e as default mail agent
      mu4e-attachment-dir "~/Downloads"                  ; put attachements in download dir
      mu4e-get-mail-command "offlineimap"                ; fetch email with offlineimap
      mu4e-confirm-quit nil                              ; don't ask me to quit
      mu4e-headers-skip-duplicates t                     ; skip duplicate email, great for gmail
      mu4e-headers-date-format "%d %b, %Y at %H:%M"      ; date format
      mu4e-headers-leave-behavior 'apply                 ; apply all marks at quit
      mu4e-html2text-command "w3m -dump -T text/html"    ; html to text
      mu4e-compose-dont-reply-to-self t                  ; don't reply to myself
      mu4e-compose-complete-only-personal t              ; only personal messages get in the address book
      message-signature "Joeri Djojosoeparto"            ; signature
      message-kill-buffer-on-exit t                      ; don't keep message buffers around
      smtpmail-queue-mail nil                            ; start in non queue mode
)

;; maildir locations
(setq mu4e-maildir "/Volumes/Loempia/.mail"
      mu4e-sent-folder "/pinda/sent"
      mu4e-drafts-folder "/pinda/drafts"
      mu4e-trash-folder "/pinda/trash"
      mu4e-refile-folder "/pinda/archive"
      smtpmail-queue-dir   "/Volumes/Loempia/.mail/queue/cur")

;; sending mail
(setq message-send-mail-function 'smtpmail-send-it)

;; set the archive according to the mailbox
(setq mu4e-refile-folder
      (lambda (msg)
        (if msg
            (let ((account (nth 1 (split-string (mu4e-message-field msg :maildir) "/"))))
              (format "/%s/archive" account)))))

;; set the trash according to the mailbox
(setq mu4e-trash-folder
      (lambda (msg)
        (if msg
            (let ((account (nth 1 (split-string (mu4e-message-field msg :maildir) "/"))))
              (format "/%s/trash" account)))))

;; multiple accounts
(setq pinda-mu4e-account-alist
      '(("gibbon"
         (user-mail-address "joeri@gibbon.co")
         (mu4e-sent-folder "/gibbon/sent")
         (mu4e-drafts-folder "/gibbon/drafts")
         (message-signature "Gibbon \ngibbon.co | @pindasminda")
         (smtpmail-smtp-server "smtp.gmail.com")
         (smtpmail-smtp-user "joeri@gibbon.co"))
        ("pinda"
         (user-mail-address "jsoejitno@gmail.com")
         (mu4e-sent-folder "/pinda/sent")
         (mu4e-drafts-folder "/pinda/drafts")
         (message-signature "")
         (smtpmail-smtp-server "smtp.gmail.com")
         (smtpmail-smtp-user "jsoejitno@gmail.com"))
        ("bread-and-pepper"
         (user-mail-address "joeri@breadandpepper.com")
         (mu4e-sent-folder "/bread-and-pepper/sent")
         (mu4e-drafts-folder "/bread-and-pepper/drafts")
         (message-signature "Bread & Pepper \nT: +31 (0)623109701\nW: breadandpepper.com")
         (smtpmail-smtp-server "smtp.gmail.com")
         (smtpmail-smtp-user "joeri@breadandpepper.com"))))

(defun pinda-mu4e-set-account ()
  "Set the account for composing a message by looking at the maildir"
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-msg-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var)) pinda-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) pinda-mu4e-account-alist)
                             nil t nil nil (caar pinda-mu4e-account-alist))))
         (account-vars (cdr (assoc account pinda-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars))))
(add-hook 'mu4e-compose-pre-hook 'pinda-mu4e-set-account)

;; org-mode integration
;(setq mu4e-org-contacts-file "/home/wunki/org/contacts.org")
;(add-to-list 'mu4e-headers-actions
;             '("org-contact-add" . mu4e-action-add-org-contact) t)
;(add-to-list 'mu4e-view-actions
;             '("org-contact-add" . mu4e-action-add-org-contact) t)


;; headers in the overview
(setq mu4e-headers-fields
  '((:maildir       .  24)
    (:date          .  24)
    (:flags         .   6)
    (:from          .  24)
    (:subject       .  nil)))

;; bookmarks
(setq mu4e-bookmarks 
  '(("flag:unread"                       "All new messages"       ?u)
    ("maildir:/gibbon/inbox"             "Gibbon's inbox"         ?g)
    ("maildir:/pinda/inbox"              "Gmail inbox"            ?p)
    ("maildir:/bread-and-pepper/inbox"   "Bread & Pepper's inbox" ?b)
    ("date:today..now"                   "Today's messages"       ?t)
    ("flag:flagged"                      "Flagged messages"       ?f)))

;; shortcuts
(setq mu4e-maildir-shortcuts
       '(("/pinda/inbox"              . ?i)
         ("/bread-and-pepper/inbox"   . ?I)
         ("/gibbon/inbox"             . ?g)
         ("/gibbon/archive"           . ?G)
         ("/pinda/archive"            . ?a)
         ("/bread-and-pepper/archive" . ?A)
         ("/pinda/sent"               . ?s)
         ("/bread-and-pepper/sent"    . ?S)
         ("/pinda/trash"              . ?t)
         ("/bread-and-pepper/trash"   . ?T)))

(provide 'pinda-mu4e)
