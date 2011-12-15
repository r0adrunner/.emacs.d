(load "org_customizacao_casa.el")
(load "magit_customizacao_casa.el")
(load "agua.el")
(load "vela.el")

;; Color themes ---------------------------------------------------------

;;(load "tangotango_init.el")

(require 'zenburn)
(zenburn)

;; Color theme init:
;;(require 'color-theme)
;;(setq color-theme-is-global t)
;;(color-theme-initialize)

;;(color-theme-gray1)

;; Browser default:
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")

;; Haskell mode -------------------------------------------------------

(load "/usr/share/emacs/site-lisp/haskell-mode/haskell-site-file")

;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)