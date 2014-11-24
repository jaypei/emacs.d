;;; Package --- mode-line
;;; Commentary:

;;; Code:


;;; powerline
;; (require-package 'powerline)
;; (when *is-gui*
;;   (setq-default powerline-default-separator 'wave)
;;   (powerline-default-theme))

;;; smart-mode-line
(require-package 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(sml/setup)
(sml/apply-theme 'dark)
;; (sml/apply-theme 'light)
;; (sml/apply-theme 'respectful)
;; (sml/apply-theme 'automatic)

(provide 'init-mode-line)
;;; init-mode-line.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
