;;; Package --- MMM
;;; Commentary:

;; Multiple major modes

;;; Code:


(require-package 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'buffers-with-submode-classes)
(setq mmm-submode-decoration-level 2)


(provide 'init-mmm)
;;; init-mmm.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
