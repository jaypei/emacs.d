;;; Package --- ido config
;;; Commentary:

;;; Code:

(require-package 'ido-vertical-mode)

;; Use C-f during file selection to switch to regular find-file
(require 'ido)
(ido-mode t)
(ido-vertical-mode t)
(ido-everywhere t)

(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length 0)
(setq ido-use-virtual-buffers t)

(when (eval-when-compile (>= emacs-major-version 24))
 (require-package 'ido-ubiquitous)
 (ido-ubiquitous-mode t))

;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)

;; http://www.reddit.com/r/emacs/comments/21a4p9/use_recentf_and_ido_together/cgbprem
(add-hook 'ido-setup-hook (lambda () (define-key ido-completion-map [up] 'previous-history-element)))


(provide 'init-ido)
;;; init-ido.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:

