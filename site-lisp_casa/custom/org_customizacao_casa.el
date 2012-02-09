(setq org-agenda-files (quote ("~/arquivos/org/victor.org" "~/arquivos/org/site.org")))

;; Org custom commands
(setq org-agenda-custom-commands
      '(("o" "Todo melhorado"
         ((agenda "" ((org-agenda-ndays 7))) ;; review upcoming deadlines and appointments
                                           ;; type "l" in the agenda to review logged items 
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("~/arquivos/org/site.org")) (org-agenda-overriding-header "SITE:")))
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("~/arquivos/org/victor.org")) (org-agenda-overriding-header "GERAIS:"))))) ;; review waiting items 
         ;; ...other commands here
        ))