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

;;; last prot version
(defun prot-simple-buffers-major-mode ()
  "Select BUFFER matching the current one's major mode."
  (interactive)
  (if (and (minibufferp) (eq current-minibuffer-command 'prot-simple-buffers-major-mode))
      (condition-case nil
          (minibuffer-quit-recursive-edit)
        ((minibuffer-quit quit)
         (call-interactively 'switch-to-buffer)))
    (switch-to-buffer (prot-simple--buffer-major-mode-prompt))))


(defun prot-simple-buffers-major-mode ()
  "Select BUFFER matching the current one's major mode."
  (interactive)
  (if (and (minibufferp) (eq current-minibuffer-command 'prot-simple-buffers-major-mode))
      (progn
	(message "about to call unwind-protect")
	(unwind-protect
            (abort-minibuffers)
            ;(minibuffer-quit-recursive-edit)
	  (progn (message "unwind protect protect block")
		 (run-at-time nil nil
			      (lambda () (progn
					  (message "runtime lambda")
					  (call-interactively 'switch-to-buffer)))))))
    (switch-to-buffer (prot-simple--buffer-major-mode-prompt))
))



;; This is tyring to setup s-b as the key binding to bring up completions in the current major-mode
;; pressing "s-b"  will try to bring up completion for all major modes

(define-key global-map (kbd "s-b") #'prot-simple-buffers-major-mode)


(provide 'paddy-completion-setup)
