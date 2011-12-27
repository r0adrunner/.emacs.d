(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

(defun turn-on-paredit ()
  (paredit-mode +1)
  (when (require 'rainbow-delimiters nil 'noerror) 
    (rainbow-delimiters-mode)))

