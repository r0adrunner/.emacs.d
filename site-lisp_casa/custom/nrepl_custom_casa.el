(require 'lisp_parens_custom)

;;; Setup paredit:
(defun setup-nrepl-paredit ()
  (define-key nrepl-mode-map
    "\C-j" 'delete-backward-char)  ; era nrepl-newline-and-indent
				   ; C-n é definido junto com paredit
				   ; para paredit-newline
  
  (define-key nrepl-mode-map
    (kbd "DEL") 'paredit-backward-delete)
  (define-key nrepl-mode-map
    (kbd "{") 'paredit-open-curly)
  (define-key nrepl-mode-map
    (kbd "}") 'paredit-close-curly)
  (modify-syntax-entry ?\{ "(}")
  (modify-syntax-entry ?\} "){")
  (modify-syntax-entry ?\[ "(]")
  (modify-syntax-entry ?\] ")[")
  (modify-syntax-entry ?~ "'   ")
  (modify-syntax-entry ?, "    ")
  (modify-syntax-entry ?^ "'")
  (modify-syntax-entry ?= "'"))

(add-hook 'nrepl-mode-hook 'turn-on-paredit)
(add-hook 'nrepl-mode-hook 'setup-nrepl-paredit)

;;; Cores no REPL:
;;; Tirado de: https://gist.github.com/337280
;;; all code in this function lifted from the clojure-mode function
;;; from clojure-mode.el
(defun clojure-font-lock-setup ()
  (interactive)
  (set (make-local-variable 'lisp-indent-function)
       'clojure-indent-function)
  (set (make-local-variable 'lisp-doc-string-elt-property)
       'clojure-doc-string-elt)
  (set (make-local-variable 'font-lock-multiline) t)

  (add-to-list 'font-lock-extend-region-functions
               'clojure-font-lock-extend-region-def t)

  (when clojure-mode-font-lock-comment-sexp
    (add-to-list 'font-lock-extend-region-functions
                 'clojure-font-lock-extend-region-comment t)
    (make-local-variable 'clojure-font-lock-keywords)
    (add-to-list 'clojure-font-lock-keywords
                 'clojure-font-lock-mark-comment t)
    (set (make-local-variable 'open-paren-in-column-0-is-defun-start) nil))

  (setq font-lock-defaults
        '(clojure-font-lock-keywords    ; keywords
          nil nil
          (("+-*/.<>=!?$%_&~^:@" . "w")) ; syntax alist
          nil
          (font-lock-mark-block-function . mark-defun)
          (font-lock-syntactic-face-function
           . lisp-font-lock-syntactic-face-function))))

(add-hook 'nrepl-mode-hook
          (lambda ()
            (font-lock-mode nil)
            (clojure-font-lock-setup)
            (font-lock-mode t)
	    (setq nrepl-use-pretty-printing 't)
            ))
