;; Usar hard-links sem problemas com o esquema de backups do emacs
(setq backup-by-copying-when-linked t)

(load "package_custom.el")
(load "org-mode_customizacao")
(load "keybindings_customizacao.el")
(load "full-ack_customizacao.el")
(load "erc_customizacao.el")
(load "env_vars.el")
(load "dired_customizacao.el")
(load "lisp_parens_custom.el")
(load "bars.el")
(load "highlight_changes_custom.el")
(load "hacks.el" 'noerror)
(load "rainbow-mode_cust.el")
(load "magit_custom.el")
(load "emacs_custom.el")

