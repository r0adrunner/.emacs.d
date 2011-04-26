(defun custfn_f9 (str)
  (interactive (list (read-from-minibuffer "Search string: ")))
  (beginning-of-buffer)
  (replace-regexp (concat str "$") (quote (replace-eval-replacement concat "\\&_-DelMe_-" (number-to-string replace-count)))))

(defun custfn_f10 ()
  (interactive)
  (beginning-of-buffer)
  (replace-regexp "_-DelMe_-[0-9]+" ""))

(global-set-key (kbd "<f9>") 'custfn_f9)
(global-set-key (kbd "<f10>") 'custfn_f10)
  