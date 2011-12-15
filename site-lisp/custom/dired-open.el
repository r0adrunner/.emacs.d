(require 'dired)
(defun dired-open (&optional file-list)
  (interactive
   (list (dired-get-marked-files t current-prefix-arg)))
  (apply 'call-process "xdg-open" nil 0 nil file-list))

(define-key dired-mode-map (kbd "C-c C-c") 'dired-open)