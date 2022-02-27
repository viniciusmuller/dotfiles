;;; ~/.config/doom/config.el -*- lexical-binding: t; -*-
;;; Code:

;;; :ui doom
(setq doom-font (font-spec :family "JetBrainsMono" :size 12)
      ivy-posframe-font (font-spec :family "JetBrainsMono" :size 12))
      ;; doom-theme 'doom-tomorrow-night)

;;; :ui treemacs
(use-package! treemacs
  :config
  (treemacs-follow-mode t))

;; :editor evil
(after! evil-snipe
  (evil-snipe-mode -1))

;;; config.el ends here
