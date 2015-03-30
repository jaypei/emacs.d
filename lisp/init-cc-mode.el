;;; Package --- C/C++ mode
;;; Commentary:

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;;; Code:

(defun exz/cc-mode-setup ()
  "The indent setup function in cc-mode."
  (defconst exz/c-coding-style
    '((c-tab-always-indent . t)
      (c-comment-only-line-offset . 0)
      (c-hanging-braces-alist . ((substatement-open after)
                                 (brace-list-open)))
      (c-cleanup-list . (comment-close-slash
                         compact-empty-funcall))
      (c-offsets-alist . ((substatement-open . 0)
                          (innamespace . 0)
                          (case-label      . +)
                          (access-label . -)
                          (block-open     . 0)))
      (setq comment-start "/*"
            comment-end "*/")
      (setq indent-tabs-mode nil))
    "exz c coding style")
  (c-add-style "exz/c-coding-style" exz/c-coding-style)
  (c-set-style "exz/c-coding-style"))

(add-hook 'c-mode-hook 'exz/cc-mode-setup)
(add-hook 'c++-mode-hook 'exz/cc-mode-setup)

(require-package 'helm-gtags)

;; Enable helm-gtags-mode
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; Set key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)))

(defun exz/cc-switch-between-header-and-source ()
  "Switch between a c/c++ header (.h) and its corresponding source (.c/.cpp)."
  (interactive)
  ;; grab the base of the current buffer's file name
  (setq bse (file-name-sans-extension buffer-file-name))
  ;; and the extension, converted to lowercase so we can
  ;; compare it to "h", "c", "cpp", etc
  (setq ext (downcase (file-name-extension buffer-file-name)))
  ;; This is like a c/c++ switch statement, except that the
  ;; conditions can be any true/false evaluated statement
  (cond
   ;; first condition - the extension is "h"
   ((equal ext "h")
    ;; first, look for bse.c
    (setq nfn (concat bse ".c"))
    (if (file-exists-p nfn)
        ;; if it exists, either switch to an already-open
        ;;  buffer containing that file, or open it in a new buffer
        (find-file nfn)
      ;; this is the "else" part - note that if it is more than
      ;;  one line, it needs to be wrapped in a (progn )
      (progn
        ;; look for a bse.cpp
        (setq nfn (concat bse ".cpp"))
        ;; likewise
        (find-file nfn))))
   ;; second condition - the extension is "c" or "cpp"
   ((or (equal ext "cpp") (equal ext "c"))
    ;; look for a corresponding bse.h
    (setq nfn (concat bse ".h"))
    (find-file nfn))))

;; Enable helm-gtags-mode
(global-set-key [f4] 'exz/cc-switch-between-header-and-source)


(provide 'init-cc-mode)
;;; init-cc-mode.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
