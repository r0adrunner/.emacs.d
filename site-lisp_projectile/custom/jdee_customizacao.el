(require 'jde)

;; Versão do java
(setq jde-jdk-registry (quote (("1.6.0_20" . "/home/victor/develop/system/javalin"))))

;; Conserta erro para procurar em arquivos com espaço no meio (find -print0 | xargs -0 ), ignora arquivos binários, ignora CaSe no nome de arquivo

;; (defun jde-find-grep-internal (regexp files &optional dirs no-case grain) 
;;   "Find a regular expression REGEXP in files of type FILES in
;;  DIRS, where DIRS is a string of space-separated paths of
;; directories to search recursively. If NO-CASE is nonnil, ignore
;; case. GRAIN is a string that indicates the granularity of the search,
;; i.e., match any \"Character\" string, a \"Word\" only, or a \"Line\"
;; only."
;;   (if (not (executable-find
;; 	    ;; Hack required by faulty XEmacs implementation of executable-find.
;; 	    (if (eq system-type 'windows-nt) "grep.exe" "grep")))
;;       (error "This command requires the Unix grep utility."))
;;   (if (not (executable-find
;; 	    (if (eq system-type 'windows-nt) "find.exe" "find")))
;;       (error (list "This command requires the Unix find utility.")))
;;   (let* ((directories-option
;; 	  (if dirs dirs "."))
;; 	 (case-sensitive-option
;; 	  (if no-case  "-i" ""))
;; 	 (granularity-option
;; 	  (cond
;; 	   ((and grain (string= grain "Word"))
;; 	    "-w")
;; 	   ((and grain (string= grain "Line"))
;; 	    "-x")
;; 	   (t
;; 	    " ")))
;; 	  (file-regexp-option
;; 	   (mapconcat
;; 	    (lambda (x)
;; 	      ;; Ignora CaSe no nome do arquivo
;; 	      (format "-iname \"%s\"" x))
;; 	    files
;; 	    " -or "))
;; 	  (cmd
;; 	   ;; Customização p arrumar o find para aceitar espaços em branco no nome do arquivo
;; 	   (format "find %s %s -type f -print0 | xargs -0 grep %s %s -I -n \"%s\" /dev/null"
;; 		  directories-option
;; 		  file-regexp-option
;; 		  case-sensitive-option
;; 		  granularity-option
;; 		  regexp)))
;;     (grep cmd)))


