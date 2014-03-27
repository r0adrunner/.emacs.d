;; Magit:
(require 'magit)
(global-set-key (kbd "C-x v t") 'magit-status) ; Era livre.

;; set-mark-command no xmonad:
(global-set-key (kbd "C-H-SPC") 'set-mark-command) ; Era livre


;; make cursor movement keys under right hand's home-row.
(global-set-key (kbd "M-i") 'previous-line) ; was tab-to-tab-stop
(global-set-key (kbd "M-j") 'backward-char) ; was indent-new-comment-line
(global-set-key (kbd "M-k") 'next-line) ; was kill-sentence
(global-set-key (kbd "M-l") 'forward-char)  ; was downcase-wjord

(global-set-key (kbd "C-M-k") 'kill-sentence) ; era nada

(global-set-key (kbd "<C-tab>") 'other-window)

;; Switch buffer:
(iswitchb-mode t)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Dired:
(global-set-key (kbd "C-x C-d") 'dired)

;; Revert buffer:
(global-set-key (kbd "C-x r e") 'revert-buffer)

;; Org-mode:
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook
          '(lambda ()
             (define-key org-mode-map [(control tab)] nil)))

;; Pager:
     (require 'pager)
     (global-set-key "\C-v"	   'pager-page-down)
     (global-set-key [next] 	   'pager-page-down)
     (global-set-key "\ev"	   'pager-page-up)
     (global-set-key [prior]	   'pager-page-up)
     (global-set-key (kbd "s-i")   'pager-row-up)
     (global-set-key (kbd "s-k")   'pager-row-down)


;;========================= C-j = backspace C-n = C-j
;; Melhora atalhos para backspace e newline. (Global)
(global-set-key "\C-n" 'newline-and-indent) ; era newline
(global-set-key "\C-j" 'delete-backward-char) ; era newline-and-indent

;; lisp-interaction-mode:
(define-key lisp-interaction-mode-map "\C-j" 'delete-backward-char) ;; Era eval-print-last-sexp

;; Minibuffer: Antes era: minibuffer-complete-and-exit
(define-key minibuffer-local-completion-map  "\C-j" 'delete-backward-char)
(define-key minibuffer-local-filename-completion-map  "\C-j" 'delete-backward-char)
(define-key minibuffer-local-filename-must-match-map  "\C-j" 'delete-backward-char)
(define-key minibuffer-local-isearch-map  "\C-j" 'delete-backward-char)
(define-key minibuffer-local-map  "\C-j" 'delete-backward-char)
(define-key minibuffer-local-must-match-filename-map  "\C-j" 'delete-backward-char)
(define-key minibuffer-local-must-match-map  "\C-j" 'delete-backward-char)
(define-key minibuffer-local-ns-map  "\C-j" 'delete-backward-char)
(define-key minibuffer-local-shell-command-map  "\C-j" 'delete-backward-char)

;; Org-mode:
(require 'org)
(define-key org-mode-map "\C-j" 'delete-backward-char) ;;era org-return-indent
(define-key org-mode-map  "\C-n" 'org-return-indent)

;;eshell
(add-hook 'eshell-mode-hook ;; for some reason this needs to be a hook
               '(lambda () (progn
			     ;; era eshell-send-input
			     (define-key eshell-mode-map "\C-j" 'delete-backward-char))))

;;===================================================================

;; Diff mode map:
(setq diff-mode-map (make-sparse-keymap))
(define-key diff-mode-map (kbd "M-k") 'next-line) ; was diff-hunk-kill
(define-key diff-mode-map (kbd "C-M-k") 'diff-hunk-kill) ; was kill-sexp

;; M-c muda entre caixa alta e baixa ao invés de só capitalizar a palavra
(defun capitalize-uncapitalize-word ()
  "Muda entre caixa alta/baixa"
  (interactive)
  (let ((case-fold-search nil))
    (if (string-match "[a-z]" (string(char-after)))
	(capitalize-word 1)
      (if (string-match "[A-Z]" (string(char-after))) ;;else
	  (downcase-word 1)
	(progn ;; else
	  (forward-word 1)
	  (backward-word 1)
	  (if (string-match "[a-z]" (string(char-after)))
	      (capitalize-word 1)
	    (downcase-word 1)))))))

(global-set-key "\M-c" 'capitalize-uncapitalize-word) ;; era capitalize-word

;; C-~ = undo. Atalho mais fácil que C-/
(global-set-key (kbd "<C-dead-tilde>") 'undo) ; Era nada

;; C-; = undo. funciona em teclado us tambem
(global-set-key (kbd "C-;") 'undo) ; Era nada

;; C-M-j = backward-kill-word
(global-set-key (kbd "C-M-j") 'backward-kill-word) ; Era indent-new-comment-line

;; C-M-m = indent-new-comment-line
(global-set-key (kbd "C-M-m") 'indent-new-comment-line) ; Era nada

;; S-u = toggle-truncate-lines
(global-set-key (kbd "s-u") 'toggle-truncate-lines)  ; Era nada

(defun yank-line ()
  "Cola e abre uma nova linha"
  (interactive)
  (progn
    (yank)
    (newline-and-indent)))

(global-set-key (kbd "C-M-y") 'yank-line)  ; Era nada

;; S-l e S-j = Navega pelas janelas
(global-set-key (kbd "s-l") 'other-window)  ; Era nada

(defun other-window-backward ()
  (interactive)
  (other-window -1))

(global-set-key (kbd "s-j") 'other-window-backward)  ; Era nada

(global-set-key (kbd "C-x C-c") 'nil) ; Era comando para sair do emacs

(defun comment-uncomment-line ()
  (interactive)
  (progn (move-beginning-of-line nil)
	 (set-mark-command nil)
	 (move-end-of-line nil)
	 (comment-dwim nil)))

(global-set-key (kbd "C-ç") 'comment-uncomment-line)  ; Era nada
