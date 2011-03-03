(global-set-key (kbd "<C-tab>") 'other-window)
(iswitchb-mode t)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Org-mode:
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))