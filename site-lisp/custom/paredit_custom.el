(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

(defun turn-on-paredit ()
  (paredit-mode +1)
  (require 'highlight-parentheses)
  (highlight-parentheses-mode t)
  (show-paren-mode t)
  )

