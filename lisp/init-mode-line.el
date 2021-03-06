;;; Package --- mode-line
;;; Commentary:

;;; Code:

(custom-set-faces
 '(mode-line ((t (:background "black" :foreground "gray60")))))

;;; smart-mode-line
(require-package 'smart-mode-line)
(setq sml/no-confirm-load-theme t)
(sml/setup)
(sml/apply-theme 'dark)
;; (sml/apply-theme 'light)
;; (sml/apply-theme 'respectful)
;; (sml/apply-theme 'automatic)

(custom-set-faces
 '(mode-line ((t (:background "black" :foreground "gray60" :inverse-video nil :family "Fantasque Sans Mono")))))


;; nyan-mode
(require-package 'nyan-mode)
(nyan-mode 1)

(provide 'init-mode-line)
;;; init-mode-line.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
