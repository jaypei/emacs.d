;;; Package --- Window config
;;; Commentary:
;;; Code:


;; (require-package 'sublimity)
;; (require 'sublimity)
;; (require 'sublimity-scroll)
;; (require 'sublimity-map)
;; (require 'sublimity-attractive)
;; (sublimity-global-mode)



;; window-number
(require-package 'window-numbering)
(require 'window-numbering)
(window-numbering-mode)



(require-package 'smooth-scrolling)

;; 防止页面滚动时跳动
(setq-default scroll-margin 3
              ;; scroll-conservatively 10000
              smooth-scroll-margin 3
              scroll-preserve-screen-position 'always)

;; Move window functions
(defmacro exz/make-window-move-fn (fn-name scroll-fn &optional callback)
  "Make scroll function FN-NAME used by SCROLL-FN."
  `(defun ,fn-name (&optional arg)
     (interactive "P")
     (if (null arg)
         (setq arg 2))
     (funcall ,scroll-fn arg)
     (unless (null ,callback))
     (funcall ,callback)))

(exz/make-window-move-fn window-move-up
                         'scroll-up (lambda () (smooth-scroll-up)))
(exz/make-window-move-fn window-move-down
                         'scroll-down (lambda() (smooth-scroll-down)))
(exz/make-window-move-fn other-window-move-up 'scroll-other-window)
(exz/make-window-move-fn other-window-move-down 'scroll-other-window-down)

(global-set-key (kbd "M-n") 'window-move-up)
(global-set-key (kbd "M-p") 'window-move-down)
(global-set-key (kbd "M-N") 'other-window-move-up)
(global-set-key (kbd "M-P") 'other-window-move-down)
(global-set-key [mouse-4] (lambda () (interactive) (window-move-down 1)))
(global-set-key [mouse-5] (lambda () (interactive) (window-move-up 1)))

(global-set-key (kbd "C-z k") 'delete-window)


(provide 'init-windows)
;;; init-windows.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
