(load "custom_vars_exec_path_trabalho.el")
(load-file "~/.emacs.d/site-lisp_projectile/cedet-1.0/common/cedet.el") 
(load "cedet_customizacao.el")
(load "jdee_customizacao.el")
(load "jde-usages_customizacao.el")
(load "org_customizacao_projectile.el")
(load "f_funcoes.el")
;;(load "tangotango_init.el")
(load "color-theme-zenburn.el")
(color-theme-zenburn)

;; Carrega projectile-mode
(load "projectile-mode.el")
;;Inicializa projectle-mode por padrão
(setq projectile-mode t)