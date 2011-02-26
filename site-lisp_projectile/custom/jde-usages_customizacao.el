  ;; jde-usages n funciona com valores menores. Padrao: 1000
(setq max-specpdl-size 15000)


(defun jde-bsh-exit-nicely ()
  "Tells the beanshell process to terminate and waits until the process finishes up."
  (interactive)
  (if (jde-bsh-running-p)
      (let ((process (bsh-get-process (oref 'jde-bsh the-bsh))))
	(message "Shutting down beanshell process")
        (if (and
             (boundp 'jde-ant-invocation-method) ;; ant package may not be loaded.
             (string= (car jde-ant-invocation-method) "Ant Server"))
            (bsh-eval (oref 'jde-bsh the-bsh) "jde.util.JdeUtilities.exit();\n")
	  (bsh-eval (oref 'jde-bsh the-bsh) "exit();\n"))
	(message ""))))

(add-hook 'kill-emacs-hook 'jde-bsh-exit-nicely)
