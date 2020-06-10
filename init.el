;; Early Optimization
(setq gc-cons-threshold most-positive-fixnum)
(setq frame-inhibit-implied-resize t)
(advice-add #'x-apply-session-resources :override #'ignore)

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
(straight-use-package 'dracula-theme)
(straight-use-package 'org) ; org mode is neat
(straight-use-package 'org-bullets)
(straight-use-package 'go-mode) ; programming modes
(straight-use-package 'rust-mode)
(straight-use-package 'haskell-mode)
(straight-use-package 'page-break-lines) ; dashboard and dependencies
(straight-use-package 'projectile)
(straight-use-package 'all-the-icons)
(straight-use-package 'dashboard)
(straight-use-package 'aggressive-indent) ; editing
(straight-use-package 'modalka)
(straight-use-package 'telephone-line)
(straight-use-package 'easy-kill)

;; Aesthetics
(setq linum-delay t)

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(load-theme 'dracula t)
(set-frame-font "iosevka 14" nil)

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

(modalka-define-kbd "z" "C-SPC") ; mark
(modalka-define-kbd "q" "C-/") ; undo
(modalka-define-kbd "w" "M-w") ; copy
(modalka-define-kbd "e" "C-y") ; paste
(modalka-define-kbd "W" "C-w") ; cut
(modalka-define-kbd "E" "M-y") ; weird paste

(define-key modalka-mode-map (kbd "v") #'backward-delete-char)

(modalka-define-kbd "i" "C-p") ; up char
(modalka-define-kbd "k" "C-n") ; down char
(modalka-define-kbd "j" "C-b") ; left char
(modalka-define-kbd "l" "C-f") ; right char
(modalka-define-kbd "u" "M-b") ; left word
(modalka-define-kbd "o" "M-f") ; right word

(define-key modalka-mode-map (kbd "M-i") #'move-line-up)
(define-key modalka-mode-map (kbd "M-k") #'move-line-down)

(define-key modalka-mode-map (kbd "x") #'easy-mark)

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

;; General Editing
(electric-pair-mode)
(aggressive-indent-mode)
(add-hook 'org-mode-hook #'global-display-line-numbers-mode)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Programming

;; Golang

;; Rust

;; Elisp

;; Org
(add-hook 'org-mode-hook #'org-bullets-mode)
(add-hook 'org-mode-hook #'org-indent-mode)
(add-hook 'org-mode-hook #'visual-line-mode)

;; Custom Variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dcdd1471fde79899ae47152d090e3551b889edf4b46f00df36d653adc2bf550d" default))
 '(org-agenda-files '("~/org/personal/room.org"))
 '(org-hidden-keywords '(author date email title)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
