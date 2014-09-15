;;; Package --- Markdown
;;; Commentary:

;;; Code:

(require-package 'markdown-mode)

(setq auto-mode-alist
      (cons '("\\.\\(md\\|markdown\\)\\'" . markdown-mode) auto-mode-alist))

(provide 'init-markdown)
;;; init-markdown.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
