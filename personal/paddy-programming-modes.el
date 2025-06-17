
(require 'eglot)

(require 'python-mode)
(add-hook 'typescript-mode-hook 'eglot-ensure)

					; whats the difference between typescript-mode and typescript-ts-mode?
					; which should I have configured here?

;(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-hook 'tsx-ts-mode-hook 'eglot-ensure)
(add-hook 'typescript-ts-mode-hook 'eglot-ensure)


(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))

(add-to-list 'eglot-server-programs
             '((typescript-mode tsx-ts-mode) . ("/Users/paddy/.nvm/versions/node/v18.20.4/bin/typescript-language-server" "--stdio")))




(add-to-list 'eglot-server-programs
            '((python-mode python-ts-mode)
            "/Users/paddy/buckaroo/.venv/bin/basedpyright-langserver" "--stdio"))

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (json-mode . json-ts-mode))
)



(add-hook 'python-ts-mode-hook 'eglot-ensure)
(define-key eglot-mode-map (kbd "C-;") 'eglot-code-actions)



(setq tab-always-indent 'complete)
;provides feature

;; Compile-mode setup
(setq compilation-scroll-output 'first-error)
;; Stolen from (http://endlessparentheses.com/ansi-colors-in-the-compilation-buffer-output.html)
(require 'ansi-color)
(defun endless/colorize-compilation ()
  "Colorize from `compilation-filter-start' to `point'."
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region
     compilation-filter-start (point))))

(add-hook 'compilation-filter-hook
          #'endless/colorize-compilation)
(define-key global-map (kbd "s-c") (lambda () (interactive (call-interactively 'compile))))

(define-key global-map (kbd "s-m") (lambda () (interactive (message "super-m"))))

(provide 'paddy-programming-modes)
