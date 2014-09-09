(load "org-casa-custom.el")
(load "magit-casa-custom.el")
(load "haskell-casa-custom.el")
(load "clojure-mode-casa-custom.el")
(load "nrepl-casa-custom.el")
(load "sql-casa-custom.el")
(load "arrois-mode-casa-custom.el")
(load "jabber-casa-custom.el")
(load "hacks-casa.el" 'noerror)

;; Color themes ---------------------------------------------------------

;; Color theme init:
(require 'color-theme)
(setq color-theme-is-global t)

;; Color-theme package is broken in emacs 24. Quick fix:
(defun plist-to-alist (plist) plist)

(color-theme-deep-blue)

;; Fontes -----------------------------------------------------------------
;;(set-face-attribute 'default nil :height 143 :family "Inconsolata")
(set-face-attribute 'default nil :height 120 :family "DejaVu Sans Mono")

;; Browser default:
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium"
      browse-url-generic-args nil)
