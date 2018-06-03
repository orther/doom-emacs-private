;;; config.el -*- lexical-binding: t; -*-

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq ns-use-proxy-icon nil)

;; (defvar xdg-data (getenv "XDG_DATA_HOME"))
;; ;; (defvar xdg-bin (getenv "XDG_BIN_HOME"))
;; ;; (defvar xdg-cache (getenv "XDG_CACHE_HOME"))
;; ;; (defvar xdg-config (getenv "XDG_CONFIG_HOME"))

;; prevent "ls does not support --dired;" error by using coreutils gls rather than macOS ls
(let ((gls "/usr/local/bin/gls"))
  (if (file-exists-p gls) (setq insert-directory-program gls)))

(setq +doom-modeline-buffer-file-name-style 'relative-from-project
      show-trailing-whitespace t


      ;; coverlay:untested-line-background-color (doom-blend 'red 'bg 0.3)
      ;; coverlay:tested-line-background-color (doom-blend 'green 'bg 0.0)

      ;; mu4e-maildir        (expand-file-name "mail" xdg-data)
      ;; mu4e-attachment-dir (expand-file-name "attachments" mu4e-maildir)
      )

(add-hook! minibuffer-setup (setq-local show-trailing-whitespace nil))

(setq doom-font (font-spec :family "Fira Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 14)
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-big-font (font-spec :family "Fira Mono" :size 22)

      ;; frame-resize-pixelwise t
      )

;; **
;; ** Magit
;; **

(def-package! orgit :after magit)
(after! magithub
  (setq magithub-clone-default-directory "~/work/playground/"))

(after! magit
  (def-package! pretty-magit
    ;; :load-path "~/.doom.d/local/"
    :load-path "~/.config/doom/local/"
    :config
    (pretty-magit "feat" ? '(:foreground "slate gray" :height 1.0 :family "FontAwesome"))
    (pretty-magit "fix" ? '(:foreground "#D96B59" :height 1.0 :family "FontAwesome"))
    (pretty-magit "docs" ? '(:foreground "#F7E585" :height 1.0 :family "FontAwesome"))
    (pretty-magit "style" ? '(:foreground "#63A6E4" :height 1.0 :family "FontAwesome"))
    (pretty-magit "refactor" ? '(:foreground "#A5DAE6" :height 1.0 :family "FontAwesome"))
    (pretty-magit "perf" ? '(:foreground "#D76444" :height 1.0 :family "FontAwesome"))
    (pretty-magit "test" ? '(:foreground "#A6E27A" :height 1.0 :family "FontAwesome"))
    (pretty-magit "chore" ? '(:foreground "#FFBB00" :height 1.0 :family "FontAwesome"))
    (pretty-magit "master" ? '(:box nil :height 1.0 :family "github-octicons") t)
    (pretty-magit "origin" ? '(:box nil :height 1.0 :family "github-octicons") t))

  (magit-wip-after-save-mode 1)
  (magit-wip-after-apply-mode 1)
  ;; (setq magit-save-repository-buffers 'dontask
  ;;       magit-repository-directories '("~/dev/" "~/work/dev/"))

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

;; ;;
;; ;; Keybindings
;; ;;

;; (map!
;;  (:leader
;;    (:prefix "f"
;;      :desc "Find file in dotfiles" :n "t" #'+hlissner/find-in-dotfiles
;;      :desc "Browse dotfiles"       :n "T" #'+hlissner/browse-dotfiles)))


;; ;;
;; ;; Modules
;; ;;

;; (def-package-hook! emacs-snippets :disabled t)
(after! yasnippet
  (push "~/.config/doom/snippets" yas-snippet-dirs))

;; ;; feature/evil
;; (after! evil-mc
;;   ;; Make evil-mc resume its cursors when I switch to insert mode
;;   (add-hook! 'evil-mc-before-cursors-created
;;     (add-hook 'evil-insert-state-entry-hook #'evil-mc-resume-cursors nil t))
;;   (add-hook! 'evil-mc-after-cursors-deleted
;;     (remove-hook 'evil-insert-state-entry-hook #'evil-mc-resume-cursors t)))

;; completion/helm
(after! helm
  ;; Hide header lines in helm. I don't like them
  (set-face-attribute 'helm-source-header nil :height 0.1))

;; tools/magit
;; (after! magit
;;   (setq magit-repository-directories
;;         (cl-loop for dir in (directory-files "~/work" t "^[^.]" t)
;;                  if (file-directory-p dir)
;;                  nconc (cl-loop for subdir in (directory-files dir t "^[^.]" t)
;;                                 if (and (file-directory-p subdir)
;;                                         (file-directory-p (expand-file-name ".git/" subdir)))
;;                                 collect subdir))))

(setq +org-dir (expand-file-name "~/work/org"))

;; display plantuml images inline
(add-hook 'org-babel-after-execute-hook
          (lambda ()
            (when org-inline-image-overlays
              (org-redisplay-inline-images))))

;; setup custom node modules for babel es6-7 support in org src blocks
(setenv "NODE_PATH"
  (concat
   (getenv "HOME") "/.org/node_modules" ":"
   (getenv "NODE_PATH")))

(after! neotree
  :config
  (setq neo-window-width 35))

;; lang/org
;; (add-hook 'org-mode-hook #'auto-fill-mode)
;; The standard unicode characters are usually misaligned depending on the font.
;; This bugs me. Personally, markdown #-marks for headlines are more elegant.
;; (setq org-bullets-bullet-list '("#"))
