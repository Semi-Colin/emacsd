;; Early optimizations (stolen from Doom)

;(defvar last-file-name-handler-alist file-name-handler-alist)
(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)

;; after startup, it is important you reset this to some reasonable default. A large 
;; gc-cons-threshold will cause freezing and stuttering during long-term 
;; interactive use. I find these are nice defaults:
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold 16777216 ; 16mb
          gc-cons-percentage 0.1)))

(setq package-enable-at-startup nil ; don't auto-initialize!
      ;; this tells package.el not to add those pesky customized variable settings
      ;; at the end of your init.el
      package--init-file-ensured t)

;; Configure Straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Packages
(straight-use-package 'use-package)
(straight-use-package 'dracula-theme)
;(straight-use-package 'projectile)
(straight-use-package 'org   ; org mode is neat
		      ) 
(straight-use-package 'org-bullets)
(straight-use-package 'org-journal) 
(straight-use-package 'org-noter)
(require 'org-tempo)
(straight-use-package 'helm-org-rifle)
(straight-use-package 'org-roam)
(use-package org-recur
  :straight t
  :defer f
  :hook ((org-mode . org-recur-mode)
	 (org-agenda-mode . org-recur-agenda-mode))
  :config
  (setq org-recur-finish-done t

	org-recur-finish-archive t))

(straight-use-package 'go-mode) ; programming modes
(straight-use-package 'rust-mode)
(straight-use-package 'haskell-mode)
(straight-use-package 'gdscript-mode)
(straight-use-package 'page-break-lines) ; dashboard and dependencies
(straight-use-package 'all-the-icons)
(straight-use-package 'dashboard)
(straight-use-package 'aggressive-indent) ; editing
(straight-use-package 'modalka)
(straight-use-package 'general)
(straight-use-package 'posframe)
(straight-use-package 'hydra)
(straight-use-package 'major-mode-hydra)
(straight-use-package 'pretty-hydra)
(straight-use-package 'telephone-line)
(straight-use-package 'easy-kill)
;(straight-use-package 'evil)
(straight-use-package 'ido-vertical-mode)
(straight-use-package 'smex)
(straight-use-package 'visual-fill-column)
					;(add-hook 'emacs-startup-hook
(use-package company
  :straight t
  :defer t
  :config
  (add-to-list 'company-backends 'company-capf)
  :init
  (global-company-mode)
  (setq company-dabbrev-downcase 0)
  )
(straight-use-package 'company-go)
(straight-use-package 'lsp-mode)
(straight-use-package 'flycheck)
(straight-use-package 'deft)
					;(straight-use-package 'esup)
(straight-use-package 'gcmh) ; misc

;; Aesthetics
(setq linum-delay t)
(menu-bar--display-line-numbers-mode-relative)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(load-theme 'dracula t)
(set-frame-font "iosevka 15" nil)

(telephone-line-mode 1)

 ; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-conservatively 10000)

(setq auto-save-interval 250)

; set up my custom dashboard
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title "Semimacs")
(setq dashboard-startup-banner 'logo)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons nil)
(setq dashboard-footer-messages '("Yeah, I look like I know what I'm doing."))
(setq dashboard-center-content t)
(setq dashboard-footer-icon (all-the-icons-octicon "clock"
						   :height 1.1
						   :v-adjust -0.05
						   :face 'font-lock-keyword-face))
(dashboard-modify-heading-icons '((recents . "file-directory")
				  (agenda . "check")
	                          (bookmarks . "search")))
(setq show-week-agenda-p t)

;; Custom Functions
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun open-next-line ()
  "Insert a new line and go to it."
  (interactive)
  (end-of-line 1)
  (open-line 1)
  (next-line 1))

(defun open-prev-line ()
  "Insert a new line behind and go to it."
  (interactive)
  (previous-line 1)
  (end-of-line 1)
  (open-line 1)
  (next-line 1))

(defun delete-line ()
  "Delete the entire line, regardless of cursor position."
  (interactive)
  (beginning-of-line 1)
  (kill-line 1)
  )

(defun change-line ()
  "Delete the line and go in to insert mode."
  (interactive)
  (beginning-of-line 1)
  (kill-line 1)
  (modalka-mode 0)
  )

(defalias 'w 'save-buffer)
(defalias 'q 'delete-window)
(defalias 'qa 'save-buffers-kill-terminal)
(defalias 'e 'find-file)

;; Keys
(modalka-global-mode 1) ; enable modalka everywhere
(setq-default cursor-type '(bar . 1))
(setq modalka-cursor-type 'box)
(global-set-key (kbd "<escape>") 'modalka-mode) ; toggle insert and normal mode

					; map numbers to universal
(modalka-define-kbd "1" "C-1")
(modalka-define-kbd "2" "C-2")
(modalka-define-kbd "3" "C-3")
(modalka-define-kbd "4" "C-4")
(modalka-define-kbd "5" "C-5")
(modalka-define-kbd "6" "C-6")
(modalka-define-kbd "7" "C-7")
(modalka-define-kbd "8" "C-8")
(modalka-define-kbd "9" "C-9")
(modalka-define-kbd "0" "C-0")

(modalka-define-kbd "v" "C-SPC") ; mark
(modalka-define-kbd "q" "C-/") ; undo
(modalka-define-kbd "w" "M-w") ; copy
(modalka-define-kbd "e" "C-y") ; paste
(modalka-define-kbd "W" "C-w") ; cut
(modalka-define-kbd "E" "M-y") ; weird paste

(define-key modalka-mode-map (kbd "x") #'delete-char) ; delete-character
(define-key modalka-mode-map (kbd "r") #'open-next-line)
(define-key modalka-mode-map (kbd "R") #'open-prev-line)

(define-key modalka-mode-map (kbd "d d") #'delete-line)
(define-key modalka-mode-map (kbd "d l") #'delete-line)
(define-key modalka-mode-map (kbd "d w") #'kill-word)

(define-key modalka-mode-map (kbd "c c") #'change-line)

(modalka-define-kbd ":" "M-x")

(modalka-define-kbd "i" "C-p") ; up char
(modalka-define-kbd "k" "C-n") ; down char
(modalka-define-kbd "j" "C-b") ; left char
(modalka-define-kbd "l" "C-f") ; right char
(modalka-define-kbd "u" "M-b") ; left word
(modalka-define-kbd "o" "M-f") ; right word

(define-key modalka-mode-map (kbd "M-i") #'move-line-up)
(define-key modalka-mode-map (kbd "M-k") #'move-line-down)

(define-key modalka-mode-map (kbd "V") #'easy-mark)

(modalka-define-kbd "h" "C-a") ; beginning of line
(modalka-define-kbd ";" "C-e") ; end of line
(modalka-define-kbd "g" "C-g") ; cancel

;; (global-set-key (kbd "M-i") 'previous-line)
;; (global-set-key (kbd "M-j") 'backward-char)
;; (global-set-key (kbd "M-k") 'next-line)
;; (global-set-key (kbd "M-l") 'forward-char)
;; (global-set-key (kbd "M-u") 'backward-word)
;; (global-set-key (kbd "M-o") 'forward-word)
;; (global-set-key (kbd "M-h") 'beginning-of-line)
;; (global-set-key (kbd "M-;") 'end-of-line)
;; (global-set-key (kbd "M-a") 'execute-extended-command)

(define-key modalka-mode-map (kbd "RET") #'major-mode-hydra)

(major-mode-hydra-define emacs-lisp-mode
  (:color blue)
  ("Eval"
   (("b" eval-buffer "buffer")
    ("e" eval-defun "defun")
    ("r" eval-region "region"))
   "REPL"
   (("I" ielm "ielm"))
   "Test"
   (("t" ert "prompt")
    ("T" (ert t) "all")
    ("F" (ert :failed) "failed"))
   "Doc"
   (("d" describe-foo-at-point "thing-at-pt")
    ("f" describe-function "function")
    ("v" describe-variable "variable")
    ("i" info-lookup-symbol "info lookup"))))

(major-mode-hydra-define org-mode
  (:color blue)
  ("Task"
   (("t" org-todo "todo")
    ("s" org-schedule "schedule")
    ("d" org-deadline "deadline")
    )
   ))

(define-key modalka-mode-map (kbd "SPC") #'omni-leader/body)

(pretty-hydra-define omni-leader
  (:color blue :quit-key "q")
  ("org"
   (("o a" org-agenda "agenda")
    ("o r" helm-org-rifle "rifle")
    ("o j" org-journal-new-entry "journal entry"))
   "file"
   (("f f" find-file "open")
    ("f s" save-buffer "save")
    ("f b" switch-to-buffer "switch buffer"))
   ))
;; (general-create-definer my-leader-def
;;   :keymaps 'modalka-mode-map
;;   :prefix "SPC"
;;   )

;; (my-leader-def
;;   :keymaps 'modalka-mode-map
;;   "f f" 'find-file
;;   "f b" 'switch-to-buffer
;;   "o a" 'org-agenda
;;   "o c" 'org-capture
;;   "o j" 'org-journal-new-entry
;;   )

;; General Editing
(electric-pair-mode)
(aggressive-indent-global-mode)
	  
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; IDEmacs
(add-hook 'after-init-hook #'global-company-mode)
(add-hook 'after-init-hook (setq company-dabbrev-downcase 0))

(global-flycheck-mode)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(ido-vertical-mode 1)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Programming

;; Golang
(add-hook 'go-mode-hook #'linum-mode)
(add-hook 'go-mode-hook #'lsp)

;; Rust
(add-hook 'rust-mode-hook #'line-number-mode)

;; Elisp
(add-hook 'lisp-mode-hook #'line-number-mode)

;; Org
(add-hook 'org-mode-hook #'org-bullets-mode)
(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'text-mode-hook #'visual-fill-column-mode)
(add-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'org-mode-hook 'org-agenda-file-to-front)
(add-hook 'text-mode-hook (lambda ()
			    (progn
			      (setq left-margin-width 4)
			      (setq right-margin-width 4)
			      (set-window-buffer nil (current-buffer))))
	  )
					;(add-hook 'after-init-hook #'(define-key org-recur-mode-map (kbd "C-c d") 'org-recur-finish))
					;(define-key org-recur-agenda-mode-map (kbd "d") 'org-recur-finish)

(setq org-deadline-warning-days 7)

(setq org-agenda-sorting-strategy
      (quote
       ((agenda deadline-up priority-down)
	(todo priority-down category-keep)
	(tags priority-down category-keep)
	(search category-keep))))


(setq org-journal-dir "~/org/journal")

(setq org-recur-finish-done t
      org-recur-finish-archive t)

(defun org-agenda-refresh ()
  "Refresh all `org-agenda' buffers."
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (when (derived-mode-p 'org-agenda-mode)
        (org-agenda-maybe-redo)))))

(defadvice org-schedule (after refresh-agenda activate)
  "Refresh `org-agenda'."
  (org-agenda-refresh))

;; Org Class Notes

(defun org-new-class-note ()
  "Make a new note file for a given class."
  (interactive)
  (setq class (ido-completing-read "Class: " org-classes-list))
  (setq class (replace-in-string " " "_" select))
  (setq class-dir (concat org-classes-dir class "/"))
  (setq notes (cl-delete-if (lambda (k) (string-match-p "^." k)) (directory-files class-dir)))
  (setq notes (mapcar 'file-name-base notes))
  (setq title
	(completing-read "Note: "
			 notes
			 ))
  (setq title (file-name-base title))
  (setq file-name (concat title ".org"))
  (setq path
	(concat class-dir file-name
		))
  (if (file-exists-p path)
      (find-file path)
    (find-file path)
    (insert (concat "#+TITLE:" title "?\n#+DATE:" (format-time-string "%m-d-%Y")))
    ;; (insert "?\n") ; newline
    ;; (insert "#+DATE:")
    ;; (insert (format-time-string "%m-%d-%Y"))
    )
  )

(defun capitalize-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string nil 1))
          (rest-str   (substring string 1)))
      (concat (capitalize first-char) rest-str))))

(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

(setq org-classes-list (list "bell prep" "computer architecture"))
(setq org-classes-dir "/home/semi/school/")
(global-set-key (kbd "C-c n") 'org-new-class-note)

;; Rebind the 'd' key in org-agenda (default: `org-agenda-day-view').
					;(define-key org-recur-agenda-mode-map (kbd "d") 'org-recur-finish)
;(add-hook 'after-init-hook #'(define-key org-recur-agenda-mode-map (kbd "C-c d") 'org-recur-finish))

;(define-key org-recur-agenda-mode-map (kbd "C-c d") 'org-recur-finish)

;; Custom Variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("2d035eb93f92384d11f18ed00930e5cc9964281915689fa035719cab71766a15" "dcdd1471fde79899ae47152d090e3551b889edf4b46f00df36d653adc2bf550d" default))
 '(org-agenda-files
   '("~/org/school/meetings.org" "~/org/school/general/re-entry_plan.org" "~/org/school/meetings.org_archive" "~/org/journal/2020-07-06.org" "~/school/bell_prep/day_5/note-taking.org" "~/school/bell_prep/day_7/hughes-colin-ignatian-identity.org" "~/school/assignments.org" "~/school/assignments.org_archive" "~/org/journal/2020-07-13.org" "~/org/school/resource/re-entry_plan.org"))
 '(org-hidden-keywords '(author date email title))
 '(org-journal-dir "~/org/journal")
 '(org-journal-enable-agenda-integration t)
 '(org-journal-file-format "%Y-%m-%d.org")
 '(org-journal-file-type 'weekly)
 '(org-latex-compiler "xelatex"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
