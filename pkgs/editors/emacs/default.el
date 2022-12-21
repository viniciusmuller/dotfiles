; (require 'package)
; (package-initialize)
; (require 'use-package)

(use-package ansi-color
  :config
  (defun colorize-compilation-buffer ()
    (toggle-read-only)
    (ansi-color-apply-on-region compilation-filter-start (point))
    (toggle-read-only))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package yasnippet
  :config
  (use-package yasnippet-snippets)
  (use-package yasnippet-classic-snippets)
  (yas-reload-all))

;(use-package elsa
;  :hook
;  (emacs-lisp-mode . (lambda () (flycheck-elsa-setup)))
;  :config
;  (use-package flycheck-elsa
;    :hook
;    ((emacs-lisp-mode . (lambda () (flycheck-mode)))
;     (emacs-lisp-mode . (lambda () (flymake-mode))))))

(use-package flycheck
  :config
  (use-package flymake-flycheck))

(use-package magit
  :init
  (global-set-key (kbd "C-x g") 'magit-status)
  :config
  (use-package diff-hl))


(use-package lsp-mode
  ; :init
  ; (add-hook 'before-save-hook #'(lambda () (when (eq major-mode 'fsharp-mode)
  ;                                                (lsp-format-buffer))))
  :hook ((lsp-mode . lsp-lens-mode))
  :config
  (use-package lsp-treemacs))


(use-package lsp-ui
  :init
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-sideline-diagnostic-max-lines 30)
  (setq lsp-ui-sideline-diagnostic-max-line-length 30)
  (defun magueta/lsp-ui-doc-toggle ()
    "For some reason it is required to do at least once a call to lsp-ui-doc-show in order for this to work. Probably the problem resides on the frame created requiring some preparation before actually being used, so `frame-live-p` doesn't return nil."
    (interactive)
    (let ((frame (lsp-ui-doc--get-frame)))
      (if (frame-live-p frame)
	  (cond ((frame-visible-p frame) (lsp-ui-doc-hide))
		(t (lsp-ui-doc-show)))
	(message "Hover with the mouse or call `lsp-ui-doc-show` over some obect first. For why, read doc string."))))
  :bind
  (("s-?" . 'magueta/lsp-ui-doc-toggle)))

(use-package rainbow-delimiters
  :hook
  ; (lisp-mode . rainbow-delimiters-mode)
  (emacs-lisp-mode . rainbow-delimiters-mode))

(use-package elixir-mode)

(use-package smartparens
  :config
  (add-hook 'prog-mode #'smartparens-mode))

(use-package nix-mode
  :init
  (defun nix-repl-with-variable ()
    (interactive)
    (let ((variables (read-string "Nix repl variable to load: ")))
      (defcustom nix-repl-executable-args `("repl" ,variables)
        "Arguments to provide to nix-repl."
        :type '(repeat string))
      (nix-repl)))
  :hook
  (nix-mode . lsp-deferred)
  :config
  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("rnix-lsp"))
                    :major-modes '(nix-mode)
                    :server-id 'nix)))

(use-package swiper
  :init
  (global-set-key (kbd "\C-s") 'swiper))

(use-package corfu
  :init
  (setq tab-always-indent 'complete
    completion-cycle-threshold nil)

  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)
  (corfu-popupinfo-delay corfu-auto-delay)
  (corfu-min-width 40)
  (corfu-max-width 80)
  (corfu-count 14)
  (corfu-scroll-margin 4)
  (corfu-cycle t)
  (corfu-quit-at-boundary nil)
  (corfu-preselect-first t)
  (corfu-popupinfo-mode)
  :hook
  ((prog-mode . corfu-mode)
   (shell-mode . corfu-mode)
   (eshell-mode . corfu-mode))

  :config
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(use-package magit
  :init
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-d") 'mc/mark-next-like-this-word)
  (global-set-key (kbd "C-c m c") 'mc/edit-lines))

(setq initial-major-mode 'org-mode)

(use-package org
  :config
  (define-key global-map "\C-cl" 'org-store-link)
  ;; (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done 'time)
  (setq org-confirm-babel-evaluate nil))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;; make some org commands available from anywhere (not only org mode)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

(use-package transpose-frame)

(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/RoamNotes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ;; :map org-mode-map
         ;; ("C-M-i"    . completion-at-point)
	 )
  :config
  (org-roam-setup))

(use-package perspective
  :bind (("C-x x k" . persp-kill-buffer*)
	 ("C-x C-b" . persp-list-buffers))
  :init
  (setq-default persp-mode-prefix-key (kbd "C-c w"))
  (persp-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package org-bullets
  :hook
  ((org-mode . org-bullets-mode)))

(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package dashboard
  ; :after all-the-icons
  ;; :diminish dashboard-mode
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-set-file-icons t)
  ; (setq dashboard-startup-banner "~/Projects/MageMacs/sources/emacs.svg")
  (setq dashboard-banner-logo-title "emacscool")
  (setq dashboard-items 
    '((recents   . 5)
      (bookmarks . 5)
      (projects  . 5)))
  (setq dashboard-center-content t)
  (setq dashboard-footer-messages '("editr good")))

(evil-mode 1)

; (use-package evil-org
  ; :after org
  ; :hook (org-mode . (lambda () evil-org-mode))
  ; :config
  ; (require 'evil-org-agenda)
  ; (evil-org-agenda-set-keys))

(use-package display-line-numbers
  :custom (display-line-numbers 'relative)
  :hook ((prog-mode . display-line-numbers-mode)))

(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  :bind
  (("C-s" . consult-line))
  
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  (setq consult-narrow-key "<"))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :init
  (vertico-mode))

(use-package ace-window
  :init
  (global-set-key (kbd "M-p") 'ace-window))

(use-package marginalia
  :defer t
  :bind
  (("M-A" . marginalia-cycle)
   :map minibuffer-local-map
   ("M-A" . marginalia-cycle))
  
  :init
  (marginalia-mode))

; (require 'theme)
(load-file "~/.emacs.d/theme.el")
