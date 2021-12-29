(require 'package)
(require 'use-package)
(require 'lsp-ui-imenu)
(custom-set-variables
 '(conda-anaconda-home "/home/paddy/anaconda3/"))
(setq conda-env-home-directory (expand-file-name "~/anaconda3/"))
(setq
      read-process-output-max (* 1024 1024))

(setq lsp-log-io nil)
;(setq lsp-use-plists t)  -- causes errors I can't figure out


(use-package conda
  :config (progn
            (conda-env-initialize-interactive-shells)
            (conda-env-initialize-eshell)

            (setq conda-env-home-directory (expand-file-name "~/anaconda3/")
		    conda-env-subdirectory "envs")
            (custom-set-variables '(conda-anaconda-home (expand-file-name "~/anaconda3/")))

;            (conda-env-autoactivate-mode t)
))

(setq ein:jupyter-default-server-command (format "%s/.emacs.d/ein_jupyter.sh" (getenv "HOME")))

(use-package jupyter
  :commands (jupyter-run-server-repl
             jupyter-run-repl
             jupyter-server-list-kernels)
  :init (eval-after-load 'jupyter-org-extensions ; conflicts with my helm config, I use <f2 #>
          '(unbind-key "C-c h" jupyter-org-interaction-mode-map)))


(use-package lsp-mode
  :config
  (setq lsp-idle-delay 0.2
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil  ;; Not supported by company capf, which is the recommended company backend
        lsp-pyls-plugins-flake8-enabled t)
  (lsp-register-custom-settings
   '(("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" nil t)
     ("pyls.plugins.pyls_black.enabled" t t)
     ("pyls.plugins.pyls_isort.enabled" t t)

     ;; Disable these as they're duplicated by flake8
     ("pyls.plugins.pycodestyle.enabled" nil t)
     ("pyls.plugins.mccabe.enabled" nil t)
     ("pyls.plugins.pyflakes.enabled" nil t)))
  :hook
  ((python-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  ;; :bind (:map evil-normal-state-map
  ;;             ("gh" . lsp-describe-thing-at-point)
  ;;             :map md/leader-map
  ;;             ("Ff" . lsp-format-buffer)
  ;;             ("FR" . lsp-rename))

)

(use-package lsp-ui
  :config (setq lsp-ui-sideline-show-hover t
                lsp-ui-sideline-delay 0.5
                lsp-ui-doc-delay 5
                lsp-ui-sideline-ignore-duplicates t
                lsp-ui-doc-position 'bottom
                lsp-ui-doc-alignment 'frame
                lsp-ui-doc-header nil
                lsp-ui-doc-include-signature t
                lsp-ui-doc-use-childframe t)
  :commands lsp-ui-mode
  ;; :bind (:map evil-normal-state-map
  ;;             ("gd" . lsp-ui-peek-find-definitions)
  ;;             ("gr" . lsp-ui-peek-find-references)
  ;;             :map md/leader-map
  ;;             ("Ni" . lsp-ui-imenu))

)

(use-package pyvenv
  :demand t
  :config
  (setq pyvenv-workon "emacs")  ; Default venv
  (pyvenv-tracking-mode 1))  ; Automatically use pyvenv-workon via dir-locals


(defmacro comment (&rest a))
(comment

;;;; disabled existing code from prelude-lsp 
;; (require 'lsp-ui)

;; (define-key lsp-ui-mode-map (kbd "C-c C-l .") 'lsp-ui-peek-find-definitions)
;; (define-key lsp-ui-mode-map (kbd "C-c C-l ?") 'lsp-ui-peek-find-references)
;; (define-key lsp-ui-mode-map (kbd "C-c C-l r") 'lsp-rename)
;; (define-key lsp-ui-mode-map (kbd "C-c C-l x") 'lsp-workspace-restart)
;; (define-key lsp-ui-mode-map (kbd "C-c C-l w") 'lsp-ui-peek-find-workspace-symbol)
;; (define-key lsp-ui-mode-map (kbd "C-c C-l i") 'lsp-ui-peek-find-implementation)
;; (define-key lsp-ui-mode-map (kbd "C-c C-l d") 'lsp-describe-thing-at-point)
;; (define-key lsp-ui-mode-map (kbd "C-c C-l e") 'lsp-execute-code-action)

;; (setq lsp-ui-sideline-enable t)
;; (setq lsp-ui-doc-enable t)
;; (setq lsp-ui-peek-enable t)
;; (setq lsp-ui-peek-always-show t)


;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
;(use-package helm)
;(helm-mode)
;(require 'helm-xref)


(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)


(defun pm/lsp-mode-setup ()
  (lsp-headerline-breadcrumb-mode)
  (lsp-enable-which-key-integration)
  ;;this seems to have a huge performance gain
  (setq lsp-log-io nil))

;figure out wider larger which mdoe for lsp mode
(use-package lsp-mode
                                        ;  :straight t
  :commands (lsp lsp-deferred)
  :hook
  (lsp-mode . pm/lsp-mode-setup)
  ((python-mode . lsp))
  ((typescript-mode js2-mode web-mode) . lsp)
  :init
  (setq lsp-keymap-prefix "s-l")
  ;(setq lsp-keymap-prefix (kbd "M-l"))
  )


(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-position 'bottom))


(use-package typescript-mode
  :mode "\\.ts\\'"
  :config
  ;(lsp-enable-which-key-integration)
  (setq typescript-indent-level 2))

(use-package js2-mode
  :mode "\\.jsx?\\'"
  :config
  ;; Use js2-mode for Node scripts
  (add-to-list 'magic-mode-alist '("#!/usr/bin/env node" . js2-mode))

  ;; Don't use built-in syntax checking
  (setq js2-mode-show-strict-warnings nil))


(use-package prettier-js
  ;; :hook ((js2-mode . prettier-js-mode)
  ;;        (typescript-mode . prettier-js-mode))
  :config
  (setq prettier-js-show-errors nil))

(with-eval-after-load 'lsp-mode
  ;(add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)                                      
  (require 'dap-cpptools)
  (require 'dap-chrome)
;  (yas-global-mode)
)


;setting company-idle-delay to 1.5 makes it much less likel that slow
;company-mode completions will delay my typing
;(setq company-idle-delay .75)
(setq company-idle-delay 0)




(use-package dap-mode
  ;; Uncomment the config below if you want all UI panes to be hidden by default!
  :custom
  (lsp-enable-dap-auto-configure nil)
  :config
  
  :commands
  dap-debug
  :config
  ;; Set up Node debugging
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy)
  (dap-ui-mode 1))

(use-package lsp-python-ms
  :ensure t
  :init (setq lsp-python-ms-auto-install-server t)
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (require 'dap-python)
                         (lsp))))

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast
)
