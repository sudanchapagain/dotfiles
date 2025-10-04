;;; Package --- summary

;;; Commentary:

;;; Code:
;; used by tools like git when creating commits.
(setq user-full-name "Sudan Chapagain"
      user-mail-address "101015050+sudanchapagain@users.noreply.github.com")

;; In Emacs when memory crosses 800KB, it garbage collects.
(setq gc-cons-threshold 50000000) ;; 50MB
;; When opening "large files" Emacs warns.
(setq large-file-warning-threshold 100000000)

;; Don't show the splash screen
(setq inhibit-startup-message t)
;; Set initial-buffer-choice to nil to open an empty buffer
(setq initial-buffer-choice nil)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)
(size-indication-mode t)
(global-hl-line-mode +1)
(line-number-mode +1)
(column-number-mode t)
(setq-default fill-column 80)

;; Show file path at the top
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                 (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; scroll fix
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; font
(set-frame-font "JetBrainsMono Nerd Font" nil t)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'mellow t)
;;(load-theme 'isohedron t)
;;(load-theme 'floraverse t)

;; FIXED temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; yes no replaced with y n
(fset 'yes-or-no-p 'y-or-n-p)

;; auto reload file when edited outside emacs
(global-auto-revert-mode t)

;; tabs as 4 spaces
(setq-default tab-width 4
              indent-tabs-mode nil)

;; kill current buffer by default
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; clean up random whitespaces
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Disable package.el in favor of straight.el
(setq package-enable-at-startup nil)

;; bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Evil mode
(straight-use-package 'evil)
(evil-mode 1)

;; AUCTeX
(straight-use-package 'auctex)
;; PDF tools
(straight-use-package 'pdf-tools)
(pdf-tools-install)
(setq TeX-view-program-selection '((output-pdf "PDF Tools")))

;; Magit
(straight-use-package 'magit)
;; Install forge for GitHub integration
(straight-use-package 'forge)

;; smartparens
(straight-use-package 'smartparens)
(straight-use-package 'diminish)
(require 'smartparens-config)
(smartparens-global-mode 1)
(show-paren-mode t)

;; Semantic selection with expand-region (M-m)
(straight-use-package 'expand-region)
(global-set-key (kbd "M-m") 'er/expand-region)

;; which key
(straight-use-package 'which-key)
(which-key-mode 1)
(diminish 'which-key-mode)

;; avy allows to jump in current view with go to char
(straight-use-package 'avy)
(global-set-key (kbd "C-=") 'avy-goto-char)
(setq avy-background t)

;; company for completion and flycheck for syntax checking
(straight-use-package 'company)
(add-hook 'after-init-hook #'global-company-mode)
(diminish 'company-mode)
(straight-use-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(diminish 'flycheck-mode)

;; autothemer
;;(straight-use-package 'autothemer)

(provide 'init)
;;; init.el ends here
