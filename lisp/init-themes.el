;;; Package --- Themes
;;; Commentary:

;;; Code:


(when (< emacs-major-version 24)
  (require-package 'color-theme))

(require-package 'material-theme)
(require-package 'ir-black-theme)

(defun reapply-themes ()
  "Load theme."
  (require (if (display-graphic-p)
               'material-theme
             'ir-black-theme)))

;; (add-hook 'after-init-hook 'reapply-themes)
(reapply-themes)

(provide 'init-themes)
;;; init-themes.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
