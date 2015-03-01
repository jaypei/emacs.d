;;; Package --- Vc
;;; Commentary:

;;; Code:


(require-package 'diff-hl)
;; (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
;; (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
(global-diff-hl-mode t)
(global-set-key (kbd "C-c g p") 'diff-hl-previous-hunk)
(global-set-key (kbd "C-c g n") 'diff-hl-next-hunk)


(provide 'init-vc)
;;; init-vc.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
