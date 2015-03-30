;;; Package --- A calendar framework for Emacs
;;; Commentary:

;;; Code:

(require-package 'calfw)
(require 'calfw-cal)
(require 'calfw-org)

(setq calendar-week-start-day 1)        ; 0:Sunday, 1:Monday

(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "Green")  ; orgmode source
    (cfw:cal-create-source "Orange") ; diary source
    )))

;; (global-set-key

(provide 'init-calfw)
;;; init-calfw.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
