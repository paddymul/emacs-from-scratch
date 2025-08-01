
(defun my-parse-extensions (extensions)
  (format ".*\\.%s$" (regexp-opt extensions t)))

(defun my-parse-directories (directories)
  (format ".*\\.%s.*" (regexp-opt directories t)))


(defun paddy-py-find-grep (root-directory search-term)
  (let* ((py-preferred-extensions (my-parse-extensions '("py")))
	 (py-secondary-directories (my-parse-directories '(".venv" "foo")))
	 (py-secondary-extensions  (my-parse-extensions '("js" "ts" "jsx" "tsx")))
	 (py-never-directories (my-parse-directories '(".ruff" ".git" "pycache" "dist")))
	 (py-never-extensions (my-parse-extensions '("pyc" ".d.ts"))))
    (princ (format-spec "%a \"%b\" \"%c\" \"%d\" \"%e\" \"%f\" \"%g\" \"%h\" \"%i\" ||| "
			`((?a . ,paddy-find-script)
			  (?b . ,root-directory)  ; search_root $1
			  (?c . ,search-term)     ; search_term $2
			  (?d . "") ; preferred_directories $3 - unused
			  (?e . ,py-preferred-extensions) ; preferred_extensions $4 - unused
			  (?f . ,py-secondary-directories) ; secondary_directories $5
			  (?g . ,py-secondary-extensions) ; secondary_extensions $6
			  (?h . ,py-never-directories) ; never_directories $7
			  (?i . ,py-never-extensions) ; never_extensions $8
			  )))))
(paddy-py-find-grep "~/Buckaroo" "color_map")
















					;

/Users/paddy/.emacs.d/personal/find_script.sh "~/Buckaroo" "color_map" "" ".*\.\(py\)$" ".*\.\(\.venv\|foo\).*" ".*\.\(jsx?\|tsx?\)$" ".*\.\(\.\(?:git\|ruff\)\|dist\|pycache\).*" ".*\.\(\.d\.ts\|pyc\)$" ||| "/Users/paddy/.emacs.d/personal/find_script.sh \"~/Buckaroo\" \"color_map\" \"\" \".*\\.\\(py\\)$\" \".*\\.\\(\\.venv\\|foo\\).*\" \".*\\.\\(jsx?\\|tsx?\\)$\" \".*\\.\\(\\.\\(?:git\\|ruff\\)\\|dist\\|pycache\\).*\" \".*\\.\\(\\.d\\.ts\\|pyc\\)$\" ||| "

"/Users/paddy/.emacs.d/personal/find_script.sh \"~/Buckaroo\" \"color_map\" \"\" \".*\\.\\(py\\)$\" \".*\\.\\(\\.venv\\|foo\\).*\" \".*\\.\\(jsx?\\|tsx?\\)$\" \".*\\.\\(\\.\\(?:git\\|ruff\\)\\|dist\\|pycache\\).*\" \".*\\.\\(\\.d\\.ts\\|pyc\\)$\" ||| "

"/Users/paddy/.emacs.d/personal/find_script.sh \"~/Buckaroo\" \"color_map\" \"\" \".*\\.\\(py\\)$\" \".*\\.\\(\\.venv\\|foo\\).*\" \".*\\.\\(jsx?\\|tsx?\\)$\" \".*\\.\\(\\.\\(?:git\\|ruff\\)\\|dist\\|pycache\\).*\" \".*\\.\\(\\.d\\.ts\\|pyc\\)$\" ||| "
/Users/paddy/.emacs.d/personal/find_script.sh "~/Buckaroo" "color_map" "" ".*\.\(py\)$" ".*\.\(\.venv\|foo\).*" ".*\.\(jsx?\|tsx?\)$" ".*\.\(\.\(?:git\|ruff\)\|dist\|pycache\).*" ".*\.\(\.d\.ts\|pyc\)$" 

;; why does (princ (format-spec ... also output the entire format spec args ? I put the ||| at the end so the delineation is clear








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
