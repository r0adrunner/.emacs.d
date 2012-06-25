(require 'clojure-mode)
(require 'lisp_parens_custom)

(add-hook 'clojure-mode-hook 'turn-on-paredit)

(define-key clojure-mode-map (kbd "C-c C-j") 'clojure-jack-in)
(define-key clojure-mode-map (kbd "M-TAB") 'slime-complete-symbol)
