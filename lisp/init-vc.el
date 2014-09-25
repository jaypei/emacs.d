;;; Package --- Vc
;;; Commentary:

;;; Code:


(require-package 'diff-hl)
;; (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
;; (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
(global-diff-hl-mode t)


(provide 'init-vc)
;;; init-vc.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
