(defun barras-on-off ()
  (interactive)
  (progn
;;    (tool-bar-mode)
    (menu-bar-mode) 
    (scroll-bar-mode)))

(global-set-key (kbd "s-t") 'barras-on-off)
