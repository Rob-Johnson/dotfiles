(require 'package)

;; Don't display the 'Welcome to GNU Emacs' buffer on startup
(setq inhibit-startup-message t)

;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; Use 4 spaces
(setq default-tab-width 4)
(setq tab-width 4)


;; the packages that I use
(setq package-list '(evil ensime company zenburn-theme company-jedi py-yapf helm async idris-mode))

;; listthe repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
			 ("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa". "https://melpa.org/packages/")
			 ("melpa-stable". "https://stable.melpa.org/packages/")))

;; activate all the packages (in particular autoloads)
(package-initialize)

;; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
        (package-install package)))

;; hide the menu bar
(menu-bar-mode -1)

;; turn evil mode on
; tab functionality back from evil in org-mode
; https://stackoverflow.com/questions/22878668/emacs-org-mode-evil-mode-tab-key-not-working
(setq evil-want-C-i-jump nil)
(require 'evil)
(evil-mode 1)

;; always have company mode on
(global-company-mode 1)

; turn helm on
(require 'helm-config)
(helm-mode 1)


;; notmuch
(require 'notmuch)
(setq send-mail-function (quote sendmail-send-it))
(setq mail-specify-envelope-from t
      message-sendmail-envelope-from 'header
      mail-envelope-from 'header)
; sign messages by default
(add-hook 'message-setup-hook 'mml-secure-message-sign-pgpmime)
(setq mm-text-html-renderer 'lynx)

;; org mode
;; load todo when we open emacs
(find-file "~/workspace/gtd/todo.org")
;; (setq org-default-notes-file "~/workspace/yelp/todo.org")

;; Capture mode shortcut
(define-key global-map "\C-cc" 'org-capture)
(setq org-directory "~/workspace/gtd")
(setq org-mobile-inbox-for-pull "~/workspace/gtd/todo.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-capture-templates
	'(("p" "PAASTA" entry (file+headline "~/workspace/yelp/todo.org" "PAASTA")
	   "* TODO %?\n  %i\n  %a")
	("P" "PAASTA DONE" entry (file+headline "~/workspace/yelp/todo.org" "PAASTA")
	   "* DONE %?\nCLOSED: %t\n%i")
	("o" "OPS TODO" entry (file+headline "~/workspace/yelp/todo.org" "OPS")
	   "* TODO %?\n  %i\n  %a")
	("O" "OPS DONE" entry (file+headline "~/workspace/yelp/todo.org" "OPS")
	   "* DONE %?\nCLOSED: %t\n%i")
	("t" "personal-todo" entry (file+headline "~/workspace/gtd/todo.org" "TASKS")
	   "* TODO  %^{Brief Description} %^g\n%?\nAdded: %U")
	("s" "someday" entry (file+headline "~/workspace/someday.org" "TASKS")
	   "* TODO %?\n  %i\n  %a")
	("r" "respond" entry (file+headline "~/workspace/gtd/todo.org")
	   "* NEXT Respond to %^{from} on %^g\n Scheduled: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
	("n" "note" entry (file+headline "~/workspace/gtd/todo.org")
	   "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)))

(setq org-agenda-custom-commands
	  '(("H" "Office and Home Lists"
		 ((agenda)
		  (tags-todo "HOME")
		  (tags-todo "WORK")
		  (tags-todo "NEWHOUSE")))))

;; agenda
(setq org-agenda-files '("~/workspace/yelp/todo.org" "~/workspace/gtd/todo.org" "~/workspace/gtd/someday.org"))
(global-set-key (kbd "C-c a") 'org-agenda)

;; always log the time when you finish a task
(setq org-log-done 'time)

;; themes init
(load-theme 'zenburn t)

;; open config file in a frame when starting emacs
(find-file "~/.emacs.d/init.el")

;; python
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook (lambda () (setq company-backends '(company-jedi))))

;; Attach an entire directory. Adapted from
;; http://www.emacswiki.org/emacs/MessageMode
(defun message-attach-all-files-from-folder(&optional dir-to-attach)
  "create the mml code to attach all files found in a given directory"
  (interactive)

  (if (eq dir-to-attach nil)
    (setq dir-to-attach (read-directory-name "Select a folder to attach: ")))

  (if (not (string-match "/$" dir-to-attach))
    (setq dir-to-attach (concat dir-to-attach "/")))

  (dolist (file (directory-files dir-to-attach))
    (when (and (not (string= "." file)) (not (string= ".." file)))
      (let (full-file-path mime-type)
        (setq full-file-path (concat dir-to-attach file))
        (if (file-readable-p full-file-path)
          (if (file-directory-p full-file-path)
            (message-attach-all-files-from-folder full-file-path)
            (setq mime-type (substring (shell-command-to-string (concat "file --mime-type --brief " (shell-quote-argument (expand-file-name full-file-path)))) 0 -1))
            (insert-string (concat "<#part type=\"" mime-type "\" filename=\"" full-file-path "\" disposition=attachment>\n"))))))))

(define-key mml-mode-map [menu-bar Attachments Attach\ Directory...]
    '("Attach Directory..." . message-attach-all-files-from-folder))

