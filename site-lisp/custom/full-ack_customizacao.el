;;(add-to-list 'load-path "./site-lisp/full-ack.el")

(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; No Debian, o nome do executável é ack-grep
(setq ack-executable (or (executable-find "ack")
                         (executable-find "ack-grep")))

;;Faz ele perguntar pelo diretório
(setq ack-prompt-for-directory t)

;; Muda a lista de argumentos
(defun ack-arguments-from-options (regexp)
  (let ((arguments (list "--color"
                         (ack-option "smart-case" (eq ack-ignore-case 'smart))
                         (ack-option "heading" ack-heading)
                         (ack-option "env" ack-use-environment))))
    (unless ack-ignore-case
      (push "-i" arguments))
    ;; -a Faz ele procurar em todos os tipos de arquivo
    (push "-a" arguments)
    (unless regexp
      (push "--literal" arguments))
    (push (format "--context=%d" ack-context) arguments)
    arguments))