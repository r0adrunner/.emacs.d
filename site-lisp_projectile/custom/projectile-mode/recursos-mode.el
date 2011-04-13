;; Recursos Minor Mode
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
       (projectile-recursos-compile nil)))

    (,(kbd "C-ç C-o") . 
     (lambda() 
       (interactive)
       (projectile-recursos-compile t)))

    (,(kbd "C-ç r") . 
     (lambda() 
       (interactive)
       (projectile-recursos-relacionados)))
    
    )
  ;; Make mode global?
  :global nil)

;; Associa com os nomes de arquivo:
(add-hook 'find-file-hooks 
	  '(lambda ()
	     (when (string-match "projectile/beta/versions/standard/java/.*?\\.java$\\|/workspace/bsm/\\|projectile/beta/\\(?:versions\\|modules\\)/.*?/\\(?:copy\\|patch\\)\\\|projectile/dist/\\(?:config\\|custom1\\|data\\)/" buffer-file-name) (recursos-mode t))))

;; Usado em projectile-recursos-compile-restart
(setq projectile-recursos-deve-reiniciar nil)

(defun projectile-recursos-compile (&optional restart path)
  "Função para compilar um recurso de acordo com seu tipo, e reiniciar o server se necessário."
  (interactive)
  (when (string= path nil) (setq path buffer-file-name))  
  (let (default-directory nome-do-arquivo arquivo-destino target buildfile)
    (setq buildfile "/home/victor/develop/workspace/projectile/testing.xml" 
	  default-directory "/home/victor/develop/workspace/projectile/"
	  nome-do-arquivo path
	  projectile-recursos-deve-reiniciar nil)
    (cond 
     ;; ATENÇÃO: A ordem é importante

     ;; Captions.txt
     ((string-match "/config/Captions.txt$" path)
      (setq target (list "copia")
	    arquivo-destino (replace-regexp-in-string "/projectile/dist/\\|/projectile/beta/\\(?:modules\\|versions\\)/.*?/\\(?:copy\\|patch\\)/\\(.*?$\\)" "/projectile/dist/\\1" nome-do-arquivo)))

     ;; Recurso java. Chama Javac e restarta server.
     ((string-match "/projectile/beta/versions/standard/java/.*?\\.java$" path)
      (setq target (list "javac")
	    buildfile "/home/victor/develop/workspace/projectile/build_victor.xml" 
	    projectile-recursos-deve-reiniciar t))

     ;; Recurso projectile (ATENÇÂO: SOMENTE COPIA O ARQUIVO, NÃO FAZ PATCH)
     ((string-match "/projectile/beta/\\(?:modules\\|versions\\)/.*?/\\(?:copy\\)/\\(.*?$\\)" path)
      (setq target (list "copia" "checktables")
	    arquivo-destino (replace-regexp-in-string "/projectile/dist/\\|/projectile/beta/\\(?:modules\\|versions\\)/.*?/\\(?:copy\\|patch\\)/\\(.*?$\\)" "/projectile/dist/\\1" nome-do-arquivo)
	    projectile-recursos-deve-reiniciar t))

     ;; Recurso dist (só checktables + restart)
     ((string-match "/projectile/dist/" path)
       (setq target (list "checktables")
	    projectile-recursos-deve-reiniciar t))

     ;; Recurso BSM:
     ((string-match "/workspace/bsm/" path)
      (setq target (list "projectile")
	    buildfile "/home/victor/develop/workspace/bsm/build_victor.xml" 
	    projectile-recursos-deve-reiniciar t))
     )

    ;; Reinicia o pjt somente se precisar, E se explícitamente definido nos parâmetros:
    (setq projectile-recursos-deve-reiniciar (and projectile-recursos-deve-reiniciar restart))
    (when projectile-recursos-deve-reiniciar (projectile-stop))
    (save-window-excursion 
      (switch-to-buffer (get-buffer-create "*projectile-compilation*"))
      (erase-buffer)
      (comint-mode)
      (compilation-minor-mode t)
      (comint-exec "*projectile-compilation*" "projectile compilation" "ant" nil 
		   (append (list "-buildfile" buildfile (format "-Dnome-do-arquivo=%s" nome-do-arquivo) (format "-Darquivo-destino=%s" arquivo-destino) "-emacs" ) target)))
      (set-process-sentinel (get-process "projectile compilation") 'projectile-recursos-process-sentinel)))

(defun projectile-recursos-process-sentinel (process event)
  "Process sentinel p o processo de compilação"
  (when (string= event "finished\n")
    ;; O recurso terminou de compilar:
    (when projectile-recursos-deve-reiniciar 
      (setq projectile-recursos-deve-reiniciar nil)
      (projectile-restart))))


(defun projectile-recursos-relacionados (&optional path)
  "Função para procurar automáticamente todos os arquivos relacionados a um recurso."
  (interactive)
  (when (string= path nil) (setq path buffer-file-name))
  ;; É um recurso válido?
  (if (string-match "projectile/\\(?:dist/\\|beta/\\(?:versions\\|modules\\)/.*?/\\(?:copy\\|patch\\)/\\)" 
		    path)
      (progn 
	(switch-to-buffer (get-buffer-create "*Recursos*"))
	(erase-buffer)
	(setq default-directory "/home/victor/develop/workspace/projectile/")
	(kill-all-local-variables)
	(dired-mode "/home/victor/develop/workspace/projectile/" "-l")
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
		  (format "beta/versions/standard/copy/_-_ReCuRsO_-_ beta/modules/*/copy/_-_ReCuRsO_-_ beta/versions/%s/copy/_-_ReCuRsO_-_ beta/versions/standard/patch/_-_ReCuRsO_-_ beta/modules/*/patch/_-_ReCuRsO_-_ beta/versions/%s/patch/_-_ReCuRsO_-_ dist/_-_ReCuRsO_-_ " projectile-versao-atual projectile-versao-atual))
		 "2> /dev/null")
	 "-gaGlU")
	(beginning-of-buffer))
    ;; Não é um recurso:
    (error (concat "O arquivo: "buffer-file-name " não é um recurso válido."))))


