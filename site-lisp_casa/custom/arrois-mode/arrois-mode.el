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
     (lambda () 
       (interactive) 
       (arrois-preview-in-browser (arrois-browse-buffer-url))))
    (,(kbd "C-f i") . 
     (lambda () 
       (interactive) 
       (arrois-init)))
    )
  ;; Make mode global rather than buffer local
  :global 1)

(defcustom arrois-preview-url-generic nil "URL a abrir por padrao")

;;Muda nome do buffer para poder diferenciar entre views e models
(add-hook 'find-file-hooks 
	  '(lambda ()
	     (when (string-match "/src/arrois/\\(?:views\\|models\\|controllers\\)/.*?\\.clj$" buffer-file-name) (rename-buffer (replace-regexp-in-string ".*/\\(.*/\\)\\(.*\\.clj$\\)" "\\1\\2" buffer-file-name)))))

(defun arrois-get-whole-url (url)
  (concat "http://localhost:8080/" url))

(defun arrois-init ()
  (interactive)
  ;; Conecta o slime:
  (let ((default-directory "/home/victor/arquivos/projetos/arrois/mock_arrois/"))
    (clojure-jack-in))
  (add-hook 'slime-repl-mode-hook 'arrois-clojure-jack-in-hook-function))

(defun arrois-clojure-jack-in-hook-function ()
  (slime-load-file "/home/victor/arquivos/projetos/arrois/mock_arrois/src/arrois/server.clj")
  (remove-hook 'slime-repl-mode-hook 'arrois-clojure-jack-in-hook-function))

(defun arrois-server-start ()
  "Função para iniciar o Arrois usando lein-run. Não checa se o server está up."
  (switch-to-buffer (get-buffer-create "*arrois-server-run*"))
  (setq buffer-read-only t)
  (buffer-disable-undo)
  (let ((default-directory "/home/victor/arquivos/projetos/arrois/mock_arrois/"))
    (comint-mode)
    ;; (compilation-minor-mode t)
    (comint-exec "*arrois-server-run*" "arrois server" "lein" nil (list "run"))))

(defun arrois-preview-in-browser (url)
  (interactive)
  (let ((browse-url-generic-program "google-chrome"))
    (browse-url url)))

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