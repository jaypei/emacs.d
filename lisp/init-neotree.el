;;; Package --- Neotree config
;;; Commentary:
;;; Code:


;; Try to load git version
;; (let* ((n-git-path (exz/make-dotemacs-path "site-lisp/neotree"))
;;        (n-git-autoloads-file (exz/make-dotemacs-path "site-lisp/neotree/neotree-autoloads.el"))
;;        (n-git-src-file (exz/make-dotemacs-path "site-lisp/neotree/neotree.el")))

;;   (when (file-exists-p n-git-src-file)
;;     (add-to-list 'load-path n-git-path)
;;     (unless (file-exists-p n-git-autoloads-file)
;;       (update-file-autoloads n-git-src-file t n-git-autoloads-file))
;;     (load-file n-git-autoloads-file)
;;     (require 'neotree n-git-src-file)
;;     (exz/debug "[NeoTree] Load local version.")))

;; (unless (boundp 'neotree-show)
;;   (require-package 'neotree))

(defun try-site-require-package (pkg &optional test-require in-elpa-p)
  "Try to load site package first."
  (let* ((n-git-path (exz/make-dotemacs-path (format "site-lisp/%s" pkg)))
         (n-git-autoloads-file (format "%s/%s-autoloads.el" n-git-path pkg))
         (n-git-test-file (format "%s/.git/HEAD" n-git-path))
         (n-git-src (format "%s/%s.el" n-git-path pkg)))
    (when (file-exists-p n-git-test-file)
      (add-to-list 'load-path n-git-path)
      (unless (file-exists-p n-git-autoloads-file)
        (exz/debug n-git-path t n-git-autoloads-file)
        (update-file-autoloads n-git-src t n-git-autoloads-file))
      (if (file-exists-p n-git-autoloads-file)
          (load-file n-git-autoloads-file)
        (require pkg))
      (exz/debug (format "[SITE PACKAGE] %s loaded." pkg))))
  (when (and test-require in-elpa-p)
    (unless (fboundp test-require)
      (require-package pkg))))

(try-site-require-package 'neotree 'neotree-show t)
(try-site-require-package 'neotree-projectile)

(custom-set-variables
 '(neo-theme (quote classic))
 '(neo-smart-open t)
 '(neo-vc-integration (quote (face))))
(global-set-key [f8] 'neotree-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; try to invoke neotree-find real-time (#47)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (defvar neo-n1 nil)

;; (defadvice buffer-list-update-hook
;;   (around neotree-buffer-list-update-hook activate)
;;   "Select WINDOW which must be a live window."
;;   (interactive)
;;   ad-do-it
;;   (message "x")
;;   ad-return-value)

;; (add-hook 'buffer-list-update-hook
;;           (lambda () (neotree-find)))


(provide 'init-neotree)
;;; init-neotree.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
