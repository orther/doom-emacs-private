;;; ~/.doom.d/+magit.el -*- lexical-binding: t; -*-

;; (def-package! orgit :after magit)

(after! magithub
  (setq magithub-clone-default-directory "~/work/playground/"))

(after! magit
  ;; (def-package! pretty-magit
  ;;   ;; :load-path "~/.doom.d/local/"
  ;;   :load-path "~/.config/doom/local/"
  ;;   :config
  ;;   (pretty-magit "feat" ? '(:foreground "slate gray" :height 1.0 :family "FontAwesome"))
  ;;   (pretty-magit "fix" ? '(:foreground "#D96B59" :height 1.0 :family "FontAwesome"))
  ;;   (pretty-magit "docs" ? '(:foreground "#F7E585" :height 1.0 :family "FontAwesome"))
  ;;   (pretty-magit "style" ? '(:foreground "#63A6E4" :height 1.0 :family "FontAwesome"))
  ;;   (pretty-magit "refactor" ? '(:foreground "#A5DAE6" :height 1.0 :family "FontAwesome"))
  ;;   (pretty-magit "perf" ? '(:foreground "#D76444" :height 1.0 :family "FontAwesome"))
  ;;   (pretty-magit "test" ? '(:foreground "#A6E27A" :height 1.0 :family "FontAwesome"))
  ;;   (pretty-magit "chore" ? '(:foreground "#FFBB00" :height 1.0 :family "FontAwesome"))
  ;;   (pretty-magit "master" ? '(:box nil :height 1.0 :family "github-octicons") t)
  ;;   (pretty-magit "origin" ? '(:box nil :height 1.0 :family "github-octicons") t))

  (magit-wip-after-save-mode 1)
  (magit-wip-after-apply-mode 1)
  (setq magit-save-repository-buffers 'dontask
        magit-repository-directories '("~/dev/" "~/work/dev/"))

  (advice-add 'magit-list-repositories :override #'*magit-list-repositories)
  (set! :evil-state 'magit-repolist-mode 'normal)
  (map! :map magit-repolist-mode-map
        :nmvo doom-leader-key nil
        :map with-editor-mode-map
        (:localleader
          :desc "Finish" :n "," #'with-editor-finish
          :desc "Abort" :n "k" #'with-editor-cancel))

  (setq magit-bury-buffer-function #'+magit/quit
        magit-popup-display-buffer-action nil
        magit-display-file-buffer-function 'switch-to-buffer-other-window)
  (map! :map magit-mode-map
        [remap quit-window] #'+magit/quit
        :n "\\" nil)
  (set! :popup "^\\(?: ?\\*\\)?magit.*: "
    '((slot . -1) (side . right) (size . 80))
    '((select . t) (quit . nil)))
  (set! :popup "^\\*magit.*popup\\*"
    '((slot . 0) (side . right))
    '((select . t)))
  (set! :popup "^\\(?: ?\\*\\)?magit-revision:.*"
    '((slot . 2) (side . right) (window-height . 0.6))
    '((select . t)))
  (set! :popup "^\\(?: ?\\*\\)?magit-diff:.*"
    '((slot . 2) (side . right) (window-height . 0.6))
    '((select . nil))))
