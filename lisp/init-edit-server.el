;;; Package --- Edit server
;;; Commentary:

;; Chrome plugin:
;;    https://chrome.google.com/webstore/detail/ljobjlafonikaiipfkggjbhkghgicgoh

;;; Code:

(require-package 'edit-server)
(require-package 'edit-server-htmlize)

;; (add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
;; (add-hook 'edit-server-done-hook 'edit-server-maybe-htmlize-buffer)

(add-hook 'after-init-hook 'edit-server-start)

(provide 'init-edit-server)
;;; init-edit-server.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
