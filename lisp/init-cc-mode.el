;;; Package --- C/C++ mode
;;; Commentary:

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;;; Code:

(defun exz/cc-mode-setup ()
  "The indent setup function in cc-mode."
  (defconst exz/c-coding-style
    '((c-tab-always-indent . t)
      (c-comment-only-line-offset . 0)
      (c-hanging-braces-alist . ((substatement-open after)
                                 (brace-list-open)))
      (c-cleanup-list . (comment-close-slash
                         compact-empty-funcall))
      (c-offsets-alist . ((substatement-open . 0)
                          (innamespace . 0)
                          (case-label      . +)
                          (access-label . -)
                          (block-open     . 0)))
      (setq comment-start "/*"
            comment-end "*/")
      (setq indent-tabs-mode nil))
    "exz c coding style")
  (c-add-style "exz/c-coding-style" exz/c-coding-style)
  (c-set-style "exz/c-coding-style"))

(add-hook 'c-mode-hook 'exz/cc-mode-setup)
(add-hook 'c++-mode-hook 'exz/cc-mode-setup)

(provide 'init-cc-mode)
;;; init-cc-mode.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
