;;; Package --- Hippie expand
;;; Commentary:

;;; Code:


(global-set-key (kbd "M-/") 'hippie-expand)

(setq hippie-expand-try-functions-list
      '(try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill))


(provide 'init-hippie-expand)
;;; init-hippie-expand.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
