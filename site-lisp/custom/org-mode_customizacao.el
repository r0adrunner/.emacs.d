;;ORG-MODE ----    The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook 'turn-on-font-lock)  ; Org buffers only

(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode t))
          t)

(setq org-enforce-todo-dependencies t)

;; --------------------------------------------------
(setq org-todo-keywords
      '((sequence "TODO(t)" "INICIADO(i!)" "|" "FEITO(f)" "CANCELADO(c)")
	))

(setq org-todo-keyword-faces
      '( ("CANCELADO" . (:foreground "white" :background "#777700" :weight bold))
	 ("INICIADO"  . (:foreground "light blue" :weight bold))	 
	 ))

(setq org-track-ordered-property-with-tag "ORDENADO")
(setq org-log-into-drawer "LOGBOOK")
(setq org-log-done t)

;; --------------------------------------------------
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "FEITO" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; --------------------------------------------------
;; De: http://emacs-fu.blogspot.com/2009/11/showing-pop-ups.html

;; ;; the appointment notification facility
;; (setq
;;  appt-message-warning-time 30 ;; warn x min in advance
;;  appt-display-interval 15     ;; Checa a cada x minutos
;;  appt-display-mode-line t
;;  appt-display-format 'window) ;; use our func

;;  (run-at-time nil (* 60 60 12) 'org-agenda-to-appt 'refresh) ;; Roda org-agenda-to-appt de vez em quando

;; ;; our little façade-function for notify-popup-zenity
;; (defun my-appt-display (min-to-app new-time msg)
;;   (notify-popup-notify-send "Alerta" (concat (format "Evento em %s minutos:\n\n" min-to-app) msg)
;; 		       "/usr/share/icons/gnome/32x32/status/appointment-soon.png"
;; 		       "/usr/share/sounds/ubuntu/stereo/phone-incoming-call.ogg"))

;; (setq appt-disp-window-function (function my-appt-display))
;; (appt-activate 1)              ;; active appt (appointment notification)
