(when (< emacs-major-version 24)
  (require-package 'color-theme))

(require-package 'monokai-theme)

(defun reapply-themes ()
  "Load theme."
  (require 'monokai-theme))

(add-hook 'after-init-hook 'reapply-themes)


(provide 'init-themes)
