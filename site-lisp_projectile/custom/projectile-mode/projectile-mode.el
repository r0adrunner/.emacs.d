;; Projectile Minor Mode
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

    (,(kbd "C-ç o") . 
     (lambda() 
       (interactive)
       (projectile-compile)))
    )
  ;; Make mode global rather than buffer local
  :global 1)

;; Tenta abrir tudo em Latin-1
(setq file-coding-system-alist
      (append '(("develop/workspace/projectile" latin-1-unix . latin-1-unix))
	      '(("develop/workspace/bsm" latin-1-unix . latin-1-unix))
	      '(("develop/workspace/jmodel2" latin-1-unix . latin-1-unix))
	      file-coding-system-alist))

;; Captions Mode
(load "captions-mode.el")
(add-to-list 'auto-mode-alist '("config/Captions\\.txt\\'" . captions-mode))

(defvar projectile-deve-reiniciar nil "Usado em projectile-restart. Projectile deve reiniciar automáticamente ao parar?")

;; Filtro para o output do compilation buffer.
(add-hook 'comint-output-filter-functions 
     '(lambda(txt) 
	(progn
	  (if (and (string-match "INFO: Stopping Coyote" txt) projectile-deve-reiniciar)
	      (progn 
		;;(sleep-for 1)
		(delete-process (get-buffer-process (current-buffer)) )
		(setq projectile-deve-reiniciar nil)
		(save-window-excursion (projectile-start))
		;;(delete-windows-on (get-buffer "*Projectile-server-run*")
		))
	  (if (string-match "INFO: Server startup in" txt)
	      (progn (message "Projectile foi iniciado.") 
		     ;;(delete-windows-on (get-buffer "*Projectile-server-run*"))
		     )))))

(defun projectile-start ()
  "Função para começar o Projectile."
  (interactive)
  (let ((default-directory "~/develop/workspace/projectile/")
	(compilation-buffer-name-function
         (function
          (lambda(ign)
            "*Projectile-server-run*"))))
    (compilation-start "dist/projectile" t)))

(defun projectile-stop ()
  "Manda um sinal de interrupt para o processo do projectile"
  (interactive)
  (set-buffer "*Projectile-server-run*")
  (comint-interrupt-subjob))

(defun projectile-restart ()
  "Reinicia o servidor que roda o projectile"
  (interactive)
  (set-buffer "*Projectile-server-run*")
  (if (not (get-buffer-process (current-buffer)))
      (projectile-start)
    (progn (setq projectile-deve-reiniciar t)
	   (projectile-stop))))

(defun projectile-bsm-build ()
  "Função para chamar a função JDE ant build com devido default-directory."
  (interactive)
  (let ((default-directory "~/develop/workspace/bsm/")
	(jde-build-function '(jde-ant-build))
	(jde-ant-buildfile "build_latin1.xml")
	(jde-ant-args "-emacs projectile"))
    (jde-build)))

(defun projectile-build ()
  "Função para chamar a função JDE ant build com devido default-directory."
  (interactive)
  (let ((default-directory "~/develop/workspace/projectile/")
	(jde-build-function '(jde-ant-build))
	(jde-ant-buildfile "build_latin1.xml")
	(jde-ant-args "-emacs -Dversion=vertrieb_brasil clean dist")
	;;(default-process-coding-system '(latin-1-unix . latin-1-unix))
	(coding-system-for-write 'latin-1-unix)
	(coding-system-for-read 'latin-1-unix)
	(compilation-buffer-name-function
         (function
          (lambda(ign)
            "*Projectile ant build*"))))
    (jde-build)))

(defun projectile-compile ()
  "Função para compilar um arquivo e copia-lo para a pasta de destino."
  (interactive)
  (let ((default-directory "~/develop/workspace/projectile/")
	(jde-build-function '(jde-ant-build))
	(jde-ant-buildfile "testing.xml")
	(jde-ant-args (format "-emacs -Dfilename=%s -Dtarget-filename=%s compile" 
			      buffer-file-name 
			      (replace-regexp-in-string "beta/versions/.*?/copy/\\(.*?$\\)" "dist/\\1" buffer-file-name ))))
    (jde-build)))

