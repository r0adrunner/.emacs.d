(require 'color-theme)
(setq color-theme-load-all-themes nil)


(load "autosaves e backups.el")  ;; Poe todos os autosaves e backups em um diretorio separado
(load "org-mode_customizacao")
(load "keybindings_customizacao.el")
(load "full-ack_customizacao.el")
(load "vim-mode_customizacao.el")
(require 'org-depend)

;; Habilita o server para abrir arquivos na mesma janela
(server-start)
