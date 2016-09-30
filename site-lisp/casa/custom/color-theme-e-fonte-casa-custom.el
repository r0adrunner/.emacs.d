;; Color themes ---------------------------------------------------------

;; (load-theme 'zenburn t)

;; Color theme init:
(require 'color-theme)
(setq color-theme-is-global t)

;; Color-theme package is broken in emacs 24. Quick fix:
(defun plist-to-alist (plist) plist)

(color-theme-deep-blue)

;; Fontes -----------------------------------------------------------------
;;(set-face-attribute 'default nil :height 143 :family "Inconsolata")
(set-face-attribute 'default nil :height 120 :family "DejaVu Sans Mono")

(defun enlarge-font ()
  (interactive)
  (set-face-attribute 'default nil :height 190))
