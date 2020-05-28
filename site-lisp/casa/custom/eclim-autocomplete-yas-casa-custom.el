(require 'eclim)
(global-eclim-mode)

(setq eclim-executable "/opt/eclipse/eclim")

;; Corrige (sobrescrevendo) eclim-problems-correct atual (emacs-eclim-20150703.651).
;; Agora, pode ser chamado do buffer 'eclim: problems' com tecla 'c'
(defun eclim-problems-correct ()
  (interactive)
  (let ((p (eclim--problems-get-current-problem)))
    (if (not (string-match "\\.\\(groovy\\|java\\)$" (cdr (assoc 'filename p))))
        (error "Not a Java or Groovy file. Corrections are currently supported only for Java or Groovy.")
      (eclim-problems-open-current)
      (eclim-java-correct (cdr (assoc 'line p)) (eclim--byte-offset)))))

;; Copia da versao atual (emacs-eclim-20150703.651) upstream de 'eclim-problems-correct'
;; Para ser chamado do buffer java
(defun eclim-problems-correct-from-java-buffer ()
  (interactive)
  (let ((p (eclim--problems-get-current-problem)))
    (if (not (string-match "\\.\\(groovy\\|java\\)$" (cdr (assoc 'filename p))))
        (error "Not a Java or Groovy file. Corrections are currently supported only for Java or Groovy.")
      (eclim-java-correct (cdr (assoc 'line p)) (eclim--byte-offset)))))

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
;; https://stackoverflow.com/questions/15774807/emacs-24-autocomplete-yasnippet
(setq ac-source-yasnippet nil)

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

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;; Exemplo Company mode:
;; (require 'company)
;; (require 'company-emacs-eclim)
;; (company-emacs-eclim-setup)
;; (global-company-mode t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Custom keys
(define-key eclim-mode-map (kbd "\C-c C-e j") 'eclim-java-show-documentation-for-current-element)
(define-key eclim-mode-map (kbd "\C-c C-e c") 'eclim-problems-correct-from-java-buffer)
