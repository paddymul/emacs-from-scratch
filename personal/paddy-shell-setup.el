
(defun paddy-compile-with-buffer-name
    (local-compile-command buffer-name)
    (compilation-start local-compile-command t
		       (lambda (_mode) buffer-name) t))


(defun prot-shell--beginning-of-prompt-p ()
  "Return non-nil if point is at the beginning of a shell prompt."
  (if comint-use-prompt-regexp
      (looking-back comint-prompt-regexp (line-beginning-position))
    (eq (point) (comint-line-beginning-position))))

(defun prot-shell--insert-and-send (&rest args)
  "Insert and execute ARGS in the last shell prompt.
ARGS is a list of strings."
  (if (prot-shell--beginning-of-prompt-p)
      (progn
        (insert (mapconcat #'identity args " "))
        (comint-send-input))
    (user-error "Not at the beginning of prompt; won't insert: %s" args)))


(defun paddy-shell-start-sonderco ()
  (interactive)
  (let
      ((default-directory "~/sonderco")
       (buffer (shell "sonderco-srv-sh"))
       (start-docker-and-server
	'("open" "/Applications/Docker.app/" "&&" "sleep 4" "&&" "npx supabase start" "&&" "pnpm run dev"))
       (stop-docker-and-server
	'("npx" "supabase" "stop" "&&" "osascript" "-e" "'quit app \"Docker Desktop\"'")))
    
    (with-current-buffer buffer
      (sit-for 2)
      (prot-shell--insert-and-send "cd" "~/sonderco")
      (sit-for 1)
      (apply 'prot-shell--insert-and-send start-docker-and-server)
      (comint-interrupt-subjob)
      (sit-for 4)
      (apply 'prot-shell--insert-and-send stop-docker-and-server)
)))

(paddy-shell-start-sonderco)
  
    

(defun paddy-shell-start-marimo ()
  (interactive)
  (paddy-compile-with-buffer-name
   "/Users/paddy/buckaroo/.venv/bin/marimo edit"
   "marimo-co-sh"))

(paddy-shell-start-marimo)

(defun paddy-shell-start-regular-shell ()
  (interactive)
  (let
      ((default-directory "~/buckaroo")
       (buffer (shell))
       (activate-uv '("source" "./.venv/bin/activate")))
    
    (with-current-buffer buffer
      (prot-shell--insert-and-send "cd" "~/buckaroo")
      (sit-for 1)
      (apply 'prot-shell--insert-and-send activate-uv))))
(paddy-shell-start-regular-shell)
(provide 'paddy-shell-setup)
