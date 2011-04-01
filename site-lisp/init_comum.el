(require 'color-theme)
(setq color-theme-load-all-themes nil)

;; Usar hard-links sem problemas com o esquema de backups do emacs
(setq backup-by-copying-when-linked t)

(load "autosaves e backups.el")  ;; Poe todos os autosaves e backups em um diretorio separado
(load "org-mode_customizacao")
(load "keybindings_customizacao.el")
(load "full-ack_customizacao.el")
;;(load "vim-mode_customizacao.el")
(require 'org-depend)

;; Habilita o server para abrir arquivos na mesma janela
(server-start)
	
;; Desabilita o toolbar
(tool-bar-mode -1)

;; Permite copiar e colar de outros programas.
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Normal = 400
(setq max-list-eval-depth 1000)