(require 'rainbow-mode)

(add-hook 'css-mode-hook
	  '(lambda ()
	     (rainbow-mode))
	  )

(add-hook 'html-mode-hook
	  '(lambda ()
	     (rainbow-mode))
	  )