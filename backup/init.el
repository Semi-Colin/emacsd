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
; org mode is neat
(straight-use-package 'org)
(straight-use-package 'org-bullets)
; programming modes
(straight-use-package 'go-mode)
(straight-use-package 'rust-mode)
; dashboard and dependencies
(straight-use-package 'page-break-lines)
(straight-use-package 'projectile)
(straight-use-package 'all-the-icons)
(straight-use-package 'dashboard)

;; Aesthetics
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(load-theme 'dracula t)
(set-frame-font "iosevka 12" nil )

; set up my custom dashboard
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title "Semimacs")
(setq dashboard-startup-banner 'logo)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons nil)
(setq dashboard-footer-messages '("You're using THIS editor? You should be using Emacs- oh."))
(setq dashboard-center-content t)

;; General Editing
(electric-pair-mode)

;; Custom Variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("dcdd1471fde79899ae47152d090e3551b889edf4b46f00df36d653adc2bf550d" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
