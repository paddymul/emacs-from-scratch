;; NOTE: init.el is now generated from Emacs.org.  Please edit that file
;;       in Emacs and init.el will be generated automatically!

;; You will most likely need to adjust this font size for your system!


(add-to-list 'load-path  "/Users/paddy/.emacs.d/personal")


(defmacro comment (&rest a))

;; Make frame transparency overridable
(defvar efs/frame-transparency '(90 . 90))
(setq-default explicit-shell-file-name "/opt/homebrew/bin/zsh")

(progn
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)   

    (setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))
    )
(setq create-lockfiles nil)
(setq ispell-program-name "/opt/homebrew/bin/ispell")



;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 256 1000 1000))
(setq read-process-output-max (* 1024 1024))

(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

  ;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)


;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
;(setq user-emacs-directory "~/.cache/emacs")

(use-package no-littering)

;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)

;; Set frame transparency
;(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
;(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(defvar efs/default-font-size 100)

(defvar efs/default-variable-font-size 180)
(defvar efs/fixed-code-font "Ubuntu Mono")
(setq efs/fixed-code-font "Fira Code Retina")
;(setq efs/code-font "Ubuntu Mono")
(defvar efs/variable-code-font "Cantarell")


;;TODO add try/catch and default to other fonts if these throw errors
(set-face-attribute 'default nil :font efs/fixed-code-font  :height efs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font  efs/fixed-code-font :height efs/default-font-size)

;; Set the variable pitch face

(set-face-attribute 'variable-pitch nil :font efs/variable-code-font :height efs/default-variable-font-size :weight 'regular)
;(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs)
  )

(use-package general
;  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))))


(use-package command-log-mode
  :commands command-log-mode)

(use-package doom-themes
  :init (load-theme 'doom-palenight t))

;(use-package doom-themes
;  :init (load-theme 'doom-opera t))


(use-package all-the-icons)


(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))



(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
(use-package forge
  :after magit)


;; worked when end comment here


;; removing this because counsel and counsel depends on ivy
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :bind
  ;; ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ;; ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))



(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(efs/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))

(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font efs/variable-code-font :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(defun efs/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (visual-line-mode 1))

(use-package org
  :pin org
  :commands (org-capture org-agenda)
;  :hook (org-mode . efs/org-mode-setup)
  :config
  (setq org-ellipsis " ▾")

  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-files
        '("~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Habits.org"
          "~/Projects/Code/emacs-from-scratch/OrgFiles/Birthdays.org"))

  (require 'org-habit)
  (add-to-list 'org-modules 'org-habit)
  (setq org-habit-graph-column 60)

  (setq org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)")))

  (setq org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/Projects/Code/emacs-from-scratch/OrgFiles/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)

      ("w" "Workflows")
      ("we" "Checking Email" entry (file+olp+datetree "~/Projects/Code/emacs-from-scratch/OrgFiles/Journal.org")
           "* Checking Email :email:\n\n%?" :clock-in :clock-resume :empty-lines 1)

      ("m" "Metrics Capture")
      ("mw" "Weight" table-line (file+headline "~/Projects/Code/emacs-from-scratch/OrgFiles/Metrics.org" "Weight")
       "| %U | %^{Weight} | %^{Notes} |" :kill-buffer t)))

  (define-key global-map (kbd "C-c j")
    (lambda () (interactive) (org-capture nil "jj")))

  (efs/org-font-setup))

(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(defun efs/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . efs/org-mode-visual-fill))

;; (with-eval-after-load 'org
;;   (org-babel-do-load-languages
;;       'org-babel-load-languages
;;       '((emacs-lisp . t)
;;       (python . t)))

;;   (push '("conf-unix" . conf-unix) org-src-lang-modes))



(with-eval-after-load 'org
  ;; This is needed as of Org 9.2
  (require 'org-tempo)

  ;; (add-to-list 'org-structure-template-alist '("sh" . "src shell"))
  ;; (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  ;; (add-to-list 'org-structure-template-alist '("py" . "src python"))

)

;; Automatically tangle our Emacs.org config file when we save it
(defun efs/org-babel-tangle-config ()
  (when (string-equal (file-name-directory (buffer-file-name))
                      (expand-file-name user-emacs-directory))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

;(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'efs/org-babel-tangle-config)))

;; (comment
;; (defun efs/lsp-mode-setup ()
;;   (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
;;   (lsp-headerline-breadcrumb-mode))

;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :hook (lsp-mode . efs/lsp-mode-setup)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
;;   :config
;;   (lsp-enable-which-key-integration t))

;; (use-package lsp-ui
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :custom
;;   (lsp-ui-doc-position 'bottom))

;; (use-package lsp-treemacs
;;   :after lsp)


;; (use-package dap-mode
;;   ;; Uncomment the config below if you want all UI panes to be hidden by default!
;;   ;; :custom
;;   ;; (lsp-enable-dap-auto-configure nil)
;;   ;; :config
;;   ;; (dap-ui-mode 1)
;;   :commands dap-debug
;;   :config
;;   ;; Set up Node debugging
;;   (require 'dap-node)
;;   (dap-node-setup) ;; Automatically installs Node debug adapter if needed

;;   ;; Bind `C-c l d` to `dap-hydra` for easy access
;;   (general-define-key
;;     :keymaps 'lsp-mode-map
;;     :prefix lsp-keymap-prefix
;;     "d" '(dap-hydra t :wk "debugger")))

;; (use-package typescript-mode
;;   :mode "\\.ts\\'"
;; ;  :hook (typescript-mode . lsp-deferred)
;;   :config
;;   (setq typescript-indent-level 2))

;; ;; (use-package python-mode
;; ;;   :ensure t
;; ;; ;  :hook (python-mode . lsp-deferred)
;; ;;   :custom
;; ;;   ;; NOTE: Set these if Python 3 is called "python3" on your system!
;; ;;   ;; (python-shell-interpreter "python3")
;; ;;   ;; (dap-python-executable "python3")
;; ;;   (dap-python-debugger 'debugpy)
;; ;;   :config
;; ;;   (require 'dap-python))

;; (use-package pyvenv
;;   :after python-mode
;;   :config
;;   (pyvenv-mode 1))
;; )



(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash") ;; Change this to zsh, etc
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

;; (use-package vterm
;;   :commands vterm
;;   :config
;;   (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
;;   ;;(setq vterm-shell "zsh")                       ;; Set this to customize the shell to launch
;;   (setq vterm-max-scrollback 10000))

(when (eq system-type 'windows-nt)
  (setq explicit-shell-file-name "powershell.exe")
  (setq explicit-powershell.exe-args '()))

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . efs/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "zsh" "vim")))

  (eshell-git-prompt-use-theme 'powerline))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first")))

(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config)

;; Make gc pauses faster by decreasing the threshold.
(recentf-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(conda-anaconda-home "/home/paddy/anaconda3/")
 '(custom-safe-themes
   '("dd4582661a1c6b865a33b89312c97a13a3885dc95992e2e5fc57456b4c545176"
     "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476"
     default))
 '(dired-listing-switches "-la --group-directories-first" nil nil "Customized with use-package dired")
 '(flyspell-delay 0.75)
 '(global-flycheck-mode nil)
 '(kill-read-only-ok t)
 '(lsp-clients-typescript-npm-location "/opt/homebrew/bin/npm")
 '(lsp-file-watch-ignored-directories
   '("[/\\\\]\\.git\\'" "[/\\\\]\\.github\\'" "[/\\\\]\\.circleci\\'"
     "[/\\\\]\\.hg\\'" "[/\\\\]\\.bzr\\'" "[/\\\\]_darcs\\'"
     "[/\\\\]\\.svn\\'" "[/\\\\]_FOSSIL_\\'" "[/\\\\]\\.idea\\'"
     "[/\\\\]\\.ensime_cache\\'" "[/\\\\]\\.eunit\\'"
     "[/\\\\]node_modules" "[/\\\\]\\.fslckout\\'" "[/\\\\]\\.tox\\'"
     "[/\\\\]dist\\'" "[/\\\\]dist-newstyle\\'"
     "[/\\\\]\\.stack-work\\'" "[/\\\\]\\.bloop\\'"
     "[/\\\\]\\.metals\\'" "[/\\\\]target\\'"
     "[/\\\\]\\.ccls-cache\\'" "[/\\\\]\\.vscode\\'"
     "[/\\\\]\\.deps\\'" "[/\\\\]build-aux\\'"
     "[/\\\\]autom4te.cache\\'" "[/\\\\]\\.reference\\'"
     "[/\\\\]\\.lsp\\'" "[/\\\\]\\.clj-kondo\\'"
     "[/\\\\]\\.shadow-cljs\\'" "[/\\\\]\\.babel_cache\\'"
     "[/\\\\]\\.cpcache\\'" "[/\\\\]bin/Debug\\'" "[/\\\\]obj\\'"
     "[/\\\\]_opam\\'" "[/\\\\]_build\\'" "[/\\\\]\\.jest\\'"
     "[/\\\\]node_modules\\'" "[/\\\\]\\.direnv\\'"
     "[/\\\\\\\\]\\\\.jest\\\\'" "[/\\\\\\\\]node_modules\\\\'"))
 '(lsp-typescript-npm "PATH=/opt/homebrew/bin/:$PATH /opt/homebrew/bin/npm")
 '(magit-git-executable "/opt/homebrew/bin/git")
 '(org-html-doctype "html5")
 '(package-selected-packages
   '(all-the-icons-dired bind-key cider command-log-mode conda consult
			 corfu counsel-projectile coverlay csv
			 csv-mode dap-mode dired-hide-dotfiles
			 dired-open dired-single doom-themes ein
			 emacsql-sqlite embark embark-consult envrc
			 eshell-git-prompt eterm-256color forge
			 general helpful ivy-prescient ivy-rich
			 jupyter lsp-ivy lsp-pyright lsp-ui marginalia
			 markdown-preview-mode mmm-mode no-littering
			 orderless org-bullets origami poly-markdown
			 python-mode pyvenv rainbow-delimiters
			 reformatter scss-mode tree-sitter-langs
			 treesit-auto typescript-mode vertico
			 visual-fill-column yaml-mode yasnippet))
 '(prelude-whitespace nil)
 '(safe-local-variable-values '((lsp-python-ms-python-executable . "/.../bin/python")))
 '(sp-override-key-bindings '(("s-o")))
 '(typescript-indent-level 2))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "navy" :foreground "#A6Accd" :box nil)))))

    (defun load-directory (dir)
      (let ((load-it (lambda (f)
		       (load-file (concat (file-name-as-directory dir) f)))
		     ))
	(mapc load-it (directory-files dir nil "\\.el$"))))


;; (comment

;; ; jupyter notebook daemon for datascience generally, test prep, and vizcomp
;; ;  per directory  jupyter notebook not possible
;; ; reloading macro 

;;  run-once
;;  algo practice with jupyter
;;  slime/clojure setup


;;  jupyter
;;    change keymap to C-m...
 
;;  org <-> mobile <-> mac

;;  learn smart paren mode

;;  formatting per directory -- for projects
;; sql setup

;; lsp ts setup for 3 projects


;; all temp files in different location
;; make a missing temp file not bork startup
;; turn off auto-update on startup, or at least ask after everything else is run

;; toggle dired hide-show hidden files
;; toggle dired opening new windows


;;  gui version of debug init

;;  hook to prevent saving syntax error in .el files

;; make emacs behave same from daemon start vs commandline start
 
;;  )


(add-to-list 'safe-local-variable-values '(conda-project-env-path . "base"))
(add-to-list 'safe-local-variable-values '(conda-project-env-path . "ds-play"))

(defmacro hook-add-or-update (hook fname &rest body)
  "Macro to make defining and updating hooks much easier.
   Hook functions get an fname.
   Before defining and adding a hook to a list, macro first checks if that fname is already defined, if so, the old version is removed from hook

  used as follows
  (hook-add-or-update
     shell-mode-hook fourth-shell-hook
     (message \"macro fourth rev 2\"))"
  `(progn
     (if (fboundp ',fname)
	 (progn 
	   (message "defined fname of %s" ',fname)
	   (remove-hook ',hook ',fname))
       (message "not found fname of %s" ',fname))
     (defun ,fname (&rest argrest)
       ,@body)
     (add-hook ',hook ',fname)))

(defun efs/start-hook ()
		(message "start-hook begin")		
		(find-file  (expand-file-name "~/.emacs.d/init.el"))
		(find-file  (expand-file-name "~/.emacs.d/personal/lsp-setup.el"))
		(call-interactively 'shell)
		(counsel--M-x-externs)
		(message "start-hook end")
		(message "frame-start--hook begin")		
		;(switch-to-buffer "lsp-setup.el")
		(switch-to-buffer "init.el")
		(end-of-buffer)
		(call-interactively 'split-window-right )
		(switch-to-buffer "*shell*")
		(message "frame-start-hook end2")


)
(defalias 'yes-or-no-p 'y-or-n-p)



(setopt comint-process-echoes t) ; makes comint mode remove the last command run from the output


;  from https://blog.lambda.cx/posts/emacs-align-columns/
; https://whatacold.io/blog/2019-07-20-understanding-align-regexp-of-emacs/

;this is good, and an improvement,  I'd like to have it right align numbers
(defun paddy-table-align (BEG END)
  "Align non-space columns in region BEG END."
  (interactive "r")
  (let ((indent-tabs-mode nil)) ;align with spaces
    (align-regexp BEG END "\\(\\s-*\\)\\S-+" -1 1 t)))


(global-set-key (kbd "C-M-=") 'paddy-table-align)


(when (string= system-type "darwin")
  (progn
    (add-to-list 'exec-path "/opt/homebrew/bin/")
    (setq dired-use-ls-dired t
          insert-directory-program "/opt/homebrew/bin/gls"
          dired-listing-switches "-aBhl --group-directories-first")))

(setq dired-listing-switches "-al --group-directories-first")



(require 'me)

(find-file "/Users/paddy/.emacs.d/init.el")
(find-file "/Users/paddy/.emacs.d/personal/paddy-programming-modes.el")
(find-file "/Users/paddy/.emacs.d/personal/paddy-completion-setup.el")
(find-file "/Users/paddy/.emacs.d/emacs-coaching-notes.md")
(add-to-list 'exec-path "/Users/paddy/miniforge3/bin/")
;exec-path
