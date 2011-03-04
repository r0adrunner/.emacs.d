(load "outline-magic.el")

;; captions-mode major mode 
(define-derived-mode captions-mode outline-mode
  (setq mode-name "Captions")
  (setq outline-regexp "___Language\\|___Category=") 
  )