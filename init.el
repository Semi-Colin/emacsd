					;(package-initialize)
(load-file "~/.config/emacs/quicktangle.el")
(quicktangle "~/.config/emacs/config.org" "~/.config/emacs/config.el")
(load-file "~/.config/emacs/config.el")
					;(org-babel-load-file "~/.config/emacs/config.org")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/org/personal/tasks.org" "~/org/personal/books.org" "~/school/homework.org")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
