(defmacro hook-add-or-update (hook fname &rest body)
  `(progn
     (if (fboundp ',fname)
	 (progn 
	   (message "defined fname of %s" ',fname)
	   (remove-hook ,hook ',fname))
       (message "not found fname of %s" ',fname))
     (defun ,fname ()
       ,@body)
     (add-hook ,hook ',fname)))

(hook-add-or-update
 'shell-mode-hook fourth-shell-hook
 (message "macro fourth rev 2"))
