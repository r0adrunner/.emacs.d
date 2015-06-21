(require 'lisp_parens_custom)

;; Paredit mode no emacs-lisp mode
(add-hook 'java-mode-hook 'turn-on-paredit)

;;; Usar estilo Eclipse de formatação com java-mode
;;; Adaptado de: http://stackoverflow.com/questions/805050/eclipse-indentation-on-emacs/4600811#4600811

(defconst eclipse-java-style
   ;; c-basic-offset deve ser igual a tab-width para funcionar só com tabs de identação
  '((c-basic-offset . 4)
    (indent-tabs-mode . t)
    ;; c-basic-offset deve ser igual a tab-width para funcionar só com tabs de identação
    (tab-width . 4)
    (c-comment-only-line-offset . (0 . 0))
    ;; the following preserves Javadoc starter lines
    (c-offsets-alist . ((inline-open . 0)
                        (topmost-intro-cont    . +)
                        (statement-block-intro . +)
                        (knr-argdecl-intro     . 5)
                        (substatement-open     . +)
                        (substatement-label    . +)
                        (label                 . +)
                        (statement-case-open   . +)
                        (statement-cont        . +)
                        (arglist-intro  . c-lineup-arglist-intro-after-paren)
                        (arglist-close  . c-lineup-arglist)
                        (access-label   . 0)
                        (inher-cont     . c-lineup-java-inher)
                        (func-decl-cont . c-lineup-java-throws)
                        (arglist-cont-nonempty . ++)
			(arglist-intro . +)
			(arglist-cont . +)
                        )))
  "Eclipse Java Programming Style")
(c-add-style "ECLIPSE" eclipse-java-style)

;; (customize-set-variable 'c-default-style (quote ((java-mode . "eclipse") (awk-mode . "awk") (other . "gnu"))))
(customize-set-variable 'c-default-style (quote ((java-mode . "eclipse"))))
