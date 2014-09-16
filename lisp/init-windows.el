;;; Package --- Window config
;;; Commentary:
;;; Code:


;; window-number
(require-package 'window-number)
(require 'window-number)
(window-number-meta-mode)



;; Move window functions
(defmacro exz/make-window-move-fn (fn-name scroll-fn)
  "Make scroll function FN-NAME used by SCROLL-FN."
  `(defun ,fn-name (&optional arg)
     (interactive "P")
     (if (null arg)
         (setq arg 3))
     (funcall ,scroll-fn arg)))

(exz/make-window-move-fn window-move-up 'scroll-up)
(exz/make-window-move-fn window-move-down 'scroll-down)
(exz/make-window-move-fn other-window-move-up 'scroll-other-window)
(exz/make-window-move-fn other-window-move-down 'scroll-other-window-down)

(global-set-key (kbd "M-n") 'window-move-up)
(global-set-key (kbd "M-p") 'window-move-down)
(global-set-key (kbd "M-N") 'other-window-move-up)
(global-set-key (kbd "M-P") 'other-window-move-down)
(global-set-key (kbd "C-z k") 'delete-window)


(provide 'init-windows)
;;; init-windows.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
