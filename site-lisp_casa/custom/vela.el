(defun timer-vela ()
(interactive)
(progn
  (sleep-for (* 14 60))
  (shell-command "mplayer /usr/share/sounds/purple/alert.wav > /dev/null")))