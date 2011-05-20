(when (string-equal  system-type "gnu/linux")
  (progn
    (setenv "PATH"
            (concat
	     "/home/victor/develop/system/maven/bin" ":"
	     "/usr/local/apache-maven-3.0.1/bin" ":"
	     "/usr/local/sbin" ":"
	     "/usr/local/bin/" ":"
	     "/usr/sbin" ":"
	     "/usr/bin" ":"
	     "/sbin" ":"
	     "/bin" ":"
             ) )

    (setenv "JAVA_HOME"
            "/home/victor/develop/system/javalin" )

    (setenv "EDITOR"
            "emacsclient" )

    ;; (setq exec-path
    ;;       '(
    ;;         ""
    ;;         ""
    ;;        )
    ;;       ) 

    ) )
