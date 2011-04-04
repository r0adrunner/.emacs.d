;; Projectile global Minor Mode
(define-minor-mode projectile-mode
  "Um minor mode para me ajudar a programar o Projectile"
  ;; The initial value
  nil
  ;; The indicator for the mode line.
  nil
  ;; The minor mode keymap
  `(
    ;; Link: http://stackoverflow.com/questions/3115104/how-to-create-keybindings-for-a-custom-minor-mode-in-emacs
    (,(kbd "C-ç c") . 
     (lambda () 
       (interactive) 
       (find-file "~/develop/workspace/projectile/beta/versions/standard/copy/config/Captions.txt")))

    (,(kbd "C-ç s r") . 
     (lambda () 
       (interactive) 
       (projectile-restart)))

    )
  ;; Make mode global rather than buffer local
  :global 1)

;; Carrega módulos 
;; Captions Mode
(load "captions-mode.el")
;; Recursos Mode
(load "recursos-mode.el")

;; Tenta abrir tudo em Latin-1
(setq file-coding-system-alist
      (append '(("develop/workspace/projectile" latin-1-unix . latin-1-unix))
	      '(("develop/workspace/bsm" latin-1-unix . latin-1-unix))
	      '(("develop/workspace/jmodel2" latin-1-unix . latin-1-unix))
	      file-coding-system-alist))

(defvar projectile-deve-reiniciar nil "Usado em projectile-restart. Projectile deve reiniciar automáticamente ao parar?")

(defvar projectile-versao-atual "vertrieb_brasil" "*A versão atual do projectile sendo usada")

;; Filtro para o output do compilation buffer.
(add-hook 'comint-output-filter-functions 
	  '(lambda(txt) 
	     (cond ((string-match "INFO: Stopping Coyote" txt)
		    ;; Projectile parou:
		    (projectile-muda-status "inativo"))
		   ;; Projectile iniciou:
		   ((string-match "INFO: Server startup in" txt) 
		    (projectile-muda-status "ativo")))))

(defun projectile-start ()
  "Função para começar o Projectile."
  (interactive)
  (let ((default-directory "/home/victor/develop/workspace/projectile/"))
    (switch-to-buffer (get-buffer-create "*Projectile-server-run*"))
    (comint-mode)
    (compilation-minor-mode t)
    (projectile-muda-status "carregando")
    (comint-exec "*Projectile-server-run*" "projectile server" "/home/victor/develop/workspace/projectile/dist/projectile" nil nil)
   (set-process-sentinel (get-process "projectile server") 'projectile-process-sentinel)))

(defun projectile-process-sentinel (process event)
  "Process sentinel p o pjt server"
  (when (and projectile-deve-reiniciar (string= event "interrupt\n")) 
    ;; Deve reiniciar?
    (progn
      (setq projectile-deve-reiniciar nil)
      (save-window-excursion (projectile-start)))))

(defun projectile-stop ()
  "Manda um sinal de interrupt para o processo do projectile"
  (interactive)
  (projectile-muda-status "carregando")
  (set-buffer "*Projectile-server-run*")
  (comint-interrupt-subjob))

(defun projectile-restart ()
  "Reinicia o servidor que roda o projectile"
  (interactive)
  (save-window-excursion
    (switch-to-buffer (get-buffer-create "*Projectile-server-run*"))
    (if (not (get-buffer-process (current-buffer)))
	(projectile-start)
      (progn (setq projectile-deve-reiniciar t)
	     (projectile-muda-status "carregando")
	     (projectile-stop)))))

(defun projectile-bsm-build ()
  "Função para chamar a função JDE ant build com devido default-directory."
  (interactive)
  (let ((default-directory "/home/victor/develop/workspace/bsm/")
	(jde-build-function '(jde-ant-build))
	(jde-ant-buildfile "build_victor.xml")
	(jde-ant-args "-emacs projectile"))
    (jde-build)))

(defun projectile-build ()
  "Função para chamar a função JDE ant build com devido default-directory."
  (interactive)
  (let ((default-directory "/home/victor/develop/workspace/projectile/")
	(jde-build-function '(jde-ant-build))
	(jde-ant-buildfile "build_victor.xml")
	(jde-ant-args (format "-emacs -Dversion=%s clean dist" projectile-versao-atual))
	;;(default-process-coding-system '(latin-1-unix . latin-1-unix))
	(coding-system-for-write 'latin-1-unix)
	(coding-system-for-read 'latin-1-unix)
	(compilation-buffer-name-function
         (function
          (lambda(ign)
            "*Projectile ant build*"))))
    (jde-build)))

(defun projectile-muda-status (status)
  "Muda a mode-line de acordo com o status do servidor do Projectile"
  (interactive)
  (setq minor-mode-alist (assq-delete-all 'projectile-mode minor-mode-alist))
  (cond
   ((string= status "ativo") 
    (setq minor-mode-alist (cons '(projectile-mode #(" PJT" 0 3 (face ativo))) minor-mode-alist)))
   ((string= status "inativo") 
    (setq minor-mode-alist (cons '(projectile-mode #(" PJT" 0 3 (face inativo))) minor-mode-alist)))
   ((string= status "carregando") 
    (setq minor-mode-alist (cons '(projectile-mode #(" PJT" 0 3 (face carregando))) minor-mode-alist)))))

;; Cores de fonte para o mode-line "PJT"
(defface ativo
  `((t (:foreground "green" :weight bold)))
  "Face usada quando o server do projectile está ativo.")

(defface carregando
  `((t (:foreground "yellow" :weight bold)))
  "Face usada quando o server do projectile está ativo.")

(defface inativo
  `((t (:foreground "red" :weight bold)))
  "Face usada quando o server do projectile está ativo.")

;; Inicia a mode-line com o PJT inativo
(projectile-muda-status "inativo")