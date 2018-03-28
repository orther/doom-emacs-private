;;; private/personal/config.el -*- lexical-binding: t; -*-

(if (featurep! +bindings) (load! +bindings))

;; (defvar +orther-dir (file-name-directory load-file-name))
;; (defvar +orther-snippets-dir (expand-file-name "snippets/" +orther-dir))


;; ;; Don't use default snippets, use mine.
;; (after! yasnippet
;;   (setq yas-snippet-dirs (append (list '+orther-snippets-dir)
;;                                  (delete 'yas-installed-snippets-dir yas-snippet-dirs))))

;; prevent "ls does not support --dired;" error by using coreutils gls rather than macOS ls
(let ((gls "/usr/local/bin/gls"))
  (if (file-exists-p gls) (setq insert-directory-program gls)))

;; TODO replace w/ real jest package
(load! +jest)

;; coverlay overlay colors
(setq coverlay:untested-line-background-color (doom-blend 'red 'bg 0.3)
      coverlay:tested-line-background-color (doom-blend 'green 'bg 0.0))

;; ;; maximize emacs upon startup
;; (toggle-frame-maximized)


;; set indentation
(setq-default tab-width 2
              tab-width 2
              c-basic-offset 2
              coffee-tab-width 2
              javascript-2-level 2
              js-2-level 2
              js2-basic-offset 2
              web-mode-markup-2-offset 2
              web-mode-css-2-offset 2
              web-mode-code-2-offset 2
              css-2-offset 2
              rust-indent-offset 2)

;; customize doom neotree
(setq doom-neotree-enable-file-icons t)
(setq doom-neotree-file-icons t)
(after! neotree
  :config
  (setq neo-create-file-auto-open t
        neo-window-width 35
        neo-hidden-regexp-list (append neo-hidden-regexp-list
                                       '(".happypack" ".vscode" ".log$" ".DS_Store"))))

;; *** Company
(after! company
  (setq company-tooltip-limit 10
        company-minimum-prefix-length 2
        company-idle-delay 0.2
        company-tooltip-minimum-width 60
        company-tooltip-margin 0
        company-show-numbers t
        company-tooltip-offset-display nil
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case nil
        company-dabbrev-code-other-buffers t
        company-tooltip-align-annotations t
        company-require-match 'never
        company-frontends '(company-childframe-frontend company-echo-metadata-frontend)
        company-global-modes '(not comint-mode erc-mode message-mode help-mode gud-mode)
        company-childframe-child-frame nil))
(set! :company-backend '(emacs-lisp-mode) '(company-elisp company-files company-yasnippet company-dabbrev-code))
(set! :company-backend '(python-mode) '(company-anaconda company-files company-yasnippet company-dabbrev-code))
(set! :company-backend '(inferior-python-mode) '(company-capf company-files company-yasnippet company-dabbrev-code))
(set! :company-backend '(inferior-ess-mode) '(company-capf company-files company-yasnippet company-dabbrev-code))
(set! :company-backend '(org-mode) '(company-capf company-files company-yasnippet company-dabbrev))
(set! :lookup 'emacs-lisp-mode :documentation #'helpful-at-point)

;; ** Help
(after! helpful
  (set! :lookup 'helpful-mode :documentation #'helpful-at-point)
  (set! :popup "^\\*helpful.*"
    '((size . 80) (side . right))
    '((select . t) (quit . t))))

(def-package! tldr
  :commands (tldr)
  :config
  (setq tldr-directory-path (concat doom-etc-dir "tldr/"))
  (set! :popup "^\\*tldr\\*"
    '((size . 80) (side . right))
    '((transient . nil)  (modeline . nil) (select . t) (quit . t))))

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . 'dark))

;; ** Tramp
(after! tramp-sh
  (add-to-list 'tramp-remote-path ""))
(def-package! counsel-tramp
  :commands (counsel-tramp)
  :init
  (package-initialize))
;; (def-package! docker-tramp
;;   :after tramp)

(after! recentf
  (add-to-list 'recentf-exclude 'file-remote-p)
  (add-to-list 'recentf-exclude ".*\\.gz$")
  (add-to-list 'recentf-exclude ".*\\.gpg$")
  (add-to-list 'recentf-exclude ".*\\.gif$")
  (add-to-list 'recentf-exclude ".*\\.pdf$")
  (add-to-list 'recentf-exclude ".*\\.svg$")
  (add-to-list 'recentf-exclude "/sudo:")
  (add-to-list 'recentf-exclude "/GTAGS$")
  (add-to-list 'recentf-exclude "/GRAGS$")
  (add-to-list 'recentf-exclude "/GPATH$")
  (add-to-list 'recentf-exclude "\\.mkv$")
  (add-to-list 'recentf-exclude "\\.mp[34]$")
  (add-to-list 'recentf-exclude "\\.avi$")
  (add-to-list 'recentf-exclude "\\.sub$")
  (add-to-list 'recentf-exclude "\\.srt$")
  (add-to-list 'recentf-exclude "\\.ass$")
  (add-to-list 'recentf-exclude ".*_archive$")
  (add-to-list 'recentf-exclude "COMMIT_MSG")
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG")
  (add-to-list 'recentf-exclude ".*Cellar.*"))

(add-hook 'minibuffer-setup-hook #'smartparens-mode)
(add-hook 'minibuffer-setup-hook #'doom|no-fringes-in-minibuffer)
(set-window-fringes (minibuffer-window) 0 0 nil)

;; ;; ** Magit
;; (def-package! orgit :after magit)
;; (after! magithub
;;   (require 'parse-time)
;;   (defmacro magithub--time-number-of-days-since-string (iso8601)
;;     `(time-to-number-of-days
;;       (time-since
;;        (parse-iso8601-time-string
;;         (concat ,iso8601 "+00:00")))))

;;   (defun issue-filter-to-days (days type)
;;     `(lambda (issue)
;;        (let ((created_at (magithub--time-number-of-days-since-string
;;                           (alist-get 'created_at issue)))
;;              (updated_at (magithub--time-number-of-days-since-string
;;                           (alist-get 'updated_at issue))))
;;          (or (< created_at ,days) (< updated_at ,days)))))

;;   (defun magithub-filter-maybe (&optional limit)
;;     "Add filters to magithub only if number of issues is greter than LIMIT."
;;     (let ((max-issues (length (ignore-errors (magithub-issues))))
;;           (max-pull-requests (length (ignore-errors (magithub-pull-requests))))
;;           (limit (or limit 1)))
;;       (when (> max-issues limit)
;;         (add-to-list (make-local-variable 'magithub-issue-issue-filter-functions)
;;                      (issue-filter-to-days limit "issues")))
;;       (when (> max-pull-requests limit)
;;         (add-to-list (make-local-variable 'magithub-issue-pull-request-filter-functions)
;;                      (issue-filter-to-days limit "pull-requests")))))

;;   (add-to-list 'magit-status-mode-hook #'magithub-filter-maybe)
;;   (setq magithub-clone-default-directory "~/workspace/sources/"))
;; (after! magit
;;   (magit-wip-after-save-mode 1)
;;   (magit-wip-after-apply-mode 1)
;;   (magithub-feature-autoinject t)
;;   (setq magit-repository-directories '("~/dev/"))
;;   (set! :evil-state 'magit-repolist-mode 'normal)
;;   (map! (:map with-editor-mode-map
;;           (:localleader
;;             :desc "Finish" :n "," #'with-editor-finish
;;             :desc "Abort"  :n "k" #'with-editor-cancel)))
;;   (set! :popup "^.*magit" '((slot . -1) (side . right) (size . 80)) '((modeline . nil) (select . t)))
;;   (set! :popup "^\\*magit.*popup\\*" '((slot . 0) (side . right)) '((modeline . nil) (select . t)))
;;   (set! :popup "^.*magit-revision:.*" '((slot . 2) (side . right) (window-height . 0.6)) '((modeline . nil) (select . t)))
;;   (set! :popup "^.*magit-diff:.*" '((slot . 2) (side . right) (window-height . 0.6)) '((modeline . nil) (select . nil))))


;; * Ivy Actions
(after! counsel
  (defun +ivy-recentf-transformer (str)
    "Dim recentf entries that are not in the current project of the buffer you
started `counsel-recentf' from. Also uses `abbreviate-file-name'."
    (abbreviate-file-name str))
  ;; ** counsel-find-file
  (defun +ivy/reloading (cmd)
    (lambda (x)
      (funcall cmd x)
      (ivy--reset-state ivy-last)))
  (defun +ivy/given-file (cmd prompt) ; needs lexical-binding
    (lambda (source)
      (let ((target
             (let ((enable-recursive-minibuffers t))
               (read-file-name
                (format "%s %s to:" prompt source)))))
        (funcall cmd source target 1))))
  (defun +ivy/confirm-delete-file (x)
    (dired-delete-file x 'confirm-each-subdirectory))
  (ivy-add-actions
   'counsel-find-file
   `(("c" ,(+ivy/given-file #'copy-file "Copy file") "copy file")
     ("d" ,(+ivy/reloading #'+ivy/confirm-delete-file) "delete")
     ("r" (lambda (path) (rename-file path (read-string "New name: "))) "Rename")
     ("m" ,(+ivy/reloading (+ivy/given-file #'rename-file "Move")) "move")
     ("f" find-file-other-window "other window")
     ("p" (lambda (path) (with-ivy-window (insert (f-relative path)))) "Insert relative path")
     ("P" (lambda (path) (with-ivy-window (insert path))) "Insert absolute path")
     ("l" (lambda (path) "Insert org-link with relative path"
            (with-ivy-window (insert (format "[[./%s]]" (f-relative path))))) "Insert org-link (rel. path)")
     ("L" (lambda (path) "Insert org-link with absolute path"
            (with-ivy-window (insert (format "[[%s]]" path)))) "Insert org-link (abs. path)")))
  ;; ** counsel-M-x
  (defun +ivy/helpful-function (prompt)
    (helpful-function (intern prompt)))
  (defun +ivy/find-function (prompt)
    (find-function (intern prompt)))
  (ivy-add-actions
   'counsel-M-x
   `(("h" +ivy/helpful-function "Helpful")
     ("f" +ivy/find-function "Find"))))
(after! counsel-projectile
  (ivy-add-actions
   'counsel-projectile-switch-project
   `(("f" counsel-projectile-switch-project-action-find-file
      "jump to a project file")
     ("d" counsel-projectile-switch-project-action-find-dir
      "jump to a project directory")
     ("b" counsel-projectile-switch-project-action-switch-to-buffer
      "jump to a project buffer")
     ("m" counsel-projectile-switch-project-action-find-file-manually
      "find file manually from project root")
     ("S" counsel-projectile-switch-project-action-save-all-buffers
      "save all project buffers")
     ("k" counsel-projectile-switch-project-action-kill-buffers
      "kill all project buffers")
     ("K" counsel-projectile-switch-project-action-remove-known-project
      "remove project from known projects")
     ("c" counsel-projectile-switch-project-action-compile
      "run project compilation command")
     ("C" counsel-projectile-switch-project-action-configure
      "run project configure command")
     ("E" counsel-projectile-switch-project-action-edit-dir-locals
      "edit project dir-locals")
     ("v" counsel-projectile-switch-project-action-vc
      "open project in vc-dir / magit / monky")
     ("sr" counsel-projectile-switch-project-action-rg
      "search project with rg")
     ("xs" counsel-projectile-switch-project-action-run-shell
      "invoke shell from project root")
     ("xe" counsel-projectile-switch-project-action-run-eshell
      "invoke eshell from project root")
     ("xt" counsel-projectile-switch-project-action-run-term
      "invoke term from project root")
     ("O" counsel-projectile-switch-project-action-org-capture
      "org-capture into project"))))

;; https://en.wikipedia.org/wiki/list_of_tz_database_time_zones
(setq display-time-world-list
      '(("America/New_York" "New York")
        ("America/Los_Angeles" "Seattle")
        ("Asia/Shanghai" "Shanghai")
        ("Asia/Tokyo" "Tokyo")
        ("Australia/Sydney" "Sydney")
        ("Europe/London" "London")
        ("Europe/Berlin" "Germany")
        ("Europe/Rome" "Italy")
        ("Europe/Paris" "Paris")))

;; quick way to dispaly world time clock
(defalias 'wc 'display-time-world)

(def-package! keyfreq
  :config
  (setq keyfreq-excluded-commands '(evil-next-line
                                    evil-previous-line
                                    evil-next-visual-line
                                    self-insert-command
                                    evil-previous-visual-line
                                    evil-forward-char
                                    forward-char
                                    org-self-insert-command
                                    ivy-next-line
                                    evil-forward-word-end
                                    doom/deflate-space-maybe
                                    doom/escape
                                    evil-backward-word-begin
                                    ivy-previous-line
                                    evil-backward-char
                                    backward-char
                                    ivy-backward-delete-char
                                    mwheel-scroll
                                    company-ignore
                                    evil-ex-search-next
                                    evil-normal-state
                                    evil-scroll-down
                                    evil-scroll-up
                                    ivy-done
                                    right-char
                                    keyboard-escape-quit
                                    left-char
                                    doom/inflate-space-maybe
                                    evil-visual-char
                                    term-send-raw
                                    save-buffer
                                    company-select-next-or-abort
                                    term-send-left
                                    +org/toggle-fold
                                    evil-delete
                                    neotree-next-line
                                    neotree-previous-line
                                    term-send-backspace
                                    undo-tree-undo
                                    xwidget-webkit-scroll-down-line
                                    evil-force-normal-state
                                    xwidget-webkit-scroll-up-line))
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

;; ;; maximize emacs upon startup
;; (toggle-frame-maximized)

;; (def-package! atomic-chrome
;;   :hook (doom-post-init . atomic-chrome-start-server)
;;   :config
;;   (setq atomic-chrome-default-major-mode 'markdown-mode)
;;   (setq atomic-chrome-url-major-mode-alist
;;         '(("github" . gfm-mode)
;;           ("gitlab" . gfm-mode)))
;;   (setq atomic-chrome-buffer-open-style 'frame)
;;   (add-hook 'atomic-chrome-edit-done-hook 'delete-frame))

;; Prog
;;
(def-package! prog-fill
  :commands prog-fill
  :hook
  (prog-mode . (lambda()(map! :map prog-mode-map
                          :nv "M-q" #'prog-fill))))

;; search online , has no efficient instrument change variable in autoload module
(setq +lookup-provider-url-alist
      '(("Google"             . "https://google.com/search?q=%s")
        ("Google images"      . "https://google.com/images?q=%s")
        ("Google maps"        . "https://maps.google.com/maps?q=%s")
        ("Project Gutenberg"  . "http://www.gutenberg.org/ebooks/search/?query=%s")
        ("DuckDuckGo"         . "https://duckduckgo.com/?q=%s")
        ("DevDocs.io"         . "https://devdocs.io/#q=%s")
        ("StackOverflow"      . "https://stackoverflow.com/search?q=%s")
        ("Github"             . "https://github.com/search?ref=simplesearch&q=%s")
        ("Youtube"            . "https://youtube.com/results?aq=f&oq=&search_query=%s")
        ("Wolfram alpha"      . "https://wolframalpha.com/input/?i=%s")
        ("Wikipedia"          . "https://wikipedia.org/search-redirect.php?language=en&go=Go&search=%s")
        ("Zhihu"              . "https://www.zhihu.com/search?q=%s&type=content")
        ("Baidu"              . "http://www.baidu.com/s?wd=%s")
        ("Pinterest"          . "https://www.pinterest.com/search/pins/?q=%s")
        ("Amazon"             . "http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%%3Daps&field-keywords=%s")
        ("Douban"             . "https://www.douban.com/search?q=%s")
        ("Bing"               . "http://www.bing.com/search?q=%s")
        ("Twitter"            . "https://twitter.com/search?q=%s")
        ("Weibo"              . "http://s.weibo.com/weibo/%s")
        ("RFC"                . "http://pretty-rfc.herokuapp.com/search?q=%s")
        ))

(after! undo-tree
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-visualizer-timestamps t)
  ;; FIXME windows not display stable
  ;; (setq undo-tree-visualizer-diff t)
  (set! :popup "^ ?\\*undo-tree\*" :ignore))


;; for workspace problem
;; https://github.com/hlissner/doom-emacs/issues/447
(add-hook 'persp-before-switch-functions '+my-workspace/goto-main-window)

(def-package! drag-stuff
  :commands (drag-stuff-up
             drag-stuff-down))

;; (def-package! sx
;;   :config
;;   (bind-keys :prefix "C-c s"
;;              :prefix-map my-sx-map
;;              :prefix-docstring "Global keymap for SX."
;;              ("q" . sx-tab-all-questions)
;;              ("i" . sx-inbox)
;;              ("o" . sx-open-link)
;;              ("u" . sx-tab-unanswered-my-tags)
;;              ("a" . sx-ask)
;;              ("s" . sx-search)))

(def-package! restart-emacs
  :commands restart-emacs)


;; Discover key bindings and their meaning for the current Emacs major mode
(def-package! discover-my-major
  :bind (("C-c M-m" . discover-my-major)
         ("C-c M-M" . discover-my-mode)))


(def-package! list-environment)
(def-package! diffview)
(def-package! try)
(def-package! ztree)

;;
;; Plugins
;;

;; (def-package! emacs-snippets
;;   :if (featurep! +snippets)
;;   :after yasnippet
;;   :config (delete yas--default-user-snippets-dir yas-snippet-dirs))


;;
;; Config
;;

(after! epa
  (setq epa-file-encrypt-to (or epa-file-encrypt-to user-mail-address)
        ;; With GPG 2.1, this forces gpg-agent to use the Emacs minibuffer to
        ;; prompt for the key passphrase.
        epa-pinentry-mode 'loopback))

;; make fullscreen on load
(after! evil
  (toggle-frame-fullscreen))

;; disable :unless predicates with (sp-pair "'" nil :unless nil)
;; disable :post-handlers with (sp-pair "{" nil :post-handlers nil)
;; ...or specific :post-handlers with (sp-pair "{" nil :post-handlers '(:rem ("| " "SPC")))
(after! smartparens
  ;; Autopair quotes more conservatively; if I'm next to a word/before another
  ;; quote, I likely don't want another pair.
  (let ((unless-list '(sp-point-before-word-p
                       sp-point-after-word-p
                       sp-point-before-same-p)))
    (sp-pair "'"  nil :unless unless-list)
    (sp-pair "\"" nil :unless unless-list))

  ;; Expand {|} => { | }
  ;; Expand {|} => {
  ;;   |
  ;; }
  (dolist (brace '("(" "{" "["))
    (sp-pair brace nil
             :post-handlers '(("||\n[i]" "RET") ("| " "SPC"))
             ;; I likely don't want a new pair if adjacent to a word or opening brace
             :unless '(sp-point-before-word-p sp-point-before-same-p)))

  ;; Don't do square-bracket space-expansion where it doesn't make sense to
  (sp-local-pair '(emacs-lisp-mode org-mode markdown-mode gfm-mode)
                 "[" nil :post-handlers '(:rem ("| " "SPC")))

  ;; Highjacks backspace to:
  ;;  a) balance spaces inside brackets/parentheses ( | ) -> (|)
  ;;  b) delete space-indented `tab-width' steps at a time
  ;;  c) close empty multiline brace blocks in one step:
  ;;     {
  ;;     |
  ;;     }
  ;;     becomes {|}
  ;;  d) refresh smartparens' :post-handlers, so SPC and RET expansions work
  ;;     even after a backspace.
  ;;  e) properly delete smartparen pairs when they are encountered, without the
  ;;     need for strict mode.
  ;;  f) do none of this when inside a string
  (advice-add #'delete-backward-char :override #'doom/delete-backward-char)

  ;; Makes `newline-and-indent' smarter when dealing with comments
  (advice-add #'newline-and-indent :around #'doom*newline-and-indent))


(when (featurep 'evil)
  (when (featurep! +evil-commands)
    (load! +evil-commands))

  (when (featurep! +bindings)
    ;; Makes ; and , the universal repeat-keys in evil-mode
    (defmacro do-repeat! (command next-func prev-func)
      "Repeat motions with ;/,"
      (let ((fn-sym (intern (format "+evil*repeat-%s" command))))
        `(progn
           (defun ,fn-sym (&rest _)
             (define-key evil-motion-state-map ";" ',next-func)
             (define-key evil-motion-state-map "," ',prev-func))
           (advice-add #',command :before #',fn-sym))))

    ;; n/N
    (do-repeat! evil-ex-search-next evil-ex-search-next evil-ex-search-previous)
    (do-repeat! evil-ex-search-previous evil-ex-search-next evil-ex-search-previous)
    (do-repeat! evil-ex-search-forward evil-ex-search-next evil-ex-search-previous)
    (do-repeat! evil-ex-search-backward evil-ex-search-next evil-ex-search-previous)

    ;; f/F/t/T/s/S
    (setq evil-snipe-repeat-keys nil
          evil-snipe-override-evil-repeat-keys nil) ; causes problems with remapped ;
    (after! evil-snipe
      (do-repeat! evil-snipe-f evil-snipe-repeat evil-snipe-repeat-reverse)
      (do-repeat! evil-snipe-F evil-snipe-repeat evil-snipe-repeat-reverse)
      (do-repeat! evil-snipe-t evil-snipe-repeat evil-snipe-repeat-reverse)
      (do-repeat! evil-snipe-T evil-snipe-repeat evil-snipe-repeat-reverse)
      (do-repeat! evil-snipe-s evil-snipe-repeat evil-snipe-repeat-reverse)
      (do-repeat! evil-snipe-S evil-snipe-repeat evil-snipe-repeat-reverse)
      (do-repeat! evil-snipe-x evil-snipe-repeat evil-snipe-repeat-reverse)
      (do-repeat! evil-snipe-X evil-snipe-repeat evil-snipe-repeat-reverse))

    ;; */#
    (after! evil-visualstar
      (do-repeat! evil-visualstar/begin-search-forward
                  evil-ex-search-next evil-ex-search-previous)
      (do-repeat! evil-visualstar/begin-search-backward
                  evil-ex-search-previous evil-ex-search-next))))
