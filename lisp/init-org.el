(when (< emacs-major-version 24)
  (require-package 'org))
(require-package 'org-fstree)

(unless (package-installed-p 'ox-reveal)
  (require 'org)
  (require-package 'ox-reveal))

(after-load 'org
  (require 'ox-publish)
  (require 'ox-html))

(when *is-a-mac*
  (require-package 'org-mac-link)
  (autoload 'org-mac-grab-link "org-mac-link" nil t)
  (require-package 'org-mac-iCal))


(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map (kbd "C-c a") 'org-agenda)

(defvar exz/org-note-dir "~/work/org")
(defvar exz/org-note-static-dir "~/work/org/static")
(defvar exz/org-note-publish-dir "~/work/org-publish")
(defvar exz/org-note-publish-static_dir "~/work/org-publish/static")
(defvar exz/org-default-notes-file "~/work/org/refile.org")
(defvar exz/org-agenda-files (quote ("~/work/org/todo")))

;; Various preferences
(setq-default org-log-done t
              org-completion-use-ido t
              org-edit-timestamp-down-means-later t
              org-agenda-start-on-weekday nil
              org-agenda-span 14
              org-agenda-include-diary t
              org-agenda-window-setup 'current-window
              org-agenda-files exz/org-agenda-files
              org-fast-tag-selection-single-key 'expert
              org-export-kill-product-buffer-when-displayed t
              org-tags-column 80
              org-src-fontify-natively t ; fontify code in code blocks
              org-directory exz/org-note-dir
              org-default-notes-file exz/org-default-notes-file
              )


(setq-default org-publish-project-alist
              '(
                ;; My note
                ("note-org"
                 :base-directory exz/org-note-dir
                 :publishing-directory exz/org-note-publish-dir
                 :base-extension "org"
                 :recursive t
                 :publishing-function org-html-publish-to-html
                 :auto-index nil
                 :index-filename "index.org"
                 :index-title "index"
                 :link-home "index.html"
                 :section-numbers nil
                 :style "<link rel=\"stylesheet\"
                       href=\"./style/emacs.css\"
                       type=\"text/css\"/>")
                ("note-static"
                 :base-directory "~/work/vimwiki/org-static"
                 :publishing-directory "~/work/vimwiki/org-publish/static"
                 :recursive t
                 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
                 :publishing-function org-publish-attachment)
                ("note"
                 :components ("note-org" "note-static")
                 :author "jaypei <jaypei97159@gmail.com>")
                ;; My blog
                ("jaypei-blog-org"
                 ;; Path to your org files.
                 :base-directory "~/work/jaypei-blog/org/"
                 :base-extension "org"
                 ;; Path to your Jekyll project.
                 :publishing-directory "~/work/jaypei-blog/jekyll/"
                 :recursive t
                 :publishing-function org-html-publish-to-html
                 :headline-levels 4
                 :html-extension "html"
                 :body-only t) ;; Only export section between <body> </body>
                ("jaypei-blog-static"
                 :base-directory "~/work/jaypei-blog/org/"
                 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|php"
                 :publishing-directory "~/work/jaypei-blog/"
                 :recursive t
                 :publishing-function org-publish-attachment)
                ("jaypei-blog" :components ("jaypei-blog-org" "jaypei-blog-static"))))

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c")
                (lambda ()
                  (find-file "~/work/org/todo/index.org")))

;; org
(add-hook 'org-mode-hook
          (lambda ()
            (org-indent-mode)
            (org-display-inline-images t)))

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)

; Refile targets include this file and any file contributing to the agenda - up to 5 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 5) (org-agenda-files :maxlevel . 5))))
; Targets start with the file name - allows creating level 1 tasks
(setq org-refile-use-outline-path (quote file))
; Targets complete in steps so we start with filename, TAB shows the next level of targets etc
(setq org-outline-path-complete-in-steps t)


(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)"))))

(setq-default org-todo-keyword-faces
              (quote (("TODO" :foreground "red" :weight bold)
                      ("NEXT" :foreground "blue" :weight bold)
                      ("DONE" :foreground "forest green" :weight bold)
                      ("WAITING" :foreground "orange" :weight bold)
                      ("HOLD" :foreground "magenta" :weight bold)
                      ("CANCELLED" :foreground "forest green" :weight bold)
                      ("MEETING" :foreground "forest green" :weight bold)
                      ("PHONE" :foreground "forest green" :weight bold))))

;; (setq org-todo-state-tags-triggers
;;       (quote (("CANCELLED" ("CANCELLED" . t))
;;               ("WAITING" ("WAITING" . t))
;;               ("HOLD" ("WAITING") ("HOLD" . t))
;;               (done ("WAITING") ("HOLD"))
;;               ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq-default org-capture-templates
              (quote (("t" "todo" entry (file exz/org-default-notes-file)
                       "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                      ("r" "respond" entry (file exz/org-default-notes-file)
                       "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
                      ("n" "note" entry (file exz/org-default-notes-file)
                       "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
                      ("j" "Journal" entry (file+datetree exz/org-default-notes-file)
                       "* %?\n%U\n" :clock-in t :clock-resume t)
                      ("w" "org-protocol" entry (file exz/org-default-notes-file)
                       "* TODO Review %c\n%U\n" :immediate-finish t)
                      ("m" "Meeting" entry (file exz/org-default-notes-file)
                       "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
                      ("p" "Phone call" entry (file exz/org-default-notes-file)
                       "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
                      ("h" "Habit" entry (file exz/org-default-notes-file)
                       "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persistence-insinuate t)
(setq org-clock-persist t)
(setq org-clock-in-resume t)

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)

;; Show clock sums as hours and minutes, not "n days" etc.
(setq org-time-clocksum-format
      '(:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t))

;; Show the clocked-in task - if any - in the header line
(defun sanityinc/show-org-clock-in-header-line ()
  (setq-default header-line-format '((" " org-mode-line-string " "))))

(defun sanityinc/hide-org-clock-from-header-line ()
  (setq-default header-line-format nil))

(add-hook 'org-clock-in-hook 'sanityinc/show-org-clock-in-header-line)
(add-hook 'org-clock-out-hook 'sanityinc/hide-org-clock-from-header-line)
(add-hook 'org-clock-cancel-hook 'sanityinc/hide-org-clock-from-header-line)

(after-load 'org-clock
  (define-key org-clock-mode-line-map [header-line mouse-2] 'org-clock-goto)
  (define-key org-clock-mode-line-map [header-line mouse-1] 'org-clock-menu))


(require-package 'org-pomodoro)
(after-load 'org-agenda
  (define-key org-agenda-mode-map (kbd "P") 'org-pomodoro))


(after-load 'org
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (define-key org-mode-map (kbd "M-h") nil))
  (define-key org-mode-map (kbd "C-M-<up>") 'org-up-element)
  (when *is-a-mac*
    (define-key org-mode-map (kbd "C-c g") 'org-mac-grab-link)))

(after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (ditaa . t)
     (dot . t)
     (emacs-lisp . t)
     (gnuplot . t)
     (haskell . nil)
     (latex . t)
     (ledger . t)
     (ocaml . nil)
     (octave . t)
     (python . t)
     (ruby . t)
     (screen . nil)
     (sh . t)
     (sql . nil)
     (sqlite . t)
     (perl . t)
     (plantuml . t))))

;; for plant-uml
(if *is-a-mac*
    (setq-default org-plantuml-jar-path
                  (expand-file-name "/usr/local/Cellar/plantuml/7987/plantuml.7987.jar")))


(provide 'init-org)
