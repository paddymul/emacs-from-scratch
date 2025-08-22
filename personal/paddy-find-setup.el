;;;  -*- lexical-binding: t -*-
(require 'consult)
(defvar paddy-find-script  "/Users/paddy/.emacs.d/personal/find_script.sh")
(defun my-parse-extensions (extensions)
  (format ".*\\.%s$" (regexp-opt extensions t)))

(defun my-parse-directories (directories)
  (format ".*\\.?%s.*" (regexp-opt directories t)))


(defun paddy-py-find-grep (root-directory search-term)
  (let* ((py-preferred-extensions (my-parse-extensions '("py")))
	 (py-secondary-directories (my-parse-directories '(".venv" "foo")))
	 (py-secondary-extensions  (my-parse-extensions '("js" "ts" "jsx" "tsx")))
	 (py-never-directories (my-parse-directories '(".ruff" ".git" "pycache" "dist")))
	 (py-never-extensions (my-parse-extensions '("pyc" ".d.ts"))))
					;    (format "%s"
;    (princ
     (format-spec "%a \"%b\" \"%c\" \"%d\" \"%e\" \"%f\" \"%g\" \"%h\" \"%i\" "
			`((?a . ,paddy-find-script)
			  (?b . ,root-directory)  ; search_root $1
			  (?c . ,search-term)     ; search_term $2
			  (?d . "") ; preferred_directories $3 - unused
			  (?e . ,py-preferred-extensions) ; preferred_extensions $4 - unused
			  (?f . ,py-secondary-directories) ; secondary_directories $5
			  (?g . ,py-secondary-extensions) ; secondary_extensions $6
			  (?h . ,py-never-directories) ; never_directories $7
			  (?i . ,py-never-extensions) ; never_extensions $8
			  ))
;	   )
    ))
(defun consult--grep-make-builder (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
        (if (or (member "-F" flags) (member "--fixed-strings" flags))
            (cons (append cmd (list "-e" arg) opts paths)
                  (apply-partially #'consult--highlight-regexps
                                   (list (regexp-quote arg)) ignore-case))
          (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
            (when re
              (cons (append cmd
                            (list (if (eq type 'pcre) "-P" "-E") ;; perl or extended
                                  "-e" (consult--join-regexps re type))
                            opts paths)
                    hl))))))))

;; works, accepts regexp and path
(defun paddy-consult-py-find-grep ()
  (interactive)
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
	 (unused (progn (message "cmd 33 %s" cmd)))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended))

)
    (message "cmd 37 %s" cmd)
    (lambda (input)
      (message "50 input %s" input)
      (message "cmd 40 %s" cmd)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons
				(paddy-py-find-grep-list (car paths)  (consult--join-regexps re type))
			       hl)))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep)))

;; works, accepts regexp and path
(defun paddy-consult-js-find-grep ()
  (interactive)
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
"Build grep command line and grep across PATHS."
(message "56 %s" (consult--build-args consult-grep-args))							
  (let* ((cmd (consult--build-args consult-grep-args))
	 (cmd5 (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 61 input %s" input)
      (message "60 cmd5 %s" cmd5)
      (message "60 cmd %s" cmd)

      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons
				(paddy-js-find-grep-list (car paths)  (consult--join-regexps re type))
			       hl)))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep)))






(defun paddy-py-find-grep-list (root-directory search-term)
  (let* ((py-preferred-extensions (my-parse-extensions '("py")))
	 (py-secondary-directories (my-parse-directories '(".venv" "foo")))
	 (py-secondary-extensions  (my-parse-extensions '("js" "ts" "jsx" "tsx")))
	 (py-never-directories (my-parse-directories '(".ruff" ".git" "pycache" "dist")))
	 (py-never-extensions (my-parse-extensions '("pyc" ".d.ts"))))
    (list paddy-find-script
	  root-directory  ; search_root $1
	  search-term     ; search_term $2
	  "" ; preferred_directories $3 - unused
	  py-preferred-extensions ; preferred_extensions $4 - unused
	  py-secondary-directories ; secondary_directories $5
	  py-secondary-extensions ; secondary_extensions $6
	  py-never-directories ; never_directories $7
	  py-never-extensions ; never_extensions $8
	  )))


(defun paddy-js-find-grep-list (root-directory search-term)
  (let* ((py-preferred-extensions (my-parse-extensions '("ts" "jsx" "tsx" )))
	 (py-secondary-directories (my-parse-directories '(".venv" "node_modules" )))
	 (py-secondary-extensions  (my-parse-extensions '("py" "json")))
	 (py-never-directories (my-parse-directories '(".ruff" ".git" "pycache" "dist" "pnpm")))
	 (py-never-extensions (my-parse-extensions '("pyc" ".d.ts"))))
    (list paddy-find-script
	  root-directory  ; search_root $1
	  search-term     ; search_term $2
	  "" ; preferred_directories $3 - unused
	  py-preferred-extensions ; preferred_extensions $4 - unused
	  py-secondary-directories ; secondary_directories $5
	  py-secondary-extensions ; secondary_extensions $6
	  py-never-directories ; never_directories $7
	  py-never-extensions ; never_extensions $8
	  )))


(defun paddy-shell-find-wrapper ()
  (interactive)
  (let ((current-directory default-directory))
    (message "%s  paddy-shell-find-wrapper" current-directory)
    (cond
     ((string-prefix-p "/Users/paddy/buckaroo/packages/buckaroo-js-core" current-directory)
      (message "%s  js-find-grep" current-directory)
      (call-interactively 'paddy-consult-js-find-grep))

     ((string-prefix-p "/Users/paddy/buckaroo" current-directory)
      (message "%s  py-find-grep" current-directory)
      (call-interactively 'paddy-consult-py-find-grep))
     (t
      (message "%s  default " current-directory)
      (call-interactively 'consult-grep)))))


(with-eval-after-load 'python
  (define-key python-ts-mode-map
	      (kbd "M-s M-g")
	      #'paddy-consult-py-find-grep))



(with-eval-after-load 'typescript-ts-mode
  (define-key typescript-ts-base-mode-map 
	      (kbd "M-s M-g")
	      'paddy-consult-js-find-grep))
(with-eval-after-load 'python
  (define-key python-mode-map (kbd "M-s M-s") #'recenter))

(with-eval-after-load 'shell-mode
  (define-key shell-mode-map  (kbd "M-s M-g") #'paddy-shell-find-wrapper))

(with-eval-after-load 'typescript-ts-mode
  (define-key typescript-ts-base-mode-map (kbd "M-s M-s") #'recenter)) 

 
(provide 'paddy-find-setup)
