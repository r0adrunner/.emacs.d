(require 'clojure-mode)
(add-hook 'clojure-mode-hook 'turn-on-paredit)

(define-key clojure-mode-map (kbd "C-c C-j") 'clojure-jack-in)