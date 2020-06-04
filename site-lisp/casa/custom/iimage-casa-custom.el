;; iimg

 ;; add visual cues to code
(add-hook 'clojure-mode-hook 'enable-iimage-mode)

(defun enable-iimage-mode ()
  (iimage-mode 1)

  ;; disables image reloading on c-l
  (define-key iimage-mode-map (kbd "C-l") 'recenter-top-bottom)) ;; era 'iimage-recenter


