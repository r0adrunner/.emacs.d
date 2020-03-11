
;; beacon mode
;; ========================================
(beacon-mode 1)

;; Browser default:
;; ========================================
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser"
      ;; browse-url-generic-args (list "--incognito")
      browse-url-generic-args nil)

;; rjsx-mode
;; ========================================
;; register just components/*.js
;; (add-to-list 'auto-mode-alist '("components\\/.*\\.js\\'" . rjsx-mode))
;; register all .js
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

(add-hook 'rjsx-mode-hook 'turn-on-paredit)
