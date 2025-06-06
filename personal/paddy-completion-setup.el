(use-package vertico
  :ensure t
  :config
  (vertico-mode 1))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package savehist
  :ensure nil
  :config
  (savehist-mode 1)) 


(defun prot-simple--buffer-major-mode-prompt ()
  "Prompt of `prot-simple-buffers-major-mode'.
Limit list of buffers to those matching the current
`major-mode' or its derivatives."
  (let ((read-buffer-function nil)
        (current-major-mode major-mode))
    (read-buffer
     (format "Buffer for %s: " major-mode)
     nil
     :require-match
     (lambda (pair) ; pair is (name-string . buffer-object)
       (with-current-buffer (cdr pair)
         (derived-mode-p current-major-mode))))))


(defun find-git-root-recursive (dir)
  (if (stringp dir)
      (if (equal dir "/")
	  nil
	(if (file-directory-p (concat dir "/.git"))
	    dir
	  ;; call this recursively on the parent directory name
	  (find-git-root-recursive (directory-file-name (file-name-directory dir)))))))

;; (find-git-root-recursive  nil)
;; (find-git-root-recursive  "/Users/paddy/fooasdf")
;; (find-git-root-recursive  "/Users/paddy/.emacs.d/personal") ; "/Users/paddy/.emacs.d"
;; (find-git-root-recursive  "/Users/paddy/.emacs.d/personal/asdf.sd") ; "/Users/paddy/.emacs.d"
;; (find-git-root-recursive  "/Users/paddy/buckaroo/buckaroo/dataflow/dataflow.py") ;"/Users/paddy/buckaroo/


(defun paddy-simple--buffer-project-git-prompt ()
  "Prompt of `prot-simple-buffers-major-mode'.
Limit list of buffers to those matching the current
`major-mode' or its derivatives."
  (let ((read-buffer-function nil)
        (current-git-root (find-git-root-recursive (buffer-file-name (current-buffer)))))
    
    (read-buffer
     (format "Buffer for project %s: " current-git-root)
     nil
     :require-match
     (lambda (pair) ; pair is (name-string . buffer-object)
       (progn
	 (message "cdr pair %S" (cdr pair))
	 (equal (find-git-root-recursive (buffer-file-name (cdr pair))) current-git-root))))))

(switch-to-buffer (paddy-simple--buffer-project-git-prompt))




(defun prot-simple-buffers-major-mode ()
  "Select BUFFER matching the current one's major mode."
  (interactive)
  (if (and (minibufferp) (eq current-minibuffer-command 'prot-simple-buffers-major-mode))
      (progn
	(message "about to call unwind-protect")

	(unwind-protect
            (minibuffer-quit-recursive-edit)
            ;(minibuffer-quit-recursive-edit)
	  (progn (message "unwind protect protect block is in minibufferp %S" (minibufferp)  )
		 ;; This is a hack.  but while unwind-protect runs, we are still in the minibuffer
		 (run-at-time nil nil
			      (lambda () (progn
					  (message "runtime lambda minibufferp %S" (minibufferp))
					  (call-interactively 'switch-to-buffer)))))))
    (switch-to-buffer (prot-simple--buffer-major-mode-prompt))
))

					; Now lets add find buffer in project So "s-b" open buffers completing on smae major mode, "s-p" buffers in project, or "s-b" all buffers


;; This is tyring to setup s-b as the key binding to bring up completions in the current major-mode
;; pressing "s-b"  will try to bring up completion for all major modes

(define-key global-map (kbd "s-b") #'prot-simple-buffers-major-mode)


(provide 'paddy-completion-setup)
