(setq org-agenda-files (quote ("~/org/victor.org" "~/org/cvs.org")))

;; Org custom commands
(setq org-agenda-custom-commands
      ;; Next actions
      '(("o" "Todo list"
	 ;; review upcoming deadlines and appointments
	 ;; type "l" in the agenda to review logged items
         ((agenda "" ((org-agenda-ndays 10)
		      (org-agenda-repeating-timestamp-show-all t)
		      (org-agenda-start-on-weekday nil)
		      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("FEITO")))))
	  ;; todo.org
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("~/org/cvs.org"))
							      (org-agenda-overriding-header "ENTREVISTAS:")
		;					      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("TODO")))
							      (org-agenda-sorting-strategy '(todo-state-down priority-down)) ; Ordena por prioridade e todo keyword
							      ))
	  ;; victor.org
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("~/org/victor.org"))
							      (org-agenda-overriding-header "GERAIS:")
		;					      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("TODO")))
							      (org-agenda-sorting-strategy '(todo-state-down priority-down)) ; Ordena por prioridade e todo keyword
							      ))))
	)
)
