;; Usar hard-links sem problemas com o esquema de backups do emacs
(setq backup-by-copying-when-linked t)

(load "autosaves e backups.el")  ;; Poe todos os autosaves e backups em um diretorio separado
(load "org-mode_customizacao")
(load "keybindings_customizacao.el")
(load "full-ack_customizacao.el")
(load "erc_customizacao.el")
(load "env_vars.el")
(load "dired_customizacao.el")
(load "paredit_custom.el")
(load "bars.el")
(load "highlight_changes_custom.el")
(load "hacks.el" 'noerror)

(require 'org-depend)

(require 'magit)

(require 'rainbow-mode)

;; Desabilita o toolbar
(tool-bar-mode -1)

;; Permite copiar e colar de outros programas.
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Normal = 400
(setq max-list-eval-depth 150000)

;; y ou n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Sem startup screen:
(setq inhibit-startup-screen t)

;; Paredit mode no emacs-lisp mode
(add-hook 'emacs-lisp-mode-hook 'turn-on-paredit)