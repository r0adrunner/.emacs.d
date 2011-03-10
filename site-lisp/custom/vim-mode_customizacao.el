(require 'vim)
(vim-mode 1)

;; Modo padrão de inicialização do vim-mode:
;;(setq vim:default-initial-mode 'emacs)

;; Modo padrão de inicialização de algumas janelas:
(add-to-list 'vim:initial-modes '(dired-mode . window))
(add-to-list 'vim:initial-modes '(ibuffer-mode . window))
(add-to-list 'vim:initial-modes '(ack-mode . window))
(add-to-list 'vim:initial-modes '(bookmark-bmenu-mode . window))
(add-to-list 'vim:initial-modes '(eshell-mode . window))
(add-to-list 'vim:initial-modes '(shell-mode . window))
(add-to-list 'vim:initial-modes '(org-agenda-mode . window))
(add-to-list 'vim:initial-modes '(vc-dir-mode . window))
(add-to-list 'vim:initial-modes '(vc-git-log-view-mode . window))

;; Teclas de atalho do vim:
(vim:omap (kbd "C-e") 'nil)                     ;; era vim:scroll-line-down   
(vim:omap (kbd "C-t") 'vim:scroll-line-down)
(vim:imap (kbd "C-z") 'vim:insert-mode-exit)
(vim:nmap (kbd "C-r") 'nil)                     ;; era vim:cmd-redo
(vim:omap (kbd "C-u") 'nil)                     ;; movia a pagina p cima (vim:scroll-up)
(vim:omap (kbd "C-f") 'vim:scroll-up)
(vim:nmap "q" 'nil)                             ;; era vim:cmd-toggle-macro-recording
(vim:omap [tab] 'nil)