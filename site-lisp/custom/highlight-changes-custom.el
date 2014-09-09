;;; Copiado de: http://emacs-fu.blogspot.com/2009/05/tracking-changes.html
;; higlight changes in documents
(global-highlight-changes-mode t)
(setq highlight-changes-visibility-initial-state nil); initially hide

(global-set-key (kbd "<f6>")      'highlight-changes-visible-mode)