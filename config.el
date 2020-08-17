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
(eval-when-compile
(add-to-list 'load-path "~/.config/emacs/use-package")
(add-to-list 'load-path "~/.config/emacs/bind-key")
(require 'use-package))
(require 'bind-key)
(use-package doom-themes
:straight t
)
(load-theme 'doom-one t)
(use-package doom-modeline
:defer 1
:straight t
:config
(doom-modeline-mode 1)
)
(use-package dashboard
:straight t
:init
(use-package page-break-lines :straight t)
(use-package all-the-icons :straight t)
:config (dashboard-setup-startup-hook)
)
(setq dashboard-banner-logo-title "Semimacs")
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-init-info t)
(setq dashboard-footer-messages '("Yeah, I look like I know what I'm doing."))
(use-package org
:straight t
:defer t
:config
(use-package ox
:defer t
)
(setq org-hidden-keywords '(author date email title))
(use-package org-tempo)
(setq org-log-done 'time)
(use-package org-superstar
:straight t
:defer t
:config
(add-hook 'org-mode-hook #'org-superstar-mode)
)
(use-package toc-org
:defer t
:straight t
:config
(add-hook 'org-mode-hook 'toc-org-mode)
)
(setq org-capture-templates
'(
("c" "Inbox" entry (file+headline "~/org/inbox.org" "Inbox")
"* TODO %?\n  %i\n")
("h" "Homework" entry (file+headline "~/school/homework.org" "Homework")
"* TODO %?\nDEADLINE: %t")
("v" "Vocabulary" entry (file+headline "~/vocabulary.org" "Vocabulary")
"* %?\n** Definition")
))
(global-set-key (kbd "C-c x") 'org-capture)
)
(setq org-refile-targets '(("~/org/project.org" :maxlevel . 3)
("~/org/defer.org" :level . 1)
))
(use-package org-roam
:straight t
:defer t
:config
(setq org-roam-tag-sources '(prop))
(straight-use-package 'company-org-roam)
(setq org-roam-completion-system 'ivy)
)
(use-package writegood-mode
:straight t
:defer t
:config
(global-set-key (kbd "C-c g") 'writegood-mode)
)
(use-package centered-window
:straight t
:defer t
)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook (lambda () (setq cwm-center-window-width 140)))
(add-hook 'org-mode-hook 'centered-window-mode)
(use-package org-recur
:defer t
:straight t
)
(add-hook 'org-mode-hook #'org-indent-mode)
(use-package org-agenda :defer t
:bind
("C-c a" . org-agenda)
:config
(setq org-agenda-use-time-grid nil)
)
(use-package org-journal
:defer t
:straight t
:config
(setq org-journal-dir "~/org/journal")
(setq org-journal-file-format "%d-%m-%Y.org")
(setq org-journal-enable-agenda-integration t)
:bind ("C-c j" . org-journal-new-entry)
)
(use-package ivy :straight t
:config
(ivy-mode 1)
)
(show-paren-mode t)
(straight-use-package 'centaur-tabs)
(centaur-tabs-mode t)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-style "bar")
(straight-use-package 'flymake)
(use-package company
:straight t
:defer 5
:config
(global-company-mode)
(use-package company-go
:straight t
:defer t
)
)
(use-package eglot
:straight t
:defer t
)
(use-package elfeed
:straight t
:defer t
)
(setq elfeed-feeds
'(("https://xkcd.com/rss.xml" entertainment)
("https://www.distrotube.com/videos/index.xml" technology)
("https://lukesmith.xyz/rss.xml" technology)
("reddit.com/r/emacs/.rss" software)
))
(straight-use-package 'notmuch)
(defun reload-config ()
(interactive)
(quicktangle "~/.config/emacs/config.org" "~/.config/emacs/config.el")
(load-file "~/.config/emacs/config.el")
)
(defun open-next-line ()
(interactive)
(end-of-line)
(newline-and-indent)
)
(defun open-prev-line ()
(interactive)
(beginning-of-line)
(newline-and-indent)
(previous-line)
)
(defun delete-line ()
(interactive)
(beginning-of-line)
(kill-line)
)
(straight-use-package 'rust-mode
:defer t)
(straight-use-package 'go-mode
:defer t
)
(add-hook 'go-mode-hook 'eglot-ensure)
(straight-use-package 'haskell-mode)
(use-package aggressive-indent
:defer t
:straight t
:config
(global-aggressive-indent-mode 1)
)
(electric-pair-mode 1)
(use-package ace-jump-mode
:defer t
:straight t
)
(use-package yasnippet
:straight t
:defer 4
:config
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(use-package yasnippet-snippets
:straight t
))
(use-package hydra
:defer t
:straight t
)
(use-package ryo-modal
:straight t
:defer t
:commands ryo-modal-mode
:bind ("<escape>" . ryo-modal-mode)
:config
(ryo-modal-keys
(:norepeat t)
("i" previous-line)
("j" backward-char)
("k" next-line)
("l" forward-char)
("o" forward-word)
("u" backward-word)
("J" beginning-of-line)
("L" end-of-line)
("h" ace-jump-mode)
)
(ryo-modal-keys
(:norepeat t)
("g" keyboard-escape-quit)
)
(ryo-modal-keys
(:norepeat t)
("x" delete-char)
("r" open-next-line)
("R" open-prev-line)
("v" set-mark-command)
("q" undo)
("w" kill-ring-save)
("t" yank)
))
(defun change-word ()
(interactive)
(kill-word 1)
(ryo-modal-mode 0)
)
(defun backward-change-word ()
(interactive)
(backward-kill-word 1)
(ryo-modal-mode 0)
)
(defun change-line ()
(interactive)
(delete-line)
(ryo-modal-mode -1)
)
(ryo-modal-key
"d" :hydra
'(hydra-delete (:color blue)
"Delete..."
("o" kill-word "word forward")
("u" backward-kill-word "word backward")
("d" delete-line "line")
("r" kill-region "region")
))
(ryo-modal-key
"c" :hydra
'(hydra-change (:color blue)
"Change..."
("o" change-word "word forward")
("u" backward-change-word "word backward")
("c" change-line "line")
("r" kill-region "region")
))
(defhydra org-leader (:color blue)
"Org"
("a" org-agenda "Agenda")
("j" org-journal-new-entry "Journal")
("c" org-capture "Capture")
)
(defhydra roam-leader (:color blue)
"Roam"
("f" org-roam-find-file "Find File")
)
(defhydra file-leader (:color blue)
"File"
("f" find-file "Find File")
("s" save-buffer "Save")
("b" switch-to-buffer "Switch Buffer")
("d" dired "Dired")
)
(ryo-modal-key
"SPC" :hydra
'(hydra-leader (:color blue)
"Leader"
("o" org-leader/body "Org")
("r" roam-leader/body "Roam")
("f" file-leader/body "File")
("TAB" other-window "Switch window")
))
(straight-use-package 'major-mode-hydra)
(ryo-modal-set-key (kbd "RET") 'major-mode-hydra)
(major-mode-hydra-define emacs-lisp-mode nil
("Eval"
(("e b" eval-buffer "buffer")
("e d" eval-defun "defun")
("e r" eval-region "region"))
"REPL"
(("I" ielm "ielm"))
"Doc"
(("d d" describe-foo-at-point "thing-at-pt")
("d f" describe-function "function")
("d v" describe-variable "variable")
("d i" info-lookup-symbol "info lookup"))))
(major-mode-hydra-define org-mode (:color blue)
("tree"
(("a" org-archive-subtree "archive")
("t" org-todo "toggle todo")
("r" org-refile "refile")
)
"schedule"
(("s t" org-time-stamp "timestamp")
("s s" org-schedule "schedule")
("s d" org-deadline "deadline")
)
)
)
(add-hook 'text-mode-hook #'ryo-modal-mode)
(add-hook 'prog-mode-hook #'ryo-modal-mode)
(global-set-key (kbd "C-<escape>") 'keyboard-escape-quit)
(use-package which-key
:straight t
:config
(which-key-mode)
(setq which-key-idle-delay .5)
)
