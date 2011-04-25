;; make cursor movement keys under right hand's home-row.
(global-set-key (kbd "M-i") 'previous-line) ; was tab-to-tab-stop
(global-set-key (kbd "M-j") 'backward-char) ; was indent-new-comment-line
(global-set-key (kbd "M-k") 'next-line) ; was kill-sentence
(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-word

(global-set-key (kbd "<C-tab>") 'other-window)

;; Switch buffer:
(iswitchb-mode t)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Dired:
(global-set-key (kbd "C-x C-d") 'dired)

;; Revert buffer:
(global-set-key (kbd "C-x r e") 'revert-buffer)

;; Org-mode:
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))

;; Mover linhas p cima e p baixo estilo Eclipse
(defun move-text-internal (arg) 
  (cond 
   ((and mark-active transient-mark-mode) 
    (if (> (point) (mark)) 
        (exchange-point-and-mark)) 
    (let ((column (current-column)) 
          (text (delete-and-extract-region (point) (mark)))) 
      (forward-line arg) 
      (move-to-column column t) 
      (set-mark (point)) 
      (insert text) 
      (exchange-point-and-mark) 
      (setq deactivate-mark nil))) 
   (t 
    (beginning-of-line) 
    (when (or (> arg 0) (not (bobp))) 
      (forward-line) 
      (when (or (< arg 0) (not (eobp))) 
        (transpose-lines arg)) 
      (forward-line -1)))))
(defun move-text-down (arg) 
  "Move region (transient-mark-mode active) or current line 
  arg lines down." 
  (interactive "*p") 
  (move-text-internal arg))
(defun move-text-up (arg) 
  "Move region (transient-mark-mode active) or current line 
  arg lines up." 
  (interactive "*p") 
  (move-text-internal (- arg)))

(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)