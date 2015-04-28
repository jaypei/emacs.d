;;; Package --- Fonts
;;; Commentary:

;; Mac chinese fonts:
;; - Heiti SC
;; - Hiragino Sans GB
;; - KaiTi
;; - STFangsong
;; - STHeiti
;; - STHupo
;; - STKaiti
;; - Fantasque Sans Mono
;; - Ubuntu Mono

;;; Code:

(eval-when-compile
  (require 'cl))

(defcustom exz:font/linux '("STHeiti" "Fantasque Sans Mono" 16)
  "Linux font."
  :type '(cons (string :tag "cn")
               (string :tag "en")
               (integer :tag "size"))
  :group 'exz)

(defcustom exz:font/osx '("STHeiti" "Inconsolata" 16)
  "Mac osx font."
  :type '(cons (string :tag "cn")
               (string :tag "en")
               (integer :tag "size"))
  :group 'exz)


(defun exz:maybe-use-default-font-for-symbols ()
  "Force Emacs to render symbols using the default font, if so configured."
  (let (cst-var cn en size)
    (setq cst-var (if *is-a-mac* exz:font/osx exz:font/linux))
    (setq cn (car cst-var)
          en (car (cdr cst-var))
          size (car (cdr (cdr cst-var))))
    (set-face-attribute 'default nil
                        :font (format "%s:pixelsize=%d" en size))
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font) charset
                        (font-spec :family cn)))))


(when (display-graphic-p)
  (add-hook 'after-init-hook 'exz:maybe-use-default-font-for-symbols))


;;; Changing font sizes

(defun exz:font-name-replace-size (font-name new-size)
  (let ((parts (split-string font-name "-")))
    (setcar (nthcdr 7 parts) (format "%d" new-size))
    (mapconcat 'identity parts "-")))

(defun exz:increment-default-font-height (delta)
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
        (set-frame-font (exz:font-name-replace-size
                         (face-font 'default)
                         new-point-height)
                        t)))
    (set-face-attribute 'default nil :height new-height)
    (message "Default font size is now %d" new-point-height)))

(defun exz:increase-default-font-height ()
  (interactive)
  (exz:increment-default-font-height 10))

(defun exz:decrease-default-font-height ()
  (interactive)
  (exz:increment-default-font-height -10))

(global-set-key (kbd "C-M-=") 'exz:increase-default-font-height)
(global-set-key (kbd "C-M--") 'exz:decrease-default-font-height)



(provide 'init-fonts)
;;; init-fonts.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:

