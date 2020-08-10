(defun quicktangle (in out)
  "A quicker version of org-babel-load-file"
  (setq command (concat "quicktangle " in " " out))
  (shell-command command)
  (message "Quicktangle: tangling %s..." in)
  (message "Quicktangle: tangling %s... done" in)
  )

