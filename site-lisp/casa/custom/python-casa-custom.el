;; (defconst python-c-style
;;   '("python"
;;     (indent-tabs-mode . nil)
;;     (c-basic-offset . 4))
;;   "Rectified CPython style")

;; (c-add-style "python3" python-c-style)

;; ^^ Não sei usar cc-mode ...

(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
	    (setq python-indent-offset 4)))
