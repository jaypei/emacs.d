;;; Package --- yet to be placed in separate files
;;; Commentary:
;;; Code:


(add-auto-mode 'tcl-mode "Portfile\\'")

(fset 'yes-or-no-p 'y-or-n-p)

(dolist (hook (if (fboundp 'prog-mode)
                  '(prog-mode-hook ruby-mode-hook)
                '(find-file-hooks)))
  (add-hook hook 'goto-address-prog-mode))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(setq-default goto-address-mail-face 'link)

(setq-default regex-tool-backend 'perl)

(add-auto-mode 'conf-mode "Procfile")

(if *is-a-mac*
    (setq save-interprogram-paste-before-kill nil))


(provide 'init-misc)
;;; init-misc.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
