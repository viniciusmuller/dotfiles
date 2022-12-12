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

; (use-package elsa
;   :hook
;   (emacs-lisp-mode . (lambda () (flycheck-elsa-setup)))
;   :config
;   (use-package flycheck-elsa
;     :hook
;     ((emacs-lisp-mode . (lambda () (flycheck-mode)))
;      (emacs-lisp-mode . (lambda () (flymake-mode))))))

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
  :init (global-corfu-mode t))

(use-package magit
  :init
  (global-set-key (kbd "C-x g") 'magit-status))

(use-package helm
  :init
  (helm-mode 1)
  :config
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x b") 'helm-buffers-list))


(use-package multiple-cursors
  :config
  (global-set-key (kbd "C-d") 'mc/mark-next-like-this-word)
  (global-set-key (kbd "C-c m c") 'mc/edit-lines))


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
  :init (persp-mode))

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
  ; (setq dashboard-set-file-icons t)
  ; (setq dashboard-startup-banner "~/Projects/MageMacs/sources/emacs.svg")
  (setq dashboard-banner-logo-title "emacscool")
  (setq dashboard-items 
    '((recents   . 5)
      (bookmarks . 5)
      (projects  . 5)))
  (setq dashboard-center-content t)
  (setq dashboard-footer-messages '("editr good")))

; (require 'evil)
(evil-mode 1)

(use-package linum-relative)

; (require 'theme)
(load-file "~/.emacs.d/theme.el")
