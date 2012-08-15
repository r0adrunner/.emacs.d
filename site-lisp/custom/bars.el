(defun gui-on-off ()
  (interactive)
  (progn
;;    (tool-bar-mode)
    (if menu-bar-mode (menu-bar-mode -1) (menu-bar-mode))
    ;; (if scroll-bar-mode (scroll-bar-mode -1) (scroll-bar-mode))
    ))

(global-set-key (kbd "s-f") 'gui-on-off)
