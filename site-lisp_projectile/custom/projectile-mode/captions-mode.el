(load "outline-magic.el")

(add-to-list 'auto-mode-alist '("config/Captions\\.txt\\'" . captions-mode))

;; captions-mode major mode 
(define-derived-mode captions-mode outline-mode
  (setq mode-name "Captions")
  (setq outline-regexp "___Language\\|___Category=") 
  )