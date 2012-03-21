(setq org-agenda-files (quote ("~/arquivos/org/victor.org" "/home/victor/arquivos/projetos/arrois/doc/todo.org")))

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
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("/home/victor/arquivos/projetos/arrois/doc/todo.org"))
							      (org-agenda-overriding-header "SITE:")
		;					      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("TODO")))
							      (org-agenda-sorting-strategy '(todo-state-down priority-down)) ; Ordena por prioricade e todo keyword
							      ))
	  ;; victor.org
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("~/arquivos/org/victor.org"))
							      (org-agenda-overriding-header "GERAIS:")
		;					      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("TODO")))
							      (org-agenda-sorting-strategy '(todo-state-down priority-down)) ; Ordena por prioricade e todo keyword
							      ))))
	)
)