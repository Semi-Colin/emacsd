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
(straight-use-package 'use-package)
(straight-use-package 'org)
(require 'org)
(require 'ox)
(setq org-hidden-keywords '(author date email title))
(setq org-log-done 'time)
(straight-use-package 'org-superstar)
(add-hook 'org-mode-hook #'org-superstar-mode)
(straight-use-package 'toc-org)
(add-hook 'org-mode-hook 'toc-org-mode)
(setq org-todo-keyword-faces
'(("TODO" . "yellow") ("DONE" . "dark gray")
))
(setq org-capture-templates
'(
("t" "Task" entry (file+headline "~/org/personal/tasks.org" "Tasks")
"* TODO %?\n  %i\n")
("h" "Homework" entry (file+headline "~/school/homework.org" "Homework")
"* TODO %?\nDEADLINE: %t")
))
(global-set-key (kbd "C-c x") 'org-capture)
(require 'org-tempo)
(straight-use-package 'org-roam)
(setq org-roam-tag-sources '(prop))
(straight-use-package 'company-org-roam)
(setq org-roam-completion-system 'ido)
(setq org-roam-capture-templates
'(("d" "default" plain (function org-roam--capture-get-point)
"%?"
:file-name "${slug}"
:head "#+title: ${title}
#+date:%u
#+roam_tags:
%i"
:unnarrowed t)
))
(straight-use-package 'writegood-mode)
(global-set-key (kbd "C-c g") 'writegood-mode)
(straight-use-package 'centered-window)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook (lambda () (setq cwm-center-window-width 140)))
(add-hook 'org-mode-hook 'centered-window-mode)
(straight-use-package 'org-recur)
(add-hook 'org-mode-hook #'org-indent-mode)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-use-time-grid nil)
(straight-use-package 'org-super-agenda)
(straight-use-package 'org-journal)
(setq org-journal-dir "~/org/journal")
(setq org-journal-file-format "%d-%m-%Y.org")
(setq org-journal-enable-agenda-integration t)
(global-set-key (kbd "C-c j") 'org-journal-new-entry)
(require 'org-journal)
(straight-use-package 'doom-themes)
(load-theme 'doom-one t)
(set-frame-font "Fira Code 14" nil t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(straight-use-package 'doom-modeline)
(doom-modeline-mode 1)
(straight-use-package 'page-break-lines)
(straight-use-package 'all-the-icons)
(straight-use-package 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title "Semimacs")
(setq dashboard-startup-banner 'logo)
(setq dashboard-center-content t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-init-info t)
(setq dashboard-footer-messages '("Yeah, I look like I know what I'm doing."))
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(straight-use-package 'ido-vertical-mode)
(ido-vertical-mode 1)
(straight-use-package 'smex)
(global-set-key (kbd "M-x") 'smex)
(show-paren-mode t)
(straight-use-package 'centaur-tabs)
(centaur-tabs-mode t)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-style "bar")
(straight-use-package 'flymake)
(straight-use-package 'company)
(add-hook 'after-init-hook 'global-company-mode)
(straight-use-package 'company-go)
(straight-use-package 'eglot)
(straight-use-package 'elfeed)
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
(straight-use-package 'aggressive-indent)
(global-aggressive-indent-mode 1)
(electric-pair-mode 1)
(straight-use-package 'ace-jump-mode)
(straight-use-package 'yasnippet)
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(straight-use-package 'yasnippet-snippets)
(straight-use-package 'hydra)
(use-package ryo-modal
:straight t
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
))
(add-hook 'text-mode-hook #'ryo-modal-mode)
(add-hook 'prog-mode-hook #'ryo-modal-mode)
(global-set-key (kbd "C-<escape>") 'keyboard-escape-quit)
(straight-use-package 'which-key)
(which-key-mode)
(setq which-key-idle-delay 1)
