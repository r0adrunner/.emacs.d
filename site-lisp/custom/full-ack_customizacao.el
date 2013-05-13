(require 'full-ack)

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; No Debian, o nome do executável é ack-grep
(setq ack-executable (or (executable-find "ack")
                         (executable-find "ack-grep")))

;; Faz o ack perguntar sempre pelo diretório
(setq ack-prompt-for-directory t)

;; Procura em todos os tipos de arquivo: (nao eh mais valido na nova
;; versao do ack)
;; (push "-a" ack-arguments)

