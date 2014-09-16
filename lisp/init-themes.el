;;; Package --- Themes
;;; Commentary:

;;; Code:


(when (< emacs-major-version 24)
  (require-package 'color-theme))

(require-package 'monokai-theme)
(require-package 'cyberpunk-theme)
(require-package 'zenburn-theme)

(defun reapply-themes ()
  "Load theme."
  (require (if (display-graphic-p)
               'monokai-theme
             'zenburn-theme)))

;; (add-hook 'after-init-hook 'reapply-themes)
(reapply-themes)

(provide 'init-themes)
;;; init-themes.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
