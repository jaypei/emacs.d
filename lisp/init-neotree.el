;;; Package --- Neotree config
;;; Commentary:
;;; Code:


;; Try to load git version
(let* ((n-git-path (exz/make-dotemacs-path "site-lisp/neotree"))
       (n-git-autoloads-file (exz/make-dotemacs-path "site-lisp/neotree/neotree-autoloads.el"))
       (n-git-src-file (exz/make-dotemacs-path "site-lisp/neotree/neotree.el")))

  (when (file-exists-p n-git-src-file)
    (add-to-list 'load-path n-git-path)
    (unless (file-exists-p n-git-autoloads-file)
      (update-file-autoloads n-git-src-file t n-git-autoloads-file))
    (load-file n-git-autoloads-file)
    (require 'neotree n-git-src-file)
    (exz/debug "[NeoTree] Load local version.")))

(unless (boundp 'neotree-show)
  (require-package 'neotree))

(customize-set-value 'neo-smart-open t)
(global-set-key [f8] 'neotree-toggle)

(provide 'init-neotree)
;;; init-neotree.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
