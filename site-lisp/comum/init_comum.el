;; Usar hard-links sem problemas com o esquema de backups do emacs
(setq backup-by-copying-when-linked t)

(load "comum/org-depend.el")

(load "comum/custom/compilation-custom.el")
(load "comum/custom/dired-custom.el")
(load "comum/custom/package-custom.el")
(load "comum/custom/org-mode-custom")
(load "comum/custom/keybindings-custom.el")
(load "comum/custom/full-ack-custom.el")
(load "comum/custom/erc-custom.el")
(load "comum/custom/env-vars-custom.el")
(load "comum/custom/lisp-parens-custom.el")
(load "comum/custom/highlight-changes-custom.el")
(load "comum/custom/rainbow-mode-custom.el")
(load "comum/custom/magit-custom.el")
(load "comum/custom/emacs-varios-custom.el")
