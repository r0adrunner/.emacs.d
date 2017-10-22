(require 'clojure-mode)
(require 'clojure-mode-extra-font-locking)
(require 'lisp_parens_custom)
(require 'clj-refactor)

(defun clj-refactor-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

(add-hook 'clojure-mode-hook #'clj-refactor-clojure-mode-hook)

(add-hook 'clojure-mode-hook 'turn-on-paredit)
