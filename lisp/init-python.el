;;; Package --- Python
;;; Commentary:

;;; Code:


(require-package 'jedi)
(require-package 'virtualenvwrapper)

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
		("SConscript\\'" . python-mode))
              auto-mode-alist))

(when *is-my-home-arch*
  (custom-set-variables
   '(python-environment-virtualenv
     (list "virtualenv2" "--system-site-packages" "--quiet"))
   '(python-shell-interpreter "python2")))

(defun exz/eval-buffer-as-python ()
  "Run buffer content as python program."
  (interactive)
  (save-buffer t)
  (shell-command (concat python-shell-interpreter " " (buffer-file-name))))

(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
       (setq value (cons (format "%s%s" prefix element) value))))))

(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))

(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))

(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'ac-find-function) 'ac-python-find)
            (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)))

(set-variable 'py-indent-offset 4)
(set-variable 'python-indent-guess-indent-offset nil)

; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
;; (setq py-python-command-args
;;         '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-c |")
              'py-execute-region-ipython)
            (define-key python-mode-map (kbd "C-c C-c")
              'exz/eval-buffer-as-python)
            (if (functionp 'flycheck-mode)
                (flycheck-mode))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Jedi-Helpers: Enable virtualenv based on project root directory
;; Copied from: https://github.com/tkf/emacs-jedi/issues/123
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun exz/python-project-directory (buffer-name)
  "Returns the root directory of the project that contains the
given buffer. Any directory with a .git or .jedi file/directory
is considered to be a project root."
  (interactive)
  (let ((root-dir (file-name-directory buffer-name)))
    (while (and root-dir
                (not (file-exists-p (concat root-dir ".git")))
                (not (file-exists-p (concat root-dir ".jedi"))))
      (setq root-dir
            (if (equal root-dir "/")
                nil
              (file-name-directory (directory-file-name root-dir)))))
    root-dir))

(defun exz/python-project-name (buffer-name)
  "Returns the name of the project that contains the given buffer."
  (let ((root-dir (exz/python-project-directory buffer-name)))
    (if root-dir
        (file-name-nondirectory
         (directory-file-name root-dir))
      nil)))

(defun exz/jedi-setup-venv ()
  "Activates the virtualenv of the current buffer."
  (let ((file-name (buffer-file-name))
        project-name)
    (when (not (null file-name))
      (setq project-name (exz/python-project-name buffer-file-name))
      (when project-name
        (progn
          (message (concat
                    "use virtualenv: "
                    project-name))
          (venv-workon project-name))))))

(add-hook 'python-mode-hook 'exz/jedi-setup-venv)
(add-hook 'python-mode-hook 'jedi:setup)
(setq-default jedi:complete-on-dot t)

(provide 'init-python)
;;; init-python.el ends here

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
