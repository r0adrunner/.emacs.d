(require 'magit)

(eval-after-load 'magit
  '(progn
     ;; (set-face-foreground 'magit-diff-added "green3")
     ;; (set-face-foreground 'magit-diff-removed "red3")
     (when (not window-system)
       ;; (set-face-background 'magit-item-highlight "black")
       )))

(with-eval-after-load 'magit-status
  (define-key magit-status-mode-map (kbd "C-i") 'magit-section-cycle) ;;era 'magit-section-toggle
  (define-key magit-status-mode-map (kbd "C-<tab>") nil)) ;; era 'magit-section-cycle
