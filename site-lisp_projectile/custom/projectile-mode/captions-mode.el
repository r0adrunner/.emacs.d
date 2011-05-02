(load "outline-magic.el")

(add-to-list 'auto-mode-alist '("config/Captions\\.txt\\'" . captions-mode))

(defvar captions-mode-map nil "Keymap para o captions-mode")

(when (not captions-mode-map) ; if it is not already defined
  ;; assign your keyboard shortcuts
  (setq captions-mode-map (make-sparse-keymap))
  (define-key captions-mode-map (kbd "C-c m") 'captions-mode-marcar)
  (define-key captions-mode-map (kbd "C-c i") 'captions-mode-limpar))

(defun captions-mode-marcar (str)
  (interactive (list (read-from-minibuffer "String a marcar: " (replace-regexp-in-string "\\$$" "" (concat (car (if isearch-regexp regexp-search-ring search-ring)) "")))))
  (save-excursion
  (beginning-of-buffer)
  (replace-regexp (concat str "$") (quote (replace-eval-replacement concat "\\&_-DelMe_-" (number-to-string replace-count))))))

(defun captions-mode-limpar ()
  (interactive)
  (save-excursion
  (beginning-of-buffer)
  (replace-regexp "_-DelMe_-[0-9]+" "")))


;; captions-mode major mode 
(define-derived-mode captions-mode outline-mode
  (setq mode-name "Captions")
  (setq outline-regexp "___Language\\|___Category=") 
  )