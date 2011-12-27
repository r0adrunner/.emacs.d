(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

(defun turn-on-paredit ()
  (paredit-mode +1))

