;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

(setq user-full-name "Amir Haouala"
      user-mail-address "amir-haouala@outlook.com")

;; Add scripts directory to load path early
(add-to-list 'load-path (expand-file-name "scripts" user-emacs-directory))

;; Bootstrap Elpaca package manager FIRST
(require 'elpaca-setup)

;; Then load the main configuration from config.org
(org-babel-load-file
 (expand-file-name "config.org" user-emacs-directory))

(provide 'init)
;;; init.el ends here
