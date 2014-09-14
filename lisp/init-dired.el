;;; Package --- Dired config
;;; Commentary:

;;; Code:

(require-package 'dired+)

(setq-default diredp-hide-details-initially-flag nil)

(after-load 'dired
  (require 'dired+)
  (when (fboundp 'global-dired-hide-details-mode)
    (global-dired-hide-details-mode -1))
  (setq-default dired-recursive-deletes 'top)
  (define-key dired-mode-map [mouse-2] 'dired-find-file))


(provide 'init-dired)
;;; init-dired.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
