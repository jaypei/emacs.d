;;; Package --- Yasnippet config
;;; Commentary:
;;; Code:

(require-package 'yasnippet)

(require 'yasnippet)
(add-to-list 'yas/snippet-dirs
	     (expand-file-name "snippets" user-emacs-directory))

(yas-global-mode 1)
(add-hook 'yas-minor-mode-hook
	  (lambda ()
	    (local-set-key (kbd "C-z TAB") 'yas-expand)))

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
