;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;;; Code:

(persp-mode)

(setq user "vinigm.nho"
      domain "gmail.com")

(setq user-full-name "Vinícius Müller"
      user-mail-address (format "%s@%s" user domain))

;; deft
(after! deft
  (setq deft-directory "~/deft/notes")
  (setq deft-extensions '("md" "org")))

;; kubernetes
; (use-package kubernetes
;   :defer
;   :commands (kubernetes-overview))

; (use-package kubernetes-evil
;   :defer
;   :after kubernetes)

; (map! :leader
;       (:prefix "o"
;        :desc "Kubernetes" "K" 'kubernetes-overview))

;; nix
(setq nix-nixfmt-bin "nixpkgs-fmt")

;; notmuch
; (setq +notmuch-home-function (lambda () (notmuch-search "tag:inbox"))
;       +notmuch-sync-backend 'mbsync)

;; org
(setq org-directory "~/org/")

;; treemacs
(after! treemacs
  (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

;; ui
(setq doom-theme 'modus-vivendi
      display-line-numbers-type t

      ;; modus
      modus-themes-region '(accented)
      modus-themes-org-blocks 'gray-background
      modus-themes-fringes 'subtle
      modus-themes-italic-constructs t
      modus-themes-bold-constructs t
      modus-themes-syntax '(green-strings)
      modus-themes-hl-line '(intense)
      modus-themes-paren-match '(intense)
      modus-themes-mode-line '(moody borderless)
      modus-themes-headings (quote ((1 . (overline variable-pitch 1.4))
                                    (2 . (overline variable-pitch 1.25))
                                    (3 . (overline 1.1))
                                    (t . (monochrome)))))

;;; config.el ends here
