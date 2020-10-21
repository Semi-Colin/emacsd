(load-file "~/.config/emacs/quicktangle.el")
(quicktangle "~/.config/emacs/config.org" "~/.config/emacs/config.el")
(load-file "~/.config/emacs/config.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" "57bd93e7dc5fbb5d8d27697185b753f8563fe0db5db245592bab55a8680fdd8c" default))
 '(org-agenda-files
   '("~/org/inbox.org" "~/school/homework.org" "/home/semi/org/journal/16-10-2020.org"))
 '(org-agenda-timegrid-use-ampm t)
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe ol-rmail ol-w3m))
 '(org-super-agenda-mode t)
 '(safe-local-variable-values
   '((org-roam-db-location . "./org-roam.db")
     (org-roam-directory . "."))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe ((t (:background "#282c34")))))
