; -- Kinda of builtin emacs things --
(load-theme 'doom-one t)

(add-hook 'prog-mode-hook
  ; TODO: Line numbers not working
  'display-line-numbers-mode
  (setq display-line-numbers 'relative)
  #'smartparens-mode
  #'rainbow-delimiters-mode)

(require 'smartparens-config)

(set-face-attribute 'default nil :height 100)

; Go away toolbars
(tool-bar-mode -1)
(menu-bar-mode -1)
(toggle-scroll-bar -1)

; Disable backup
(setq backup-inhibited t)
; Disable auto save
(setq auto-save-default nil)

; -- Plugin emacs things --
; Evil
(setq evil-want-integration nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-keybinding nil)
(evil-collection-init)
(setq evil-collection-setup-minibuffer t)
(global-evil-leader-mode)
(evil-mode 1)
(evil-leader/set-leader "<SPC>")
(setq evil-leader/in-all-states t)

(evil-surround-mode)
(evil-commentary-mode)

(evil-leader/set-key
  "." 'counsel-fzf
  ";" 'counsel-rg
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

(better-jumper-mode +1)
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "C-o") 'better-jumper-jump-backward)
  (define-key evil-motion-state-map (kbd "<C-i>") 'better-jumper-jump-forward))

(global-undo-tree-mode)
(setq evil-undo-system 'undo-tree)

(global-git-gutter-mode +1)

; Projectile
; (projectile-mode +1)
; Recommended keymap prefix on Windows/Linux
; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

; Completion
(add-hook 'after-init-hook 'global-company-mode)
; No delay in showing suggestions.
(setq company-idle-delay 0)
; Show suggestions after entering one character.
(setq company-minimum-prefix-length 1)
(setq company-selection-wrap-around t)
; Use tab key to cycle through suggestions.
; ('tng' means 'tab and go')
(company-tng-configure-default)

; Ivy
(ivy-mode)
(setq ivy-re-builders-alist
      '((t . ivy--regex-fuzzy)))



; Highlight TODO
(global-hl-todo-mode)
