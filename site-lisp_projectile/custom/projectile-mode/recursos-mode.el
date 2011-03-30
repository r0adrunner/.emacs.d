; Recursos Minor Mode
(define-minor-mode recursos-mode
  "Um minor mode para gerenciar recursos na pasta /copy ou /patch ou /dist do projectile"
  ;; The initial value
  nil
  ;; The indicator for the mode line.
  nil
  ;; The minor mode keymap
  `(
    ;; Link: http://stackoverflow.com/questions/3115104/how-to-create-keybindings-for-a-custom-minor-mode-in-emacs

    (,(kbd "C-ç o") . 
     (lambda() 
       (interactive)
       (projectile-compile)))
    
    )
  ;; Make mode global?
  :global nil)

;; Associa com os nomes de arquivo:
(add-hook 'find-file-hooks 
'(lambda ()
   (when (string-match "projectile/beta/\\(?:versions\\|modules\\)/.*?/\\(?:copy\\|patch\\)\\|dist/\\(?:config\\|custom1\\|data\\)/" buffer-file-name) (recursos-mode t))))

(defun projectile-compile ()
  "Função para compilar um arquivo e copia-lo para a pasta de destino. 

Atualmente só copia, não faz patch nenhum
"
  (interactive)
  (let ((default-directory "~/develop/workspace/projectile/")
	(jde-build-function (jde-ant-build))
	(jde-ant-buildfile "testing.xml")
	(jde-ant-args (format "-emacs -Dfilename=%s -Dtarget-filename=%s -Dfilename-copy=%s compile" 
			      buffer-file-name 
			      (replace-regexp-in-string "beta/\\(?:modules\\|versions\\)/.*?/\\(?:copy\\|patch\\)/\\(.*?$\\)" "dist/\\1" buffer-file-name )
			      (replace-regexp-in-string "beta/\\(\\(?:modules\\|versions\\)/.*?\\)/patch/" "beta/\\1/copy/" buffer-file-name ))))
    (jde-build)))

(defun projectile-lista-recursos-geradores (&optional path)
  "Função para procurar automáticamente todos os arquivos que compõe um recurso."
  (interactive)
  (when (string= path nil) (setq path buffer-file-name))
  ;; É um recurso válido?
  (if (string-match "projectile/\\(?:dist/\\|beta/\\(?:versions\\|modules\\)/.*?/\\(?:copy\\|patch\\)/\\)" 
		    path)
      (progn 
	(switch-to-buffer (get-buffer-create "*Recursos*"))
	(erase-buffer)
	(setq default-directory "/home/victor/develop/workspace/projectile/")
	(widen)
	(kill-all-local-variables)
	(dired-mode "home/victor/develop/workspace/projectile/" "-l")
	(make-local-variable 'dired-sort-inhibit)
	
	(if (fboundp 'dired-simple-subdir-alist)
	    ;; will work even with nested dired format (dired-nstd.el,v 1.15
	    ;; and later)
	    (dired-simple-subdir-alist)
	  ;; else we have an ancient tree dired (or classic dired, where
	  ;; this does no harm)
	  (set (make-local-variable 'dired-subdir-alist)
	       (list (cons default-directory (point-min-marker)))))
	(setq buffer-read-only nil)
	(insert "  ~/develop/workspace/projectile/" ":\n")
	(insert "  Recursos encontrados: " "\n\n")
	(start-process-shell-command 
	 "ls recursos" 
	 (current-buffer)
	 (concat "ls " 
		 (replace-regexp-in-string 
		  "_-_ReCuRsO_-_"
		  (replace-regexp-in-string ".*?projectile/\\(?:dist/\\|beta/\\(?:versions\\|modules\\)/.*?/\\(?:copy\\|patch\\)/\\)" "" path)
		  (concat "beta/versions/standard/copy/_-_ReCuRsO_-_ "
			  "beta/modules/*/copy/_-_ReCuRsO_-_ "
			  "beta/versions/" projectile-versao-atual "/copy/_-_ReCuRsO_-_ "
			  "beta/versions/standard/patch/_-_ReCuRsO_-_ "
			  "beta/modules/*/patch/_-_ReCuRsO_-_ "
			  "beta/versions/" projectile-versao-atual "/patch/_-_ReCuRsO_-_ "
			  "dist/_-_ReCuRsO_-_ "))
		 "2> /dev/null")
	 "-gaGlU")
	(beginning-of-buffer))
    ;; Não é um recurso:
    (error (concat "O arquivo: "buffer-file-name " não é um recurso válido."))))


