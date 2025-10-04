;; bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; custom variables
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; cleanup ui
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-message t)
(set-fringe-mode 10)
(setq use-dialog-box nil)
(setq frame-title-format "%b — Emacs")

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 120)
(use-package doom-themes
  :config (load-theme 'doom-dracula t))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package which-key
  :config (which-key-mode))

;; completion
(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :custom (completion-styles '(orderless basic)))

;; backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory))))
