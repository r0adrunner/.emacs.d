(load "org_customizacao_casa.el")
(load "magit_customizacao_casa.el")
(load "haskell_custom_casa.el")
(load "vela.el")
(load "clojure-mode_casa_custom.el")
(load "slime_swank_custom_casa.el")
(load "sql_customizacao.el")
(load "arrois_mode_custom_casa.el")

;; Color themes ---------------------------------------------------------

;;(load "tangotango_init.el")

;;(require 'zenburn)
;;(zenburn)

;; Color theme init:
;;(require 'color-theme)
;;(setq color-theme-is-global t)
;;(color-theme-initialize)

;;(color-theme-deep-blue)

;; Fonte:
(set-face-attribute 'default nil :height 143 :family "Inconsolata")

;; Browser default:
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")
