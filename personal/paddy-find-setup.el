


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


(defvar paddy-find-script  "/Users/paddy/.emacs.d/personal/find_script.sh")
(defun my-parse-extensions (extensions)
  (format ".*\\.%s$" (regexp-opt extensions t)))

(defun my-parse-directories (directories)
  (format ".*\\.%s.*" (regexp-opt directories t)))

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



;; works, accepts regexp and path
(defun paddy-consult-py-find-grep ()
  (interactive)
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
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



;; works, accepts regexp and path
(defun paddy-consult-py-find-grep ()
  (interactive)
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
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



;; works 
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons
				(paddy-py-find-grep-list "/Users/paddy/Buckaroo" "color_map")
			       hl)))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep))

;; works, accepts regexp
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons
				(paddy-py-find-grep-list "/Users/paddy/Buckaroo" (consult--join-regexps re type))
			       hl)))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep))


(princ (paddy-py-find-grep "/Users/paddy/Buckaroo" "color_map"))

;; works - with highlighting 
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons (append cmd
                        (list "-E" ;; perl or extended
                              "-e" (consult--join-regexps re type))
                        opts paths)
			       hl)))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep))
(paddy-py-find-grep "/Users/paddy/Buckaroo""color_map")

paddy-py-find-grep

;(paddy-py-find-grep "~/Buckaroo" "color_map")
;(shell-command (paddy-py-find-grep "/Users/paddy/Buckaroo" "color_map"))
;(shell-command "ls")

;;orig
(setq consult-grep-args
  '("grep" (consult--grep-exclude-args)
    "--null --line-buffered --color=never --ignore-case\
     --with-filename --line-number -I -r"))
(setq consult-grep-args
  '("our-find-command" (consult--grep-exclude-args)
    "--null --line-buffered --color=never --ignore-case\
     --with-filename --line-number -I -r"))

(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (if (or (member "-F" flags) (member "--fixed-strings" flags))
	    (progn
	      (message "57")
            (cons (append cmd (list "-e" arg) opts paths)
                  (apply-partially #'consult--highlight-regexps
                                   (list (regexp-quote arg)) ignore-case))
	  )
          (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
            (when re
              (cons (append cmd
                            (list (if (eq type 'pcre) "-P" "-E") ;; perl or extended
                                  "-e" (consult--join-regexps re type))
                            opts paths)
                    hl))))))))))
				  (call-interactively 'consult-grep))


(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
          (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
            (when re
              (cons (append cmd
                            (list (if (eq type 'pcre) "-P" "-E") ;; perl or extended
                                  "-e" (consult--join-regexps re type))
                            opts paths)
                    hl)))))))))
				  (call-interactively 'consult-grep))
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (message "103 type %s %s" type (eq type 'pcre))
            (when re
              (cons (append cmd
                            (list "-E" ;; perl or extended
                                  "-e" (consult--join-regexps re type))
                            opts paths)
                    hl)))))))))
				  (call-interactively 'consult-grep))

;; ??
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons (append cmd
                        (list "-E" ;; perl or extended
                              "-e" (consult--join-regexps re type))
                        opts paths)
			       (lambda (&rest args) (list ".*")))))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep))

final-command ((grep --exclude=.#* --exclude=*.o --exclude=*~ --exclude=*.ipynb --exclude-dir=.hg --exclude-dir=.bzr --exclude-dir=_MTN --null --line-buffered --color=never --ignore-case --with-filename --line-number -I -r -E -e setq .) . #[(&rest args) ((list .*)) (t)])


(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons 
;(paddy-py-find-grep "/Users/paddy/Buckaroo" "color_map")
(paddy-py-find-grep "/Users/paddy/Buckaroo""color_map")

			;; 	      append cmd
                        ;; (list "-E" ;; perl or extended
                        ;;       "-e" (consult--join-regexps re type))
                        ;; opts paths)

			       (lambda (&rest args) (list ".*")))))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep))



(defun consult--grep2 (prompt make-builder dir initial)
  "Run asynchronous grep.

MAKE-BUILDER is the function that returns the command line
builder function.  DIR is a directory or a list of file or
directories.  PROMPT is the prompt string.  INITIAL is initial
input."
  (pcase-let* ((`(,prompt ,paths ,dir) (consult--directory-prompt prompt dir))
               (default-directory dir)
               (builder  (let* ((normal-builder (funcall make-builder paths))
			       (our-builder (lambda (our-builder-arg-1)
					      (let
						  ((normal-builder-res (funcall normal-builder our-builder-arg-1)))
						(message "normal-builder-res %s" normal-builder-res)
						normal-builder-res))))
			   our-builder)))
    (consult--read
     (consult--process-collection builder
       ;:transform (consult--grep-format builder)
       :transform #'identity
       :file-handler t)
     :prompt prompt
     :lookup #'consult--lookup-member
     :state (consult--grep-state)
     :initial initial
     :add-history (thing-at-point 'symbol)
     :require-match t
     :category 'consult-grep
     :group #'consult--prefix-group
     :history '(:input consult--grep-history)
     :sort nil)))


(defun consult-grep2 (&optional dir initial)
  (interactive "P")
  (consult--grep2 "Grep" #'consult--grep-make-builder dir initial))

(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons (list "ls" )
			       hl)))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep2))


;; below doesn't work
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons (list "ls" )
			       hl)))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep))



;; below doesn't work
(cl-letf ((
       (symbol-function #'consult--grep-make-builder) (lambda (paths)
  "Build grep command line and grep across PATHS."
  (let* ((cmd (consult--build-args consult-grep-args))
         (type (if (consult--grep-lookahead-p (car cmd) "-P") 'pcre 'extended)))
    (lambda (input)
      (message "50 input %s" input)
      (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
                   (flags (append cmd opts))
                   (ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
	(message "54 arg %s flags %s" input flags)
        (pcase-let ((`(,re . ,hl) (consult--compile-regexp arg type ignore-case)))
	  (let (
		(final-command (cons (list "ls" )
			       hl)))
	  (message "final-command %s" final-command)
	  final-command
	  ))))))))
  (call-interactively 'consult-grep))




paddy-py-find-grep

(let ((builder
       (lambda (paths ) (progn (message "%s" paths)
			       (lambda (nested-arg)
				 (progn (message "nested-arg %s" nested-arg)
					'("ls")))))))
  (consult--grep "paddy-41" builder  "/Users/paddy/code" "4th"))

(defun paddy-py-find-grep (root-directory search-term)
  (let* ((py-preferred-extensions (my-parse-extensions '("py")))
	     (py-secondary-directories (my-parse-directories '(".venv" "foo")))
	     (py-secondary-extensions  (my-parse-extensions '("js" "ts" "jsx" "tsx")))
	     (py-never-directories (my-parse-directories '(".ruff" ".git" "pycache" "dist")))
	     (py-never-extensions (my-parse-extensions '("pyc" ".d.ts"))))
    (mapcar #'intern (split-string (format-spec "\"%a\" \"%b\" \"%c\" \"%d\" \"%e\" \"%f\" \"%g\" \"%h\" \"%i\" ||| "
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
                  "[\s\t]+"))))
(consult--grep "Test prompt"
               (lambda (paths)
                 (lambda (&rest _)
                   ;(paddy-py-find-grep "/Users/paddy/buckaroo" "color_map")
		   '(("ls" "/Users/paddy/buckaroo"))

))
               "/Users/paddy/buckaroo"
               "initial-text")

(consult--grep "Test prompt"
               (lambda (paths)
                 (lambda (input)
		   (pcase-let* ((`(,arg . ,opts) (consult--command-split input))
					;(flags (append cmd opts))
				(ignore-case (or (member "-i" flags) (member "--ignore-case" flags))))
			 (cons (append "ls" (list "-e" arg) opts paths)
			       (apply-partially #'consult--highlight-regexps
						(list (regexp-quote arg)) ignore-case)))))

               "/Users/paddy/buckaroo"
               "initial-text")



(defun my-find ()
  (interactive)
  (let ((consult-find-args (paddy-py-find-grep "/Users/paddy/Buckaroo" "color_map")))
    (call-interactively 'consult-find)))
paddy-py-find-grep

(consult--grep "paddy-41" (paddy-py-find-grep "/Users/paddy/Buckaroo" "color_map") nil nil)


normal-builder-res ((grep --exclude=.#* --exclude=*.o --exclude=*~ --exclude=*.ipynb --exclude-dir=.hg --exclude-dir=.bzr --exclude-dir=_MTN --null --line-buffered --color=never --ignore-case --with-filename --line-number -I -r -E -e never- .) . #[128 \302\301\303\300^D""\207 [((never-) (--ignore-case --with-filename --line-number -I -r)) consult--highlight-regexps apply append] 6 (subr.elc . 20470)]) [2 times]

"/Users/paddy/.emacs.d/personal/find_script.sh \"/Users/paddy/Buckaroo\" \"color_map\" \"\" \".*\\.\\(py\\)$\" \".*\\.\\(\\.venv\\|foo\\).*\" \".*\\.\\(jsx?\\|tsx?\\)$\" \".*\\.\\(\\.\\(?:git\\|ruff\\)\\|dist\\|pycache\\).*\" \".*\\.\\(\\.d\\.ts\\|pyc\\)$\" "


"/Users/paddy/.emacs.d/personal/find_script.sh \"/Users/paddy/Buckaroo\" \"color_map\" \"\" \".*\\.\\(py\\)$\" \".*\\.\\(\\.venv\\|foo\\).*\" \".*\\.\\(jsx?\\|tsx?\\)$\" \".*\\.\\(\\.\\(?:git\\|ruff\\)\\|dist\\|pycache\\).*\" \".*\\.\\(\\.d\\.ts\\|pyc\\)$\" ||| "







(defvar paddy-find-script  "/Users/paddy/.emacs.d/personal/find_script.sh")
(princ (format "%s \"%s\"  %s" paddy-find-script "/Users/paddy/buckaroo" "color_map"))


;/Users/paddy/.emacs.d/personal/find_script.sh "/Users/paddy/buckaroo"  color_map"/Users/paddy/.emacs.d/personal/find_script.sh \"/Users/paddy/buckaroo\"  color_map"






(my-parse-directories '("node_modules" "dist"))
;".*\\.\\(dist\\|node_modules\\).*"

;gfind ~/buckaroo -not \( -type d -iregex ".*\\.\\(dist\\|node_modules\\).*" \)



(my-parse-extensions '("py" "tsx" "ts"))
;".*\\.\\(py\\|tsx?\\)$"
;gfind ~/buckaroo -iregex ".*\\.\\(py\\|tsx?\\)$" | grep tsx | head ;works
;gfind ~/buckaroo -iregex ".*\\.\\(py\\|tsx?\\)$" | grep py | head ; works

(regexp-opt '("node_modules" "dist") t)
;"\\(dist\\|node_modules\\)"





(my-parse-extensions '("pyc" "html"))
".*\\.\\(html\\|pyc\\)$"

;".*\\.\\(html\\|pyc\\)$"
