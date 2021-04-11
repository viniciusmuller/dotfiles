;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;-----------------------------------------------------;
; Doom configutarion                                  ;
;-----------------------------------------------------;

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Jetbrains Mono" :size 13 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "sans" :size 13))

(custom-set-faces!
   (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
   (set-face-attribute 'font-lock-type-face nil :slant 'italic))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq-default indent-tabs-mode nil)
(setq scroll-margin 5)

;-----------------------------------------------------;
; Helper functions                                    ;
;-----------------------------------------------------;

;; (defun create-keywords (keyword-list)
;;   (mapcar (lambda (keyword) keyword . 'font-lock-keyword) keyword-list))

;-----------------------------------------------------;
; Package configuration                               ;
;-----------------------------------------------------;

;; Remove evil escape key sequence
(after! evil
  (setq evil-escape-key-sequence nil))

(after! word-wrap
  (+global-word-wrap-mode t))

(use-package! company
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

(use-package! which-key
  :config
  (which-key-setup-side-window-right)
  (setq which-key-idle-delay 0.2
        which-key-idle-secondary-delay 0.2))

(use-package! ligatures
  :config
  ;; Add ligatures on the programming modes
  ;; with `set-ligatures!` and use them here
  (plist-put! +ligatures-extra-symbols
        ;; org
        :name          "»"
        :src_block     "»"
        :src_block_end "«"
        :quote         "“"
        :quote_end     "”"
        ;; Functional
        :lambda        "λ"
        :def           "ƒ"
        :map           "↦"
        ;; Type
        :null          "∅"
        :int           "ℤ"
        :float         "ℝ"
        :str           "𝕊"
        :bool          "𝔹"
        :list          "𝕃"
        :true          "𝕋"
        :false         "𝔽"
        ;; Flow
        :not           "￢"
        :in            "∈"
        :not-in        "∉"
        :and           "∧"
        :or            "∨"
        :for           "∀"
        :some          "∃"
        :return        "⟼"
        :yield         "⟻"
        ;; Other
        :union         "∪"
        :intersect     "∩"
        :tuple         "⨂"
        :dot           "•"))

;-----------------------------------------------------;
; Modes configuration                                 ;
;-----------------------------------------------------;

;; (after! elixir-mode
;;   (setq elixir-custom-keywords '("test" "describe" "setup"))
;;   ;; Set some custom ligatures
;;   (set-ligatures! 'elixir-mode
;;     :not "not" :not-in "not in"
;;     :lambda "fn" :null "nil")
;;   ;; Add custom keywords to syntax highlighting
;;   (font-lock-add-keywords 'elixir-mode
;;     (create-keywords elixir-custom-keywords)))

;-----------------------------------------------------;
; Org Mode                                            ;
;-----------------------------------------------------;

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
