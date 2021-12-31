;;(add-hook 'server-after-make-frame-hook #'efs/frame-start-hook)

(defun first-shell-hook ()
  (message "first shell hook " ))
(add-hook 'shell-mode-hook #'first-shell-hook)

(defun second-shell-hook ()
  (message "second shell hook"))
(add-hook 'shell-mode-hook #'second-shell-hook)
(remove-hook 'shell-mode-hook #'first-shell-hook)
(remove-hook 'shell-mode-hook #'second-shell-hook)
(defvar hook-var 5)
(boundp 'hook-var)
(boundp 'hook-boof)
(fboundp 'first-shell-hook)
(fboundp 'third-shell-hook)

(defmacro hook-add-or-update (hook fname &rest body)
  `(if (fboundp ',fname)
      (progn 
	(message "defined fname of %s" ',fname)
	(remove-hook ,hook ',fname))
    (message "not found fname of %s" ',fname)))

(hook-add-or-update 'shell-mode-hook first-shell-hook)
(macroexpand-1 '(hook-add-or-update 'shell-mode-hook first-shell-hook))

(hook-add-or-update 'shell-mode-hook third-shell-hook)

(defmacro 
