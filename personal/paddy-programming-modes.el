
(require 'eglot)

(add-hook 'typescript-mode-hook 'eglot-ensure)
(add-hook 'typescript-mode-hook 'tree-sitter-mode)
(add-hook 'tsx-ts-mode 'eglot-ensure)
(add-hook 'tsx-ts-mode 'tree-sitter-mode)
(add-to-list 'eglot-server-programs
             '((typescript-mode tsx-ts-mode) . ("/Users/paddy/.nvm/versions/node/v18.20.4/bin/typescript-language-server" "--stdio")))

(define-key eglot-mode-map (kbd "C-;") 'eglot-code-actions)

(use-package corfu
  :ensure t
  :if (display-graphic-p)
  :hook (after-init . global-corfu-mode)
  ;; I also have (setq tab-always-indent 'complete) for TAB to complete
  ;; when it does not need to perform an indentation change.
  :bind (:map corfu-map ("<tab>" . corfu-complete))
  :config
  (setq corfu-preview-current nil)
  (setq corfu-min-width 20)

  (setq corfu-popupinfo-delay '(1.25 . 0.5))
  (corfu-popupinfo-mode 1) ; shows documentation after `corfu-popupinfo-delay'

  ;; Sort by input history (no need to modify `corfu-sort-function').
  (with-eval-after-load 'savehist
    (corfu-history-mode 1)
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(setq tab-always-indent 'complete)
;provides feature
          
(provide 'paddy-programming-modes)
