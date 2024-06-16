;;; mellow-theme.el --- Theme

;;; Commentary:
;;; mellow theme

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
      (const   "#b9aeda")
      (comment "#57575f")
      (func    "#ea83a5")
      (str     "#90b99f")
      (type    "#ecaad6")
      (var     "#cac9dd")
      (selection "#e6b99d")
      (warning   "#f5a191")
      (warning2  "#ffae9f")
      )
  (custom-theme-set-faces
   'mellow
   `(default ((,class (:background ,bg1 :foreground ,fg1))))
   `(font-lock-builtin-face ((,class (:foreground ,builtin))))
   `(font-lock-comment-face ((,class (:foreground ,comment))))
	 `(font-lock-negation-char-face ((,class (:foreground ,const))))
	 `(font-lock-reference-face ((,class (:foreground ,const))))
	 `(font-lock-constant-face ((,class (:foreground ,const))))
   `(font-lock-doc-face ((,class (:foreground ,comment))))
   `(font-lock-function-name-face ((,class (:foreground ,func ))))
   `(font-lock-keyword-face ((,class (:bold ,class :foreground ,keyword))))
   `(font-lock-string-face ((,class (:foreground ,str))))
   `(font-lock-type-face ((,class (:foreground ,type ))))
   `(font-lock-variable-name-face ((,class (:foreground ,var))))
   `(font-lock-warning-face ((,class (:foreground ,warning :background ,bg2))))
   `(term-color-black ((,class (:foreground ,fg2 :background ,unspec))))
 (when (boundp 'font-lock-regexp-face)
    (custom-theme-set-faces
    'mellow
    `(font-lock-regexp-face ((,class (:inherit font-lock-string-face :underline t)))))))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'mellow)

;; Local Variables:
;; no-byte-compile: t
;; End:

;;; mellow-theme.el ends here
