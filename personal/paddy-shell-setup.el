
(defun paddy-compile-with-buffer-name
    (local-compile-command buffer-name)
    (compilation-start local-compile-command t
		       (lambda (_mode) buffer-name) t))

(defun paddy-shell-start-marimo ()
  (interactive)
  (paddy-compile-with-buffer-name
   "/Users/paddy/buckaroo/.venv/bin/marimo edit"
   "marimo-co-sh"))

(paddy-shell-start-marimo)
(provide 'paddy-shell-setup)
