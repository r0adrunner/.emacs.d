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
(vim:omap (kbd "C-e") 'nil)                     ;; era vim:scroll-line-down   
(vim:omap (kbd "C-t") 'vim:scroll-line-down)
(vim:imap (kbd "C-z") 'vim:insert-mode-exit)
(vim:nmap (kbd "C-r") 'nil)                     ;; era vim:cmd-redo
(vim:nmap "q" 'nil)                             ;; era vim:cmd-toggle-macro-recording
(vim:omap [tab] 'nil)