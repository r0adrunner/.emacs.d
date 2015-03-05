;; Color themes ---------------------------------------------------------

(load-theme 'zenburn t)

;; Color theme init:
;; (require 'color-theme)
;; (setq color-theme-is-global t)

;; Color-theme package is broken in emacs 24. Quick fix:
;; (defun plist-to-alist (plist) plist)

;; (color-theme-classic)

;; Fontes -----------------------------------------------------------------
;; (set-face-attribute 'default nil :height 142 :family "Inconsolata")
(set-face-attribute 'default nil :height 125 :family "DejaVu Sans Mono")
