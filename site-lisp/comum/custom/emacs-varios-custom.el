;; Desabilita o toolbar e menu
(tool-bar-mode -1)
;;(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Permite copiar e colar de outros programas.
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Normal = 400
(setq max-list-eval-depth 150000)

;; y ou n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Sem startup screen:
(setq inhibit-startup-screen t)

;;; Corrige erro com acentos (Ex: <dead-acute> is undefined)
(require 'iso-transl)

;;; Barra de menu on/off
(defun gui-on-off ()
  (interactive)
  (progn
;;    (tool-bar-mode)
    (if menu-bar-mode (menu-bar-mode -1) (menu-bar-mode))
    ;; (if scroll-bar-mode (scroll-bar-mode -1) (scroll-bar-mode))
    ))

(global-set-key (kbd "s-f") 'gui-on-off)

;;; Salvar bookmarks sempre que adicionar um
(defadvice bookmark-set (after save-bookmarks-automatically activate)
  (bookmark-save))

;;; Nomes de buffer unicos modificados em emacs 24.4
;;; Revertendo para esquema antigo:
(setq uniquify-buffer-name-style nil)
