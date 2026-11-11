(require 'app-launchers) ;; Use emacs as a run launcher like dmenu (experimental)

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner "~/.config/emacs/images/emacs-dash.png")
  (setq dashboard-center-content nil)
  (setq dashboard-items '((recents . 5)
                          (agenda . 5)
                          (bookmarks . 3)
                          (projects . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(set-face-attribute 'default nil
  :font "JetBrainsMono Nerd Font"
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "JetBrainsMono Nerd Font"
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrainsMono Nerd Font"
  :weight 'medium)
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-14"))
(setq-default line-spacing 0.12)
(set-face-background 'mouse "#ffffff")

(delete-selection-mode 1)
(electric-indent-mode -1)
(electric-pair-mode 1)
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                      (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq display-line-numbers 'relative)
(setq org-edit-src-content-indentation 0)
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq pop-up-windows nil)

(global-hl-line-mode 1)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(setq org-directory "~/Org/")

(setq org-agenda-files '("~/Org/TODO.org"))

(setq org-src-preserve-indentation t)

(setq company-global-modes '(not eshell-mode))

(add-hook 'eshell-mode-hook
          (lambda ()
            (define-key eshell-mode-map (kbd "<f9>") #'pcomplete-list)))

(defun eshell-new (name)
  "Create new eshell buffer named NAME."
  (interactive "sName: ")
  (setq name (concat "$" name))
  (eshell)
  (rename-buffer name))

(global-set-key [escape] 'keyboard-escape-quit)

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(use-package compat
  :ensure t
  :demand t)
(use-package elfeed
  :ensure t
  :config
  (setq elfeed-search-feed-face ":weight bold")
  (setq elfeed-search-filter "@6-months-ago")
  (setq elfeed-feeds
    '(
        ;;
    ))
  (setq elfeed-db-directory "~/.elfeed")
  (global-set-key (kbd "C-x w") 'elfeed))

(use-package elfeed-goodies
  :ensure t
  :after elfeed
  :config
  (elfeed-goodies/setup)
  (setq elfeed-goodies/entry-pane-size 0.5))

(use-package ivy
  :ensure t
  :config
  (ivy-mode 1))
