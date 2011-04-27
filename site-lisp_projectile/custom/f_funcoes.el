(defun custfn_f9 (str)
  (interactive (list (read-from-minibuffer "String a marcar: " (replace-regexp-in-string "\\$$" "" (car (if isearch-regexp regexp-search-ring search-ring))))))
  (save-excursion
  (beginning-of-buffer)
  (replace-regexp (concat str "$") (quote (replace-eval-replacement concat "\\&_-DelMe_-" (number-to-string replace-count))))))

(defun custfn_f10 ()
  (interactive)
  (save-excursion
  (beginning-of-buffer)
  (replace-regexp "_-DelMe_-[0-9]+" "")))

(global-set-key (kbd "<f9>") 'custfn_f9)
(global-set-key (kbd "<f10>") 'custfn_f10)
  