;;; Package --- Git config
;;; Commentary:
;;; Code:


(require-package 'magit)
(require-package 'git-commit-mode)
(require-package 'git-rebase-mode)
(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)

(require-package 'git-gutter)
(require-package 'git-gutter-fringe)

;; git-gutter
(require 'git-gutter-fringe)
(global-git-gutter-mode +1)
(custom-set-variables
 '(git-gutter:disabled-modes '(org-mode image-mode)))
(global-set-key (kbd "C-c C-n") 'git-gutter:next-hunk)
(global-set-key (kbd "C-c C-p") 'git-gutter:previous-hunk)

(setq-default
 magit-save-some-buffers nil
 magit-process-popup-time 10
 magit-diff-refine-hunk t
 magit-completing-read-function 'magit-ido-completing-read)

;; Hint: customize `magit-repo-dirs' so that you can use C-u M-F12 to
;; quickly open magit on any one of your projects.
(global-set-key [(meta f12)] 'magit-status)

(after-load 'magit
  (define-key magit-status-mode-map (kbd "C-M-<up>") 'magit-goto-parent-section))

(require-package 'fullframe)
(after-load 'magit
  (fullframe magit-status magit-mode-quit-window))

(add-hook 'git-commit-mode-hook 'goto-address-mode)


;;; When we start working on git-backed files, use git-wip if available

(after-load 'magit
  (global-magit-wip-save-mode)
  (diminish 'magit-wip-save-mode))

(after-load 'magit
  (diminish 'magit-auto-revert-mode))


(when *is-a-mac*
  (after-load 'magit
    (add-hook 'magit-mode-hook (lambda () (local-unset-key [(meta h)])))))


(provide 'init-git)
;;; init-git.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
