;;; Package --- Powerline
;;; Commentary:

;;; Code:

(require-package 'powerline)
;; powerline
(when *is-gui*
  (setq-default powerline-default-separator 'wave)
  (powerline-default-theme))

(provide 'init-powerline)
;;; init-powerline.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
