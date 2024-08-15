;;; app-launchers.el --- Questionable Alternative to dmenu/rofi

;;; Code: 
;;; Insanity begins here.
(defun emacs-counsel-launcher ()
    "Create and select a frame called emacs-counsel-launcher which consists only of a minibuffer. Runs counsel-linux-app on that frame which is an emacs command provided by the counsel program that prompts you to select and open an app in a dmenu like behavious. Delete the frame after that command has exited."
    (interactive)
    (with-selected-frame
	(make-frame '((name . "emacs-run-launcher")
		    (minibuffer . only)
		    (fullscreen . 0); no fullscreen
		    (undecorated . t); remvoe title bar
		    ;;(auto-raise .t) ; focus on this frame
		    ;;(tool-bar-lines . 0)
		    ;;(menu-bar-lines . 0)
		    (internal-border-width . 10)
		    (width . 80)
		    (height . 11)))
		    (unwind-protect
			(counsel-linux-app)
			(delete-frame))))
(defun emacs-counsel-launcher ()
    "Create and select a frame called emacs-counsel-launcher which consists only of a minibuffer. Runs counsel-linux-app on that frame which is an emacs command provided by the counsel program that prompts you to select and open an app in a dmenu like behavious. Delete the frame after that command has exited."
    (interactive)
    (with-selected-frame
	(make-frame '((name . "emacs-run-launcher")
		    (minibuffer . only)
		    (fullscreen . 0); no fullscreen
		    (undecorated . t); remvoe title bar
		    ;;(auto-raise .t) ; focus on this frame
		    ;;(tool-bar-lines . 0)
		    ;;(menu-bar-lines . 0)
		    (internal-border-width . 10)
		    (width . 80)
		    (height . 11)))
		    (unwind-protect
			(counsel-linux-app)
			(delete-frame))))

(provide 'app-launchers)
;;; app-launchers.el ends here
