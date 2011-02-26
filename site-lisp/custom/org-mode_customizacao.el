;;ORG-MODE ----    The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t))
          t)



(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "FEITO(f)" "CANCELADO(c)")
	))

(setq org-todo-keyword-faces
      '( ("CANCELADO" . (:foreground "white" :background "#777700" :weight bold))
	 ))


     (defun org-summary-todo (n-done n-not-done)
       "Switch entry to DONE when all subentries are done, to TODO otherwise."
       (let (org-log-done org-log-states)   ; turn off logging
         (org-todo (if (= n-not-done 0) "FEITO" "TODO"))))
     
     (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

