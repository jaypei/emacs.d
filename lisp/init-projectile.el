;;; Package --- Projectile
;;; Commentary:
;;; Code:


(require-package 'projectile)
(projectile-global-mode)

(setq projectile-switch-project-action 'projectile-dired)

(provide 'init-projectile)
;;; init-projectile.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
