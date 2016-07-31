(require 'dired)

;;; usar xdg-open para abrir arquivos com C-c C-c
(defun dired-open (&optional file-list)
  (interactive
   (list (dired-get-marked-files t current-prefix-arg)))
  (apply 'call-process "xdg-open" nil 0 nil file-list))

(define-key dired-mode-map (kbd "C-c C-c") 'dired-open)

;;; Comando `S` para symlinks cria link absoluto por padrao (dired-do-symlink).
;;; Muda para relativos:
(define-key dired-mode-map (kbd "S") 'dired-do-relsymlink)

;;; Tamanhos de arquivos human readable
(setq dired-listing-switches "-ghG")

;;; Mostrar arquivos ocultos:
(defun dired-show-hidden-files ()
  (interactive)
  (let ((dired-actual-switches "-Alh")) (revert-buffer)))

(define-key dired-mode-map (kbd "C-M-h") 'dired-show-hidden-files)

;;; Desabilitado por padrao:
(put 'dired-find-alternate-file 'disabled nil)
