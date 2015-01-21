;;; Package --- Fonts
;;; Commentary:

;;; Code:
;; font
(eval-when-compile (require 'cl))

(defun exz/set-font (english chinese english-size)
  (set-face-attribute 'default nil
                      :font (format "%s:pixelsize=%d" english english-size))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font (frame-parameter nil 'font) charset
                      (font-spec :family chinese))))

;; Mac chinese fonts:
;; - Heiti SC
;; - Hiragino Sans GB
;; - KaiTi
;; - STFangsong
;; - STHeiti
;; - STHupo
;; - STKaiti
(defun sanityinc/maybe-use-default-font-for-symbols ()
  "Force Emacs to render symbols using the default font, if so configured."
  (let (cn-name)
    (setq cn-name (if *is-a-mac* "STHeiti" "STHeiti"))
    (setq en-name (if *is-a-mac* "Inconsolata" "Ubuntu Mono"))
    (exz/set-font en-name cn-name 18)))

(when (display-graphic-p)
  (add-hook 'after-init-hook 'sanityinc/maybe-use-default-font-for-symbols))


;;; Changing font sizes

(require 'cl)

(defun sanityinc/font-name-replace-size (font-name new-size)
  (let ((parts (split-string font-name "-")))
    (setcar (nthcdr 7 parts) (format "%d" new-size))
    (mapconcat 'identity parts "-")))

(defun sanityinc/increment-default-font-height (delta)
  "Adjust the default font height by DELTA on every frame.
Emacs will keep the pixel size of the frame approximately the
same.  DELTA should be a multiple of 10, to match the units used
by the :height face attribute."
  (let* ((new-height (+ (face-attribute 'default :height) delta))
         (new-point-height (/ new-height 10)))
    (dolist (f (frame-list))
      (with-selected-frame f
        ;; Latest 'set-frame-font supports a "frames" arg, but
        ;; we cater to Emacs 23 by looping instead.
        (set-frame-font (sanityinc/font-name-replace-size
                         (face-font 'default)
                         new-point-height)
                        t)))
    (set-face-attribute 'default nil :height new-height)
    (message "Default font size is now %d" new-point-height)))

(defun sanityinc/increase-default-font-height ()
  (interactive)
  (sanityinc/increment-default-font-height 10))

(defun sanityinc/decrease-default-font-height ()
  (interactive)
  (sanityinc/increment-default-font-height -10))

(global-set-key (kbd "C-M-=") 'sanityinc/increase-default-font-height)
(global-set-key (kbd "C-M--") 'sanityinc/decrease-default-font-height)



(provide 'init-fonts)
;;; init-fonts.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:

