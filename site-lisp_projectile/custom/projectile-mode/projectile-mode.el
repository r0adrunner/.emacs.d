;; Projectile Minor Mode
(define-minor-mode projectile-mode
  "Um minor mode para me ajudar a programar o Projectile"
  ;; The initial value
  nil
  ;; The indicator for the mode line.
  nil
  ;; The minor mode keymap
  `(
    ;; Link: http://stackoverflow.com/questions/3115104/how-to-create-keybindings-for-a-custom-minor-mode-in-emacs
    (,(kbd "C-c p c") . 
     (lambda () (interactive) (find-file "~/develop/workspace/projectile/beta/versions/standard/copy/config/Captions.txt"))
     )
    )    
  ;; Make mode global rather than buffer local
  :global 1
  )

;; Captions Mode
(load "captions-mode.el")
(add-to-list 'auto-mode-alist '("config/Captions\\.txt\\'" . captions-mode))
