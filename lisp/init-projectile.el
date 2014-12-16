;;; Package --- Projectile
;;; Commentary:
;;; Code:


(require-package 'projectile)
(require-package 'ack-and-a-half)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(setq projectile-switch-project-action 'neotree-projectile-action)

(provide 'init-projectile)
;;; init-projectile.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
