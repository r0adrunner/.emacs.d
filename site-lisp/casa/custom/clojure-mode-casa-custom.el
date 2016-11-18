(require 'clojure-mode)
(require 'clojure-mode-extra-font-locking)
(require 'lisp_parens_custom)

(add-hook 'clojure-mode-hook 'turn-on-paredit)
