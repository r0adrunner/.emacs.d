(require 'eclim)
(global-eclim-mode)

;;; Compilação
(define-key eclim-mode-map (kbd "C-c C-e c")  ; Combinação não usada
  '(lambda ()
     (interactive)
     (eclim-maven-run "compile exec:java -q -e")))

;;; Corrige um bug: O 'eclim-project-dir' é retornado sem um slash no
;;; final, causando um erro ao executar essa função
(defun eclim--maven-execute (command)
  (let ((default-directory (concat (eclim--project-dir) "/")))
    (compile (concat "mvn -f " (eclim--maven-pom-path) " " command))))


;;; Auto complete mode:

;;regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)

(setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)


;;; Company mode:

;; (require 'company)
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)
;; (global-company-mode t)
