(setq org-agenda-files (quote ("~/org/victor.org" "~/org/apartamentos.org" "~/projetos/trading/docs/tradingtodo.org")))

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

	  ;; Arquivo org primario
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("~/org/victor.org"))
							      (org-agenda-overriding-header "GERAIS:")
							      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("IDEIA")))
							      (org-agenda-sorting-strategy '(todo-state-down priority-down)) ; Ordena por prioridade e todo keyword
							      ))

	  ;; Arquivo org aps
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("~/org/apartamentos.org"))
							      (org-agenda-overriding-header "APARTAMENTOS:")
							      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("IDEIA")))
							      (org-agenda-sorting-strategy '(todo-state-down priority-down)) ; Ordena por prioridade e todo keyword
							      ))

	  ;; Arquivo org trading
	  (tags-todo "SCHEDULED=\"\"|SCHEDULED<=\"<today>\"" ((org-agenda-files '("~/projetos/trading/docs/tradingtodo.org"))
							      (org-agenda-overriding-header "TRADING:")
							      (org-agenda-skip-function '(org-agenda-skip-entry-if 'todo '("IDEIA")))
							      (org-agenda-sorting-strategy '(todo-state-down priority-down)) ; Ordena por prioridade e todo keyword
							      ))
	  )
	 )
	)
      )
