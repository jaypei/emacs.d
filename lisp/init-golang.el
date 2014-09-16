;;; Package --- Golang
;;; Commentary:

;;; Code:

(require-package 'go-mode)
(require-package 'go-autocomplete)

(when (boundp 'auto-complete-mode)
  (require 'go-autocomplete)
  (ac-config-default))

(provide 'init-golang)
;;; init-golang.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
