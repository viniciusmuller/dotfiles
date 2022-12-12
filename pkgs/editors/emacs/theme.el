(load-theme 'gruvbox t)

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(setq-default cursor-type 'box)
(fringe-mode '(7 . 0))
(scroll-bar-mode -1)
(menu-bar-mode +1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(display-battery-mode -1)
(display-time-mode t)

; TODO: use [rainbow-mode](https://github.com/emacsmirror/rainbow-mode) to figure colors out
(custom-set-faces
  '(rainbow-delimiters-depth-1-face ((t (:foreground "systemTealColor"))))
  '(rainbow-delimiters-depth-2-face ((t (:foreground "Brown"))))
  '(rainbow-delimiters-depth-3-face ((t (:foreground "Blue"))))
  '(rainbow-delimiters-depth-4-face ((t (:foreground "Orange"))))
  '(rainbow-delimiters-depth-5-face ((t (:foreground "Purple"))))
  '(rainbow-delimiters-depth-6-face ((t (:foreground "dark green"))))
  '(rainbow-delimiters-depth-9-face ((t (:foreground "indian red")))))

(provide 'theme)
