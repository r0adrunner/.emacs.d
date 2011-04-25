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

    (,(kbd "C-ç s o") . 
     (lambda () 
       (interactive) 
       (projectile-stop)))

    (,(kbd "C-ç b") . 
     (lambda () 
       (interactive) 
       (projectile-stop-build nil)))
 
    (,(kbd "C-ç C-b") . 
     (lambda () 
       (interactive) 
       (projectile-stop-build t)))

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

;; Usado em projectile-restart e projectile-stop-build:
(setq projectile-deve-reiniciar nil)
(setq projectile-deve-refazer nil)
(setq projectile-continua-compilando-depois-de-refazer nil)

(defvar projectile-versao-atual "vertrieb_brasil" "*A versão atual do projectile sendo usada")

;; Filtro para o output do compilation buffer.
(add-hook 'comint-output-filter-functions 
	  '(lambda(txt)
	     (cond 
	      ((string-match "BUILD FAILED" txt)
	       ;; Compilação falhou:
	       (projectile-muda-status "inativo"))
	      ((string-match "INFO: Stopping Coyote" txt)
	       ;; Projectile parou:
	       (projectile-muda-status "inativo"))
	      ((string-match "INFO: Server startup in" txt) 
	       ;; Projectile iniciou:
	       (projectile-muda-status "ativo")))))

(defun projectile-process-sentinel (process event)
  "Process sentinel p o pjt server"
  (when (string= event "finished\n")
    ;; projectile compilou com sucesso:
    (unless projectile-continua-compilando-depois-de-refazer 
      (projectile-muda-status "inativo")))
  (when (string= event "interrupt\n")
    (projectile-muda-status "inativo")
    (when projectile-deve-reiniciar
      ;; Deve reiniciar?
      (progn
	(setq projectile-deve-reiniciar nil)
	(save-window-excursion (projectile-start))))
    (when projectile-deve-refazer
      (progn
	(setq projectile-deve-refazer nil)
	(save-window-excursion (projectile-build))))))

(defun projectile-start ()
  "Função para iniciar o Projectile. Não checa se o server está up."
  (switch-to-buffer (get-buffer-create "*projectile-server-run*"))
  (let ((default-directory "/home/victor/develop/workspace/projectile/"))
    (comint-mode)
    (compilation-minor-mode t)
    (projectile-muda-status "carregando")
    (comint-exec "*projectile-server-run*" "projectile server" "/home/victor/develop/workspace/projectile/dist/projectile" nil nil)
   (set-process-sentinel (get-process "projectile server") 'projectile-process-sentinel)))

(defun projectile-stop ()
  "Manda um sinal de interrupt para o processo do projectile"
  (interactive)
  (when (get-buffer "*projectile-server-run*")
    (projectile-muda-status "carregando")
    (set-buffer "*projectile-server-run*")
    (erase-buffer)
    (comint-interrupt-subjob)))

(defun projectile-restart ()
  "Reinicia o servidor que roda o projectile"
  (interactive)
  (save-window-excursion
    (switch-to-buffer (get-buffer-create "*projectile-server-run*"))
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
  "Função para refazer e, dependendo do valor de start, iniciar o Projectile. Não checa se o server está up."
  (switch-to-buffer (get-buffer-create "*projectile-server-run*"))
  (let ((default-directory "/home/victor/develop/workspace/projectile/"))
    (comint-mode)
    (compilation-minor-mode t)
    (projectile-muda-status "carregando")
    (comint-exec "*projectile-server-run*" 
		 "projectile server" 
		 (if projectile-continua-compilando-depois-de-refazer "/home/victor/develop/workspace/projectile/pjtbuildrun" "ant")
		 nil
		 (list "-buildfile" "/home/victor/develop/workspace/projectile/build_victor.xml" "-emacs" (format "-Dversion=%s" projectile-versao-atual) "clean" "dist"))
    (set-process-sentinel (get-process "projectile server") 'projectile-process-sentinel)))

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

(defun projectile-stop-build (start)
  "Para o servidor, recompila o projectile e, dependendo do valor de start, reinicia o servidor"
  (interactive)
  (save-window-excursion
    (setq projectile-continua-compilando-depois-de-refazer start)
    (switch-to-buffer (get-buffer-create "*projectile-server-run*"))
    (if (not (get-buffer-process (current-buffer)))
	(projectile-build)
      (progn (setq projectile-deve-refazer t)
	     (projectile-muda-status "carregando")
	     (projectile-stop)))))

;; Cores de fonte para o mode-line "PJT"
(defface ativo
  `((t (:foreground "green" :weight bold)))
  "Face usada quando o server do projectile está ativo.")

(defface carregando
  `((t (:foreground "yellow" :weight bold)))
  "Face usada quando o server do projectile está carregando.")

(defface inativo
  `((t (:foreground "red" :weight bold)))
  "Face usada quando o server do projectile está inativo.")

;; Inicia a mode-line com o PJT inativo
(projectile-muda-status "inativo")