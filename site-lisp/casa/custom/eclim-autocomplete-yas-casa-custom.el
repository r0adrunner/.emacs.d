(require 'eclim)
(global-eclim-mode)

(setq eclim-executable "/opt/eclipse/eclim")

;;; Corrige um bug: O 'eclim-project-dir' é retornado sem um slash no
;;; final, causando um erro ao executar essa função
(defun eclim--maven-execute (command)
  (let ((default-directory (concat (eclim--project-dir) "/")))
    (compile (concat "mvn -f " (eclim--maven-pom-path) " " command))))

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)
;; Remove Yasnippet's default tab key binding
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
;; Set Yasnippet's key binding
;; Backtab = shift + tab
(define-key yas-minor-mode-map (kbd "<backtab>") 'yas-expand)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;;;;;;;; regular auto-complete initialization
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")

;;;;;;;; Company mode:
;; (require 'company)
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)
;; (global-company-mode t)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(define-key eclim-mode-map (kbd "\C-c C-e j") 'eclim-java-show-documentation-for-current-element)
