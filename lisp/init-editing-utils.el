;;; Package --- Editing
;;; Commentary:

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.

;;; Code:

(require-package 'whole-line-or-region)

;; Some basic preferences
(setq-default
 bookmark-default-file (expand-file-name ".bookmarks.el" user-emacs-directory)
 cursor-type 'box
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 compilation-scroll-output t
 delete-selection-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 grep-highlight-matches t
 grep-scroll-output t
 indent-tabs-mode nil
 make-backup-files nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-partial-width-windows nil
 visible-bell t
 auto-save-default nil
 kill-ring-max 200                  ; 用一个很大的 kill ring. 防止误删
 truncate-lines t)

(when *is-a-mac*
  (setq-default locate-command "mdfind"))

(transient-mark-mode t)
(blink-cursor-mode -1)


;;; Whitespace

(defun sanityinc/no-trailing-whitespace ()
  "Turn off display of trailing whitespace in this buffer."
  (setq show-trailing-whitespace nil))

;; But don't show trailing whitespace in SQLi, inf-ruby etc.
(dolist (hook '(special-mode-hook
                eww-mode
                term-mode-hook
                comint-mode-hook
                compilation-mode-hook
                twittering-mode-hook
                minibuffer-setup-hook))
  (add-hook hook #'sanityinc/no-trailing-whitespace))


;;; Newline behaviour

(global-set-key (kbd "RET") 'newline-and-indent)
(defun sanityinc/newline-at-end-of-line ()
  "Move to end of line, enter a newline, and reindent."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))

(global-set-key (kbd "S-<return>") 'sanityinc/newline-at-end-of-line)



(when (fboundp 'global-prettify-symbols-mode)
  (global-prettify-symbols-mode))


(require-package 'undo-tree)
(global-undo-tree-mode)
(diminish 'undo-tree-mode)


;; Show matching parens
(require-package 'highlight-parentheses)
(require 'highlight-parentheses)
(exz/add-hooks 'highlight-parentheses-mode
               (list 'emacs-lisp-mode-hook
                     'lisp-interaction-mode-hook
                     'python-mode-hook
                     'go-mode-hook
                     'c-mode-common-hook))
(setq show-paren-style 'parentheses)
(show-paren-mode 1)


;; Don't disable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; Don't disable case-change functions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)


;; Handy key bindings

;; prefix definition
(define-prefix-command 'exz-z-map)
(global-set-key (kbd "C-x C-z") 'exz-z-map)
(global-set-key (kbd "C-z") 'exz-z-map)

;; To be able to M-x without meta
(global-set-key (kbd "C-x C-m") 'execute-extended-command)

;; Vimmy alternatives to M-^ and C-u M-^
(global-set-key (kbd "C-c j") 'join-line)
(global-set-key (kbd "C-c J") (lambda () (interactive) (join-line 1)))

(global-set-key (kbd "C-.") 'set-mark-command)
(global-set-key (kbd "C-x C-.") 'pop-global-mark)

(require-package 'ace-jump-mode)
(global-set-key (kbd "C-'") 'ace-jump-char-mode)
(global-set-key (kbd "C-\"") 'ace-jump-mode)

;; multiple-cursors
(require-package 'multiple-cursors)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-+") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; From active region to multiple cursors:
(global-set-key (kbd "C-c c r") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-c c c") 'mc/edit-lines)
(global-set-key (kbd "C-c c e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-c c a") 'mc/edit-beginnings-of-lines)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

(global-set-key (kbd "C-1") 'move-beginning-of-line)
(global-set-key (kbd "C-2") 'set-mark-command)
(global-set-key (kbd "C-3") 'move-end-of-line)

;; Train myself to use M-f and M-b instead
(global-unset-key [M-left])
(global-unset-key [M-right])



(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))

(global-set-key (kbd "C-M-<backspace>") 'kill-back-to-indentation)



;; Page break lines
(require-package 'page-break-lines)
(custom-set-variables
 '(page-break-lines-char 126))
(custom-set-faces
 '(page-break-lines ((t (:inherit warning :slant normal :weight normal)))))
(global-page-break-lines-mode)
(diminish 'page-break-lines-mode)


;; Fill column indicator
(when (eval-when-compile (> emacs-major-version 23))
  (require-package 'fill-column-indicator)
  (defun sanityinc/prog-mode-fci-settings ()
    (turn-on-fci-mode)
    (when show-trailing-whitespace
      (set (make-local-variable 'whitespace-style) '(face trailing))
      (whitespace-mode 1)))

  ;;(add-hook 'prog-mode-hook 'sanityinc/prog-mode-fci-settings)

  (defun sanityinc/fci-enabled-p ()
    (and (boundp 'fci-mode) fci-mode))

  (defvar sanityinc/fci-mode-suppressed nil)
  (defadvice popup-create (before suppress-fci-mode activate)
    "Suspend fci-mode while popups are visible"
    (let ((fci-enabled (sanityinc/fci-enabled-p)))
      (when fci-enabled
        (set (make-local-variable 'sanityinc/fci-mode-suppressed) fci-enabled)
        (turn-off-fci-mode))))
  (defadvice popup-delete (after restore-fci-mode activate)
    "Restore fci-mode when all popups have closed"
    (when (and sanityinc/fci-mode-suppressed
               (null popup-instances))
      (setq sanityinc/fci-mode-suppressed nil)
      (turn-on-fci-mode)))

  ;; Regenerate fci-mode line images after switching themes
  (defadvice enable-theme (after recompute-fci-face activate)
    (dolist (buffer (buffer-list))
      (with-current-buffer buffer
        (when (sanityinc/fci-enabled-p)
          (turn-on-fci-mode))))))


;; Shift lines up and down with M-up and M-down. When paredit is enabled,
;; it will use those keybindings. For this reason, you might prefer to
;; use M-S-up and M-S-down, which will work even in lisp modes.

(require-package 'move-dup)
(global-set-key [M-up] 'md/move-lines-up)
(global-set-key [M-down] 'md/move-lines-down)
(global-set-key [M-S-up] 'md/move-lines-up)
(global-set-key [M-S-down] 'md/move-lines-down)

;; Temporary patch pending https://github.com/wyuenho/move-dup/pull/4
(after-load 'move-dup
  (defun md/move-line (&optional n)
    "Interactive function to move the current line N line.

If the prefix N is positive, this function moves the current line
forward N lines; otherwise backward."
    (interactive "*p")
    (let ((col (current-column)))
      (goto-char (save-excursion
                   (push-mark)
                   (end-of-line)
                   (md/move-region n)
                   (region-beginning)))
      (move-to-column col))))

(global-set-key (kbd "C-c p") 'md/duplicate-down)
(global-set-key (kbd "C-c P") 'md/duplicate-up)


;; Cut/copy the current line if no region is active
(whole-line-or-region-mode t)
(diminish 'whole-line-or-region-mode)
(make-variable-buffer-local 'whole-line-or-region-mode)


;; Rectangle selections, and overwrite text when the selection is active
(cua-selection-mode t)                  ; for rectangles, CUA is nice

(defun suspend-mode-during-cua-rect-selection (mode-name)
  "Add an advice to suspend `MODE-NAME' while selecting a CUA rectangle."
  (let ((flagvar (intern (format "%s-was-active-before-cua-rectangle" mode-name)))
        (advice-name (intern (format "suspend-%s" mode-name))))
    (eval-after-load 'cua-rect
      `(progn
         (defvar ,flagvar nil)
         (make-variable-buffer-local ',flagvar)
         (defadvice cua--activate-rectangle (after ,advice-name activate)
           (setq ,flagvar (and (boundp ',mode-name) ,mode-name))
           (when ,flagvar
             (,mode-name 0)))
         (defadvice cua--deactivate-rectangle (after ,advice-name activate)
           (when ,flagvar
             (,mode-name 1)))))))

(suspend-mode-during-cua-rect-selection 'whole-line-or-region-mode)



(defun sanityinc/open-line-with-reindent (n)
  "A version of `open-line' which reindents the start and end positions.
If there is a fill prefix and/or a `left-margin', insert them
on the new line if the line would have been blank.
With arg N, insert N newlines."
  (interactive "*p")
  (let* ((do-fill-prefix (and fill-prefix (bolp)))
	 (do-left-margin (and (bolp) (> (current-left-margin) 0)))
	 (loc (point-marker))
	 ;; Don't expand an abbrev before point.
	 (abbrev-mode nil))
    (delete-horizontal-space t)
    (newline n)
    (indent-according-to-mode)
    (when (eolp)
      (delete-horizontal-space t))
    (goto-char loc)
    (while (> n 0)
      (cond ((bolp)
	     (if do-left-margin (indent-to (current-left-margin)))
	     (if do-fill-prefix (insert-and-inherit fill-prefix))))
      (forward-line 1)
      (setq n (1- n)))
    (goto-char loc)
    (end-of-line)
    (indent-according-to-mode)))

(global-set-key (kbd "C-o") 'sanityinc/open-line-with-reindent)



;; Random line sorting
(defun sort-lines-random (beg end)
  "Sort lines in region randomly."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr nil 'forward-line 'end-of-line nil nil
                   (lambda (s1 s2) (eq (random 2) 0)))))))



(defun exz/ttypaste-mode ()
  (interactive)
  (let ((buf (current-buffer))
        (ttypaste-mode t))
    (with-temp-buffer
      (let ((stay t)
            (text (current-buffer)))
        (redisplay)
        (while stay
          (let ((char (let ((inhibit-redisplay t)) (read-event nil t 0.1))))
            (unless char
              (with-current-buffer buf (insert-buffer-substring text))
              (erase-buffer)
              (redisplay)
              (setq char (read-event nil t)))
            (cond
             ((not (characterp char)) (setq stay nil))
             ((eq char ?\r) (insert ?\n))
             ((eq char ?\e)
              (if (sit-for 0.1 'nodisp) (setq stay nil) (insert ?\e)))
             (t (insert char)))))
        (insert-buffer-substring text)))))

;; TODO
(defun exz/select-last-buffer ()
  (delq nil
        (mapcar (lambda (x) (and (buffer-file-name x) x))
                (buffer-list))))


(provide 'init-editing-utils)
;;; init-editing-utils.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
