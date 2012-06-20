(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)

(defun turn-on-paredit ()
  (paredit-mode +1)
  (lispy-parens))

(defun lispy-parens ()
  "Setup parens display for lisp modes"
  (setq show-paren-delay 0)
  (setq show-paren-style 'parenthesis)
  (make-variable-buffer-local 'show-paren-mode)
  (show-paren-mode 1)
  ;; (set-face-background 'show-paren-match-face (face-background 'default))
  ;; (if (boundp 'font-lock-comment-face)
  ;;     (set-face-foreground 'show-paren-match-face 
  ;;    			   (face-foreground 'font-lock-comment-face))
  ;;   (set-face-foreground 'show-paren-match-face 
  ;;    			 (face-foreground 'default)))
  ;; (set-face-attribute 'show-paren-match-face nil :weight 'extra-bold)
  )

;; custom paredit
(eval-after-load 'paredit
  '(progn
    (define-key paredit-mode-map (kbd "C-j")   'paredit-backward-delete)
    (define-key paredit-mode-map (kbd "C-M-j")   'paredit-backward-kill-word)
    (define-key paredit-mode-map (kbd "C-o")   'paredit-newline)))

(provide 'lisp_parens_custom)
