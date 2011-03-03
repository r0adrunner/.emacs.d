(require 'vim)
(vim-mode 1)

;; Modo padrão de inicialização do vim-mode:
;;(setq vim:default-initial-mode 'emacs)

;; Modo padrão de inicialização de algumas janelas:
(add-to-list 'vim:initial-modes '(dired-mode . window))
(add-to-list 'vim:initial-modes '(ibuffer-mode . window))
(add-to-list 'vim:initial-modes '(ack-mode . window))
(add-to-list 'vim:initial-modes '(org-agenda-mode . window))
(add-to-list 'vim:initial-modes '(vc-dir-mode . window))

;; Teclas de atalho do vim:
(vim:omap (kbd "C-e") 'nil)
(vim:imap (kbd "C-z") 'vim:insert-mode-exit)
(vim:nmap "q" 'nil)
(vim:omap [tab] 'nil)