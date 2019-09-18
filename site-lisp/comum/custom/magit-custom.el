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

(with-eval-after-load 'magit-revision
  (define-key magit-revision-mode-map (kbd "C-i") 'magit-section-cycle) ;;era 'magit-section-toggle
  (define-key magit-revision-mode-map (kbd "C-<tab>") nil)) ;; era 'magit-section-cycle

(with-eval-after-load 'magit-process
  (define-key magit-process-mode-map (kbd "C-i") 'magit-section-cycle) ;;era 'magit-section-toggle
  (define-key magit-process-mode-map (kbd "C-<tab>") nil)) ;; era 'magit-section-cycle

(with-eval-after-load 'magit-diff
  (define-key magit-diff-mode-map (kbd "C-i") 'magit-section-cycle) ;;era 'magit-section-toggle
  (define-key magit-diff-mode-map (kbd "C-<tab>") nil)) ;; era 'magit-section-cycle

(global-set-key (kbd "<C-tab>") 'other-window)
