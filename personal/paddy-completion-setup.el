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




(defun prot-simple-buffers-major-mode ()
  "Select BUFFER matching the current one's major mode."
  (interactive)
  (if (and (minibufferp) (eq current-minibuffer-command 'prot-simple-buffers-major-mode))
      (progn
	(message "about to call unwind-protect")

	(unwind-protect
            (minibuffer-quit-recursive-edit)
	  (progn (message "unwind protect protect block is in minibufferp %S" (minibufferp)  )
		 ;; This is a hack.  but while unwind-protect runs, we are still in the minibuffer
		 (run-at-time nil nil
			      (lambda () (progn
					  (message "runtime lambda minibufferp %S" (minibufferp))
					  (call-interactively 'switch-to-buffer)))))))
    (switch-to-buffer (prot-simple--buffer-major-mode-prompt))
))


(defun paddy-buffer-project ()
  (interactive)
  (switch-to-buffer (paddy-simple--buffer-project-git-prompt)))
					; Now lets add find buffer in project So "s-b" open buffers completing on smae major mode, "s-p" buffers in project, or "s-b" all buffers


;; This is tyring to setup s-b as the key binding to bring up completions in the current major-mode
;; pressing "s-b"  will try to bring up completion for all major modes

(define-key global-map (kbd "s-b") #'prot-simple-buffers-major-mode)
(define-key global-map (kbd "s-p") #'paddy-buffer-project)

(use-package consult
  :ensure t
  :bind (("M-s M-g" . consult-grep)
         ("M-s M-s" . consult-outline))
  :config
  (setq grep-find-ignored-directories
	'(
	  ;"SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git"
	  ".hg" ".bzr" "_MTN"
		  ;; ".pytest_cache" ; python projects I have never wanted to search it
		  ;; ".mypy_cache"  ; never want to search
		  ;; "node_modules" ; js projects - sometimes want to search
		  ;; ".next" ; generated next.  Never have wanted to search, only would to debug something funky
		  ;; "buckaroo/static"
		 ))
  (setq grep-find-ignored-files
	'(".#*" "*.o" "*~" 
;; "*.bin" "*.lbin" "*.so" "*.a" "*.ln" "*.blg" "*.bbl"
;; 	  "*.elc" "*.lof" "*.glo" "*.idx" "*.lot" "*.fmt" "*.tfm" "*.class"
;; 	  "*.fas" "*.lib" "*.mem" "*.x86f" "*.sparcf" "*.dfsl" "*.pfsl"
;; 	  "*.d64fsl" "*.p64fsl" "*.lx64fsl" "*.lx32fsl" "*.dx64fsl" "*.dx32fsl"
;; 	  "*.fx64fsl" "*.fx32fsl" "*.sx64fsl" "*.sx32fsl" "*.wx64fsl"
;; 	  "*.wx32fsl" "*.fasl" "*.ufsl" "*.fsl" "*.dxl" "*.lo" "*.la" "*.gmo"
;; 	  "*.mo" "*.toc" "*.aux" "*.cp" "*.fn" "*.ky" "*.pg" "*.tp" "*.vr"
;; 	  "*.cps" "*.fns" "*.kys" "*.pgs" "*.tps" "*.vrs" "*.pyc" "*.pyo"
;; 	  "widget.js"
;; 	  "embed-bundle.js" "embed-bundle.js.map"
	  "*.ipynb" ; I would only want to search the code of these
		    ; files, almost never the output. The code output
		    ; can be huge. whole file is stored as JSON. It
		    ; would be cool to have special grep command
		    ; linked with JQ for these files, but very
		    ; specialized, late stage feature
	  )))



;; (defun my-consult-grep-alt ()
;;   (interactive)


;;   (let ((grep-find-ignored-directories
;;         '("SCCS" "RCS" "CVS" "MCVS" ".src" ".svn" ".git" ".hg" ".bzr" "_MTN"
;;           "_darcs" "{arch}" ".repo" ".jj" "node_modules" "alt")))
;;     (call-interactively 'consult-grep))
;; ) 

;;   (setq grep-find-ignored-files
;;         (cons ".#*" (delq nil (mapcar (lambda (s)
;; 				                        (unless (string-match-p "/\\'" s)
;; 				                          (concat "*" s)))
;; 				                      (append (list "test1" "test2")
;;                                                completion-ignored-extensions))))) 


(use-package orderless)
(setq completion-styles '(basic substring initials flex orderless))
(setq read-buffer-completion-ignore-case t)
(setq completion-ignore-case t)
(setq-default case-fold-search t)   ; For general regexp
(setq read-file-name-completion-ignore-case t) 


;; Needed for correct exporting while using Embark with Consult
;; commands.
(use-package embark
    :ensure t
    :bind
    ( :map minibuffer-local-map
      ("C-c C-c" . embark-collect) ;; send minibuffer contents to another buffer
      ("C-c C-e" . embark-export)))

  ;; Needed for correct exporting while using Embark with Consult
  ;; commands.
  (use-package embark-consult
    :ensure t
    :after (embark consult))


(use-package embark-consult
  :ensure t
  :after (embark consult))

(use-package company
  :ensure t
  :bind
  ( :map global-map
    ("M-'" . company-complete))

  :config

  (setq company-idle-delay nil)
  (setq company-backends `(company-capf))
  ;; (setq company-backends
  ;;       '(company-capf
  ;;         company-files
  ;;         (company-dabbrev-code company-gtags company-etags company-keywords)
  ;;         company-dabbrev))



  (global-company-mode 1))

(setq xref-show-definitions-function #'xref-show-definitions-completing-read)
(setq xref-prompt-for-identifier t)
(provide 'paddy-completion-setup)


