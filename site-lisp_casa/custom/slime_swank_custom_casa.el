;;; Slime

(load "slime-c3230b2c.el")
(load "slime-repl-79b38c83.el")

(require 'slime-repl)

(defun setup-slime-repl-paredit ()
  (define-key slime-repl-mode-map
    (kbd "DEL") 'paredit-backward-delete)
  (define-key slime-repl-mode-map
    (kbd "{") 'paredit-open-curly)
  (define-key slime-repl-mode-map
    (kbd "}") 'paredit-close-curly)
  (modify-syntax-entry ?\{ "(}")
  (modify-syntax-entry ?\} "){")
  (modify-syntax-entry ?\[ "(]")
  (modify-syntax-entry ?\] ")[")
  (modify-syntax-entry ?~ "'   ")
  (modify-syntax-entry ?, "    ")
  (modify-syntax-entry ?^ "'")
  (modify-syntax-entry ?= "'"))

(add-hook 'slime-repl-mode-hook 'turn-on-paredit)
(add-hook 'slime-repl-mode-hook 'setup-slime-repl-paredit)

;;; Syntax highlighting
(add-hook 'slime-repl-mode-hook
          (defun clojure-mode-slime-font-lock ()
            (let (font-lock-mode)
              (clojure-mode-font-lock-setup))))

(define-key slime-repl-mode-map  "\C-j" 'delete-backward-char) ; era slime-repl-newline-and-indent
(define-key slime-repl-mode-map  "\C-o" 'slime-repl-newline-and-indent) ; era newline-and-indent

