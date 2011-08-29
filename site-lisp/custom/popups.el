;; Copiado de: http://emacs-fu.blogspot.com/2009/11/showing-pop-ups.html

(defun notify-popup-zenity (title msg &optional icon sound)
  "Show a popup if we're on X, or echo it otherwise; TITLE is the title
of the message, MSG is the context. Optionally, you can provide an ICON and
a sound to be played"

  (interactive)
  (when sound (shell-command
                (concat "mplayer -really-quiet " sound " 2> /dev/null")))
  (if (eq window-system 'x)
    (shell-command (concat "zenity --info"

                     (if icon (concat " --window-icon \"" icon "\"") "")
                     "--width 350 --title \"" title "\" --text \"" msg "\"" ))
    ;; text only version

    (message (concat title ": " msg))))