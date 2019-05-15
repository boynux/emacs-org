;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(package-initialize)
(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))

(global-font-lock-mode 1)

(add-to-list 'load-path "~/.emacs.d/lisp/")
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

;; Auto complete
(require 'go-autocomplete)
(require 'auto-complete-config)

(ac-config-default)

(require 'auto-complete-config)

(ac-config-default)
(ido-mode)

;;;; twittering-mode
(setq twittering-icon-mode t)
(setq twittering-use-master-password t)

;;;; magit
(global-set-key (kbd "C-c gs") 'magit-status)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
(setq org-completion-use-ido t)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(global-set-key (kbd "C-c O")
		(lambda () (interactive) (find-file "~/org/gtd.org")))
(global-set-key (kbd "C-c o1")
		(lambda () (interactive) (find-file "~/org/1-1.org")))
(global-set-key (kbd "C-c c") 'org-capture)

(setq org-agenda-files (list "~/org/gtd.org"
			     "~/org/index.org"
			     "~/org/work.org"
			     "~/org/home.org"
			     "~/org/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
			       (file+headline "~/org/inbox.org" "Tasks")
			       "* TODO %i%?")
			      ("T" "Tickler" entry
			       (file+headline "~/org/tickler.org" "Tickler")
			       "* %i%? \n %U")
			      ("p" "Project" entry
			       (file "~/org/gtd.org")
			       "* %i%?")
			      ))

(setq org-refile-targets '(("~/org/gtd.org" :maxlevel . 3)
			   ("~/org/someday.org" :level . 1)
			   ("~/org/tickler.org" :maxlevel . 2)))

(setq org-agenda-custom-commands
      '(("W" "Weekly Review"
	 ((agenda "" ((org-agenda-span 7))); review upcoming deadlines and appointments
					; type "l" in the agenda to review logged items
	  (stuck "") ; review stuck projects as designated by org-stuck-projects
	  (todo "PROJECT") ; review all projects (assuming you use todo keywords to designate projects)
	  (todo "MAYBE") ; review someday/maybe items
	  (todo "WAITING"))) ; review waiting
	;; ...other commands here
       ))


(setq org-agenda-custom-commands
      '(("g" . "GTD contexts")
	("go" "Office" tags-todo "@office")
	("gc" "Computer" tags-todo "@computer")
	("gp" "Phone" tags-todo "@phone")
	("gh" "Home" tags-todo "@home")
	("ge" "Errands" tags-todo "errands")
	("G" "GTD Block Agenda"
	 ((tags-todo "@office")
	  (tags-todo "@computer")
	  (tags-todo "@phone")
	  (tags-todo "@home")
	  (tags-todo "@errands"))
	 nil                      ;; i.e., no local settings
	 ("~/next-actions.html")) ;; exports block to this file with C-c a e
        ("W" "Weekly Review"
	 ((agenda "" ((org-agenda-span 7))); review upcoming deadlines and appointments
					; type "l" in the agenda to review logged items
	  (stuck "") ; review stuck projects as designated by org-stuck-projects
	  (todo "PROJECT") ; review all projects (assuming you use todo keywords to designate projects)
	  (todo "MAYBE") ; review someday/maybe items
	  (todo "WAITING"))) ; review waiting
	
	;; ..other commands here
	))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
	(when (org-current-is-todo)
	  (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
	  (goto-char (point-max))))))

(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(setq org-log-done t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/org/inbox.org" "~/org/home.org" "~/org/someday.org" "~/org/tickler.org" "~/org/index.org" "~/org/gtd.org")))
 '(package-selected-packages
   (quote
    (magit twittering-mode yaml-mode markdown-mode expand-region python-mode go-mode auto-complete ## auto-correct))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
