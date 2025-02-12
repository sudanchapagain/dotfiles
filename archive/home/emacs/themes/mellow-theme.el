;;; mellow-theme.el --- Mellow color theme

;;; Commentary:
;;; A mellow color scheme for Emacs.

(deftheme mellow)

(let ((class '((class color) (min-colors 89)))
      (fg1 "#c9c7cd")
      (fg2 "#b9b7bd")
      (fg3 "#a9a7ac")
      (fg4 "#99979c")
      (fg6 "#d6d4d9")
      (bg1 "#161617")
      (bg2 "#29292a")
      (bg3 "#3b3b3c")
      (bg4 "#4e4e4f")
      (builtin "#f591b2")
      (keyword "#aca1cf")
      (const "#b9aeda")
      (comment "#57575f")
      (func "#ea83a5")
      (str "#90b99f")
      (type "#ecaad6")
      (var "#cac9dd")
      (selection "#e6b99d")
      (warning "#f5a191")
      (warning2 "#ffae9f")
      (unspec 'unspecified))

  (custom-theme-set-faces
   'mellow
   `(default ((,class (:background ,bg1 :foreground ,fg1))))
   `(cursor ((,class (:background ,fg4))))
   `(region ((,class (:background ,selection))))
   `(highlight ((,class (:foreground ,fg3 :background ,bg3))))
   `(hl-line ((,class (:background ,bg2))))
   `(fringe ((,class (:background ,bg2 :foreground ,fg4))))
   `(vertical-border ((,class (:foreground ,fg3))))

   `(font-lock-builtin-face ((,class (:foreground ,builtin))))
   `(font-lock-comment-face ((,class (:foreground ,comment))))
   `(font-lock-constant-face ((,class (:foreground ,const))))
   `(font-lock-doc-face ((,class (:foreground ,comment))))
   `(font-lock-function-name-face ((,class (:foreground ,func))))
   `(font-lock-keyword-face ((,class (:bold ,class :foreground ,keyword))))
   `(font-lock-string-face ((,class (:foreground ,str))))
   `(font-lock-type-face ((,class (:foreground ,type))))
   `(font-lock-variable-name-face ((,class (:foreground ,var))))
   `(font-lock-warning-face ((,class (:foreground ,warning :background ,bg2))))

   `(org-code ((,class (:foreground ,fg2))))
   `(org-hide ((,class (:foreground ,fg4))))
   `(org-level-1 ((,class (:bold t :foreground ,fg2 :height 1.1))))
   `(org-level-2 ((,class (:foreground ,fg3))))
   `(org-level-3 ((,class (:bold t :foreground ,fg4))))
   `(org-level-4 ((,class (:foreground ,bg4))))
   `(org-todo ((,class (:box (:line-width 1 :color ,fg3) :foreground ,keyword :bold t))))
   `(org-done ((,class (:box (:line-width 1 :color ,bg3) :foreground ,bg4))))
   `(org-link ((,class (:underline t :foreground ,type))))

   `(ivy-current-match ((,class (:foreground ,fg3 :inherit highlight :underline t))))
   `(helm-header ((,class (:foreground ,fg2 :background ,bg1 :underline nil :box nil))))
   `(helm-selection ((,class (:background ,bg2 :underline nil))))

   `(warning ((,class (:foreground ,warning))))
   `(trailing-whitespace ((,class (:foreground ,unspec :background ,warning))))

   `(tab-line ((,class (:background ,bg2 :foreground ,fg4))))
   `(tab-line-tab-modified ((,class (:foreground ,warning2 :weight bold))))))

(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'mellow)

;;; mellow-theme.el ends here
