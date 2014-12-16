;;; Package --- Markdown
;;; Commentary:

;;; Code:

(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))

(custom-set-faces
 '(markdown-header-face-1 ((t (:inherit markdown-header-face))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face)))))


(provide 'init-markdown)
;;; init-markdown.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
