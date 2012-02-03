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
    (,(kbd "C-f") . 
     (lambda () 
       (interactive) 
       (arrois-preview-in-browser (arrois-browse-buffer-url))))
    )
  ;; Make mode global rather than buffer local
  :global 1)

(defcustom arrois-preview-url-generic nil "URL a abrir por padrao")

(defun arrois-get-whole-url (url)
  (concat "http://localhost:8080/" url))

(defun arrois-preview-in-browser (url)
  (interactive)
  (let ((browse-url-generic-program "google-chrome"))
    (browse-url url)))

(defun arrois-browse-buffer-url ()
  (cond
   (arrois-preview-url-generic
    (arrois-get-whole-url arrois-preview-url-generic))

   ((string-match "views/photo.clj$" buffer-file-name)
    (arrois-get-whole-url "photo"))

   ((string-match "resources/templates/photo.html$" buffer-file-name)
    (arrois-get-whole-url "photo"))

   ((string-match "views/user.clj$" buffer-file-name)
    (arrois-get-whole-url "user"))

   ((string-match "resources/templates/newuser.html$" buffer-file-name)
    (arrois-get-whole-url "user"))

   (t
    (arrois-get-whole-url ""))
   ))