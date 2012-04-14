(define-minor-mode arrois-mode
  "Um minor mode para me ajudar a programar o Arrois"
  ;; The initial value - Set to 1 to enable by default, nil not to
  1
  ;; The indicator for the mode line.
  nil
  ;; The minor mode keymap
  ;; Link: http://stackoverflow.com/questions/3115104/how-to-create-keybindings-for-a-custom-minor-mode-in-emacs
  `(
    ;; Link: http://stackoverflow.com/questions/3115104/how-to-create-keybindings-for-a-custom-minor-mode-in-emacs
    (,(kbd "C-b") . 
     (lambda (arg) 
       (interactive "P") 
       (arrois-preview arg (arrois-browse-buffer-url))))
    (,(kbd "C-f b") . 
     (lambda (arg) 
       (interactive "P") 
       (arrois-save-and-preview arg (arrois-browse-buffer-url))))
    (,(kbd "C-f i") . 
     (lambda () 
       (interactive) 
       (arrois-init)))
    )
  ;; Make mode global rather than buffer local
  :global 1)

(defcustom arrois-preview-url-generic nil "URL a abrir por padrao")

;;; Inicia mongod por padrao?
(setq arrois-inicia-mongod nil)

;;Muda nome do buffer para poder diferenciar entre views e models
(add-hook 'find-file-hooks 
	  '(lambda ()
	     (when (string-match "/src/arrois/\\(?:views\\|models\\|controllers\\)/.*?\\.clj$" buffer-file-name) (rename-buffer (replace-regexp-in-string ".*/\\(.*/\\)\\(.*\\.clj$\\)" "\\1\\2" buffer-file-name)))))

(defun arrois-get-whole-url (url)
  (concat "http://localhost:8080/" url))

(defun arrois-start-mongod ()
  "Inicia mongod"
  (save-window-excursion
    (switch-to-buffer (get-buffer-create "*mongod-run*"))
    (setq buffer-read-only t)
    (buffer-disable-undo)
    (comint-mode)
    (comint-exec "*mongod-run*" "mongod server" "mongod" nil nil)))

(defun arrois-init ()
  (interactive)
  ;; Conecta o slime:
  (let ((default-directory "/home/victor/arquivos/projetos/arrois/arrois/"))
    (clojure-jack-in))
  (add-hook 'slime-repl-mode-hook 'arrois-done-loading-repl-hook-function)
  (when arrois-inicia-mongod (arrois-start-mongod)))

(defun arrois-done-loading-repl-hook-function ()
  (arrois-server-start)
  (remove-hook 'slime-repl-mode-hook 'arrois-clojure-jack-in-hook-function))

(defun arrois-server-start ()
  (interactive)
  "Função para iniciar o Arrois usando slime. Assume que slime ja esta iniciado"
  (slime-load-file "/home/victor/arquivos/projetos/arrois/arrois/src/arrois/startserver.clj")
  )


(defun arrois-preview (preview-out-to-buffer url)
  "preview-out-to-buffer: t-> open url in browser, nil-> show html in buffer *preview-output*"
  (interactive)
  (if preview-out-to-buffer
      ;; Directs output of preview page to a special buffer
      (progn
	(set-buffer (get-buffer-create "*preview-output*"))
	(buffer-disable-undo)
	;;(setq buffer-read-only t)
	(shell-command (concat "curl --silent " url) "*preview-output*")
	(html-mode)
	(buffer-enable-undo))
    ;; Opens a browser
    (let ((browse-url-generic-program "google-chrome"))
      (browse-url url))))

;;; Salva o buffer e preview no browser
(defun arrois-save-and-preview (preview-out-to-buffer url)
  "preview-out-to-buffer: t-> open url in browser, nil-> show html in buffer *preview-output*"  
  (interactive)
  (save-buffer)
  (arrois-preview preview-out-to-buffer url))


;;; Mudado para hacks.el (fora do controle de versao)
;; (defun arrois-browse-buffer-url ()
;;   (let ((nome-buffer (or buffer-file-name "")))
;;       (cond
;;        (arrois-preview-url-generic
;; 	(arrois-get-whole-url (or arrois-preview-url-generic "")))

;;        ((string-match "views/photo.clj$" nome-buffer)
;; 	(arrois-get-whole-url "photo"))

;;        ((string-match "resources/templates/photo.html$" nome-buffer)
;; 	(arrois-get-whole-url "photo"))

;;        ((string-match "views/user.clj$" nome-buffer)
;; 	(arrois-get-whole-url "newuser"))

;;        ((string-match "resources/templates/newuser.html$" nome-buffer)
;; 	(arrois-get-whole-url "newuser"))

;;        (t
;; 	(arrois-get-whole-url ""))
;;        )))
