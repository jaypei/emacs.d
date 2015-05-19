;;; Package --- Golang
;;; Commentary:

;;; Code:

(require-package 'go-mode)
(require-package 'go-autocomplete)

(when (boundp 'auto-complete-mode)
  (require 'go-autocomplete)
  (ac-config-default))

(add-hook 'go-mode-hook
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))

(provide 'init-golang)
;;; init-golang.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
