(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t))
(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list '(dashboard dired ibuffer))
  (evil-collection-init))
(use-package evil-tutor)

;; Using RETURN to follow links in Org/Evil 
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
(setq org-return-follows-link  t)

;;Note this will cause the declaration to be interpreted immediately (not deferred).
;;Useful for configuring built-in emacs features.
(use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))

(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'buffer-move)
(require 'app-launchers)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))
(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(use-package carbon-now-sh)

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is A Goddamn Operating System!")
  (setq dashboard-startup-banner "/home/cylis/.config/emacs/images/emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content t) 
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(use-package diminish)

(use-package dired-open
  :config
    (setq dired-open-extensions'(("gif" . "imv-dir")
           ("jpg" . "imv-dir")
           ("png" . "imv-dir")
           ("mkv" . "mpv")
           ("mp3" . "mpv")
           ("mp4" . "mpv"))))
(use-package peep-dired
  :after dired
  :hook (evil-normalize-keymaps . peep-dired-hook)
  :config
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
    (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file))

(use-package elcord
  :config
  (setq elcord-idle-message "I can have an editor open and do something else.....")
  (setq elcord-refresh-rate 1)
(setq elcord-use-major-mode-as-main-icon t))
(elcord-mode 1)

(use-package elfeed
  :config
  (setq elfeed-search-feed-face ":foreground #ffffff :weight bold"
        elfeed-feeds (quote
                       (("https://www.reddit.com/r/linux.rss" reddit linux)
                        ("https://www.reddit.com/r/commandline.rss" reddit commandline)
                        ("https://www.reddit.com/r/distrotube.rss" reddit distrotube)
                        ("https://www.reddit.com/r/emacs.rss" reddit emacs)
                        ("https://www.gamingonlinux.com/article_rss.php" gaming linux)
                        ("https://hackaday.com/blog/feed/" hackaday linux)
                        ("https://opensource.com/feed" opensource linux)
                        ("https://linux.softpedia.com/backend.xml" softpedia linux)
                        ("https://itsfoss.com/feed/" itsfoss linux)
                        ("https://www.phoronix.com/rss.php" phoronix linux)
                        ("http://feeds.feedburner.com/d0od" omgubuntu linux)
                        ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
                        ("http://lxer.com/module/newswire/headlines.rss" lxer linux)))))

(use-package elfeed-goodies
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

(use-package flycheck
  :ensure t
  :diminish)

(set-face-attribute 'default nil
                  :font "JetBrainsMono Nerd Font Mono"
                  :height 110
                  :weight 'medium)
(set-face-attribute 'variable-pitch nil
                  :font "Montserrat"
                  :height 120
                  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
                  :font "JetBrainsMono Nerd Font Mono"
                  :height 110
                  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font Mono-11"))
(setq-default line-spacing 0.12)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package general
  :config
  (general-evil-setup)

  ;; set up 'SPC' as the global leader key
  (general-create-definer cylis/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (cylis/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
    "u" '(universal-argument :wk "Universal argument")
    "f" '(:ignore t :wk "Files")
    "f f" '(find-file :wk "Find File")
    "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit Emacs Config")
    "f d" '(find-grep-dired :wk "Search for string in files in DIR")
    "f g" '(counsel-grep-or-swiper :wk "Search for string current file")
    "f j" '(counsel-file-jump :wk "Jump to a file below current directory")
    "f l" '(counsel-locate :wk "Locate a file")
    "f r" '(counsel-recentf :wk "Find recent files")
    "f u" '(sudo-edit-find-file :wk "Sudo find file")
    "f U" '(sudo-edit :wk "Sudo edit file")
    "f r" '(counsel-recentf :wk "Find Recent Files")
    "c" '(comment-line :wk "Comment Lines"))

  (cylis/leader-keys
    "b" '(:ignore t :wk "buffer")
    "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
    "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
    "b d" '(bookmark-delete :wk "Delete bookmark")
    "b b" '(switch-to-buffer :wk "Switch Buffer")
    "b i" '(ibuffer :wk "IBuffer")
    "b k" '(kill-this-buffer :wk "Kill this Buffer")
    "b n" '(next-buffer :wk "Next Buffer")
    "b p" '(previous-buffer :wk "Previous Buffer")
    "b r" '(revert-buffer :wk "Reload Buffer")
    "b l" '(list-bookmarks :wk "List bookmarks")
    "b m" '(bookmark-set :wk "Set bookmark")
    "b R" '(rename-buffer :wk "Rename buffer")
    "b s" '(basic-save-buffer :wk "Save buffer")
    "b S" '(save-some-buffers :wk "Save multiple buffers")
    "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))

  (cylis/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired")
    "d j" '(dired-jump :wk "Dired jump to current")
    "d n" '(neotree-dir :wk "Open directory in neotree")
    "d p" '(peep-dired :wk "Peep-dired"))

  (cylis/leader-keys
    "v" '(:ignore t :wk "Evaluate")
    "v b" '(eval-buffer :wk "Evaluate elisp in Buffer")
    "v d" '(eval-defun :wk "Evaluate defun containing or after point")
    "v e" '(eval-expression :wk "Evaluate and elisp expression")
    "v l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "v r" '(eval-region :wk "Evaluate elisp in region"))

  (cylis/leader-keys
    "h" '(:ignore t :wk "Help")
    "h a" '(counsel-apropos :wk "Apropos")
    "h b" '(describe-bindings :wk "Describe bindings")
    "h c" '(describe-char :wk "Describe character under cursor")
    "h d" '(:ignore t :wk "Emacs documentation")
    "h d a" '(about-emacs :wk "About Emacs")
    "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
    "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
    "h d m" '(info-emacs-manual :wk "The Emacs manual")
    "h d n" '(view-emacs-news :wk "View Emacs news")
    "h d o" '(describe-distribution :wk "How to obtain Emacs")
    "h d p" '(view-emacs-problems :wk "View Emacs problems")
    "h d t" '(view-emacs-todo :wk "View Emacs todo")
    "h d w" '(describe-no-warranty :wk "Describe no warranty")
    "h e" '(view-echo-area-messages :wk "View echo area messages")
    "h f" '(describe-function :wk "Describe function")
    "h F" '(describe-face :wk "Describe face")
    "h g" '(describe-gnu-project :wk "Describe GNU Project")
    "h i" '(info :wk "Info")
    "h I" '(describe-input-method :wk "Describe input method")
    "h k" '(describe-key :wk "Describe key")
    "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
    "h L" '(describe-language-environment :wk "Describe language environment")
    "h m" '(describe-mode :wk "Describe mode")
    "h t" '(load-theme :wk "Load Themes")
    "h v" '(describe-variable :wk "Describe variable")
    "h r r" '((lambda () (interactive) (load-file "~/.config/emacs/init.el")) :wk "Reload emacs config")
    "h w" '(where-is :wk "Prints keybinding for command if set")
    "h x" '(describe-command :wk "Display full documentation for command"))

  (cylis/leader-keys
    "g" '(:ignore t :wk "Git")    
    "g /" '(magit-displatch :wk "Magit dispatch")
    "g ." '(magit-file-displatch :wk "Magit file dispatch")
    "g b" '(magit-branch-checkout :wk "Switch branch")
    "g c" '(:ignore t :wk "Create") 
    "g c b" '(magit-branch-and-checkout :wk "Create branch and checkout")
    "g c c" '(magit-commit-create :wk "Create commit")
    "g c f" '(magit-commit-fixup :wk "Create fixup commit")
    "g C" '(magit-clone :wk "Clone repo")
    "g f" '(:ignore t :wk "Find") 
    "g f c" '(magit-show-commit :wk "Show commit")
    "g f f" '(magit-find-file :wk "Magit find file")
    "g f g" '(magit-find-git-config-file :wk "Find gitconfig file")
    "g F" '(magit-fetch :wk "Git fetch")
    "g g" '(magit-status :wk "Magit status")
    "g i" '(magit-init :wk "Initialize git repo")
    "g l" '(magit-log-buffer-file :wk "Magit buffer log")
    "g r" '(vc-revert :wk "Git revert file")
    "g s" '(magit-stage-file :wk "Git stage file")
    "g t" '(git-timemachine :wk "Git time machine")
    "g u" '(magit-stage-file :wk "Git unstage file"))

  (cylis/leader-keys
    "e" '(:ignore t :wk "Eshell")
    "e s" '(eshell :wk "Launch Eshell")
    "e h" '(counsel-esh-history :wk "Eshell History")
    "e w" '(eww :wk "EWW Emacs Browser")
    "e r" '(eww-reload :wk "Reload Page in EWW"))

  (cylis/leader-keys
    "l" '(:ignore t :wk "LSP")
    "l p" '(lsp-keymap :wk "Keymap"))

  (cylis/leader-keys
    "o" '(:ignore t :wk "Org")
    "o a" '(org-agenda :wk "Org agenda")
    "o e" '(org-export-dispatch :wk "Org export dispatch")
    "o i" '(org-toggle-item :wk "Org toggle item")
    ;; This is necessarry as sometimes org mode glitches out(showing asterisks in subheadings) requiring it to be restarted.
    "o r" '(org-mode-restart :wk "Restart Org Mode")
    "o t" '(org-todo :wk "Org todo")
    "o B" '(org-babel-tangle :wk "Org babel tangle")
    "o T" '(org-todo-list :wk "Org todo list"))

  (cylis/leader-keys
    "o b" '(:ignore t :wk "Tables")
    "o b -" '(org-table-insert-hline :wk "Insert hline in table"))

  (cylis/leader-keys
    "o d" '(:ignore t :wk "Date/deadline")
    "o d t" '(org-time-stamp :wk "Org time stamp"))

  (cylis/leader-keys
    "o l" '(:ignore t :wk "LaTeX")
    "o l e" '(org-latex-export-to-pdf :wk "Export as PDF")
    "o l p" '(org-latex-preview :wk "Preview LaTeX"))

  (cylis/leader-keys
    "p" '(projectile-command-map :wk "Projectile"))

  (cylis/leader-keys
    "s" '(:ignore t :wk "Search")
    "s d" '(dictionary-search :wk "Search dictionary")
    "s m" '(man :wk "Man pages")
    "s t" '(tldr :wk "Lookup TLDR docs for a command")
    "s w" '(woman :wk "Similar to man but doesn't require man"))

  (cylis/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t e" '(eshell-toggle :wk "Toggle eshell")
    "t f" '(flycheck-mode :wk "Toggle flycheck")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t n" '(neotree-toggle :wk "Toggle Neotree File Viewer")
    "t r" '(rainbow-mode :wk "Toggle rainbow mode")
    "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t v" '(vterm-toggle :wk "Toggle Vterm")
    "t d" '(dashboard-open :wk "Dashboard")
    "t s" '(elfeed :wk "Elfeed RSS")
    "t m" '(make-frame :wk "Open buffer in new frame")
    "t F" '(select-frame-by-name :wk "Select frame by name"))

  (cylis/leader-keys
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right")))

(use-package git-timemachine
  :after git-timemachine
  :hook (evil-normalize-keymaps . git-timemachine-hook)
  :config
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-j") 'git-timemachine-show-previous-revision)
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-k") 'git-timemachine-show-next-revision)
)

(use-package magit)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)  ;; Enable truncated lines

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
(setq hl-todo-highlight-punctuation ":"
      hl-todo-keyword-faces
      `(("TODO"       warning bold)
        ("FIXME"      error bold)
        ("HACK"       font-lock-constant-face bold)
        ("REVIEW"     font-lock-keyword-face bold)
        ("NOTE"       success bold)
        ("DEPRECATED" font-lock-doc-face bold))))

(use-package counsel
  :after ivy
  :diminish
  :config (counsel-mode))
         
(use-package ivy
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d)")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t)

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1)
  :custom
  (ivy-virtual-abbreviate 'full
   ivy rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package lua-mode)
(use-package nix-mode)
(use-package zig-mode)

(use-package auctex)

(use-package cdlatex)

;; Enabling CDLaTeX mode universally for all org files.
(add-hook 'org-mode-hook #'turn-on-org-cdlatex)

(use-package lsp-mode
  :init
  :hook ((nix-mode . lsp)
         (js-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
(with-eval-after-load 'lsp-mode
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-stdio-connection "nixd")
                     :major-modes '(nix-mode)
                     :priority 0
                     :server-id 'nixd)))
;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package dap-mode)
(use-package dap-ui)

(global-set-key [escape] 'keyboard-escape-quit)

(use-package doom-modeline
  :ensure t
  :config
  (setq doom-modeline-height 35      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

(use-package neotree
 :config
 (setq neo-smart-open t
       neo-show-hidden-files t
       neo-window-width 55
       neo-window-fixed-size nil
       inhibit-compacting-font-caches t
       projectile-switch-project-action 'neotree-projectile-action) 
       ;; truncate long file names in neotree
       (add-hook 'neo-after-create-hook
          #'(lambda (_)
              (with-current-buffer (get-buffer neo-buffer-name)
                (setq truncate-lines t)
                (setq word-wrap nil)
                (make-local-variable 'auto-hscroll-mode)
                (setq auto-hscroll-mode nil)))))

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(eval-after-load 'org-indent '(diminish 'org-indent-mode))

(require 'org-tempo)

(use-package perspective
  :custom
  ;; NOTE! I have also set 'SCP =' to open the perspective menu.
  ;; I'm only setting the additional binding because setting it
  ;; helps suppress an annoying warning message.
  (persp-mode-prefix-key (kbd "C-c M-p"))
  :config
  ;; Sets a file to write to when we save states
  (setq persp-state-default-file "~/.config/emacs/sessions"))

;; This will group buffers by persp-name in ibuffer.
(add-hook 'ibuffer-hook
          (lambda ()
            (persp-ibuffer-set-filter-groups)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

;; Automatically save perspective states to file when Emacs exits.
(add-hook 'kill-emacs-hook #'persp-state-save)

(use-package projectile
  :config
  (projectile-mode 1))

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

(use-package eshell-toggle
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-function #'eshell-toggle-init-ansi-term))

(use-package eshell-syntax-highlighting
          :after esh-mode
          :config
        (eshell-syntax-highlighting-global-mode +1))
(setq eshell-rc-script (concat
	user-emacs-directory "eshell/profile")
	eshell-aliases-file (concat
	user-emacs-directory "eshell/aliases")
	eshell-history-size 10000
	eshell-buffer-maximum-lines 10000
	eshell-hist-ignore-dups t
	eshell-scroll-to-bottom-on-input t
	eshell-destroy-buffer-when-process-dies t
	eshell-visual-commans'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package vterm
  :config
  (setq shell-file-name "/bin/sh"
          vterm-max-scrollback 10000))

(use-package vterm-toggle
        :after vterm
        :config
        (setq vterm-toggle-fullscreen-p nil)
        (setq vterm-toggle-scope 'project)
        (add-to-list 'display-buffer-alist
                '((lambda (buffer-or-name _)
                (let ((buffer (get-buffer buffer-or-name)))
                (with-current-buffer buffer
                    (or (equal major-mode 'vterm-mode)
                        (string-prefix-p vterm-buffer-name (buffer-name))))))
            (display-buffer-reuse-window display-buffer-at-bottom)
            (reusable-framse . visible)
            (window-height . 0.3))))

(use-package yasnippet)
(yas-global-mode 1)

(use-package sudo-edit)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
  doom-themes-enable-italic t))
(load-theme 'Euphoria t)
;; fallback theme
;;(use-package catppuccin-theme)
;;(load-theme 'catppuccin :no-confirm)

(use-package tldr)

(set-frame-parameter nil 'alpha-background 70)
(add-to-list 'default-frame-alist '(alpha-background . 70))

(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
 	  which-key-sort-order #'which-key-key-order-alpha
 	  which-key-sort-uppercase-first nil
 	  which-key-add-column-padding 1
 	  which-key-max-display-columns nil
 	  which-key-min-display-lines 6
 	  which-key-side-window-slot -10
 	  which-key-side-window-max-height 0.25
 	  which-key-idle-delay 0.8
 	  which-key-max-description-length 25
 	  which-key-allow-imprecise-window-fit nil
 	  which-key-separator " → " ))

(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(evil-mode 1)
(all-the-icons-ivy-rich-mode 1)
(global-flycheck-mode 1)
(doom-modeline-mode 1)
(persp-mode 1)
(elfeed-goodies/setup)
