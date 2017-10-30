(defun script-name (filename)
  (file-name-base filename))

(setq scripts-path "/home/victor/projetos/btrip2_base/scripts/admin-scripts/")

(defun macro-admin (filename)
  (interactive
   (list (read-file-name
	  "Macro admin script: "
	  scripts-path)))
  (let ((default-directory scripts-path))
    (shell)
    (rename-buffer (concat "*shell-" (script-name filename) "*"))
    (insert (concat "./" (file-name-nondirectory filename)))
    (comint-send-input)))
