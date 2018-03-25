;;; private/orther/config.el -*- lexical-binding: t; -*-

(load! +bindings)  ; my key bindings

(when (featurep 'evil)
  (load! +commands)) ; my custom ex commands

(load! +lispy)

(defvar +orther-dir (file-name-directory load-file-name))
(defvar +orther-snippets-dir (expand-file-name "snippets/" +orther-dir))

;; Don't use default snippets, use mine.
(after! yasnippet
  (setq yas-snippet-dirs (append (list '+orther-snippets-dir)
                                 (delete 'yas-installed-snippets-dir yas-snippet-dirs))))

;; TODO replace w/ real jest package
;; (load! +jest)

;; projectile ignore directories
(setq projectile-globally-ignored-directories '("node_modules" ".happypack" "flow-typed"))
(setq grep-find-ignored-directories '("node_modules" ".happypack"))

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

;; Widen fringes (easier to see git-gutter with twm window border)
(fringe-mode '(12 . 12))

;; Override vc modified color (gray -> yellow)
(custom-set-faces
  '(diff-hl-change         ((t (:foreground "#ECBE7B"))))
  '(git-gutter:modified    ((t (:foreground "#ECBE7B"))))
  '(git-gutter+-modified   ((t (:foreground "#ECBE7B"))))
  '(git-gutter-fr:modified ((t (:foreground "#ECBE7B")))))

;; Override smerge colors
(custom-set-faces
  '(smerge-refined-removed ((t (:inherit 'smerge-mine))))
  '(smerge-refined-added   ((t (:inherit 'smerge-other)))))

;; ;; Override evil googles colors
;; (custom-set-faces
;;  '(evil-goggles-delete-face ((t (:foreground "#ff6c6b"))))
;;  '(evil-goggles-paste-face  ((t (:foreground "#98be65"))))
;;  '(evil-goggles-yank-face   ((t (:foreground "#51afef")))))

;; ;; Override org mode colors
;; (custom-set-faces
;;  '(org-level-1              ((t :foreground "#51afef" :inherit nil :height 1.2)))
;;  '(org-level-2              ((t :foreground "#DCAEEA" :inherit nil :height 1.1)))
;;  '(org-level-3              ((t :foreground "#a9a1e1" :inherit nil :height 1.1)))
;;  '(org-level-4              ((t :foreground "#ECBE7B" :inherit nil :height 1.1)))
;;  '(org-level-5              ((t :foreground "#46D9FF" :inherit nil :height 1.1))))

;; Close magit buffer after following file
(defun close-magit-buffer ()
  (when (and (boundp 'magit-mode) magit-mode)
    (magit-mode-bury-buffer)))

(add-hook 'magit-diff-visit-file-hook #'close-magit-buffer)

;; brighter minibuffer when active
;; (add-hook 'minibuffer-setup-hook #'doom-brighten-minibuffer)

;; TODO see if we can change this to use after!
(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)

;; customize doom neotree
(setq doom-neotree-enable-file-icons t)
(setq doom-neotree-file-icons t)
(after! neotree
  :config
  (setq neo-create-file-auto-open t
        neo-window-width 35
        neo-hidden-regexp-list (append neo-hidden-regexp-list
                                       '(".happypack" ".vscode" ".log$" ".DS_Store"))))
;; setup fonts
(setq doom-font (font-spec :family "Fira Mono" :size 12)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 12)
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 12)
      doom-big-font (font-spec :family "Fira Mono" :size 20))

;; (setq user-mail-address "brandon@omt.tech"
;;       user-full-name "Brandon Orther"
;;       epa-file-encrypt-to user-mail-address
;;       auth-sources (list (expand-file-name ".authinfo.gpg" +orther-dir)))
;;
;; (defun +orther*no-authinfo-for-tramp (orig-fn &rest args)
;;   "Don't look into .authinfo for local sudo TRAMP buffers."
;;   (let ((auth-sources (if (equal tramp-current-method "sudo") nil auth-sources)))
;;     (apply orig-fn args)))
;; (advice-add #'tramp-read-passwd :around #'+orther*no-authinfo-for-tramp)


;; ;; Repeat all sorts of motion and searches with SPC & C-SPC
;; (defmacro +my!repeat-with-spc (command next-func prev-func)
;;   "Repeat motions with SPC/S-SPC"
;;   (let ((fn-sym (intern (format "+evil*repeat-%s" command))))
;;     `(progn
;;        (defun ,fn-sym (&rest _)
;;          (define-key evil-motion-state-map (kbd "SPC") ',next-func)
;;          (define-key evil-motion-state-map (kbd "S-SPC") ',prev-func))
;;        (advice-add #',command :before #',fn-sym))))

;; (after! evil
;;   ;; n/N
;;   (+my!repeat-with-spc evil-ex-search-next evil-ex-search-next evil-ex-search-previous)
;;   (+my!repeat-with-spc evil-ex-search-previous evil-ex-search-next evil-ex-search-previous)
;;   (+my!repeat-with-spc evil-ex-search-forward evil-ex-search-next evil-ex-search-previous)
;;   (+my!repeat-with-spc evil-ex-search-backward evil-ex-search-next evil-ex-search-previous)

;;   ;; f/F/t/T/s/S
;;   (after! evil-snipe
;;     (setq evil-snipe-repeat-keys nil
;;           evil-snipe-override-evil-repeat-keys nil) ; causes problems with remapped ;

;;     (+my!repeat-with-spc evil-snipe-f evil-snipe-repeat evil-snipe-repeat-reverse)
;;     (+my!repeat-with-spc evil-snipe-F evil-snipe-repeat evil-snipe-repeat-reverse)
;;     (+my!repeat-with-spc evil-snipe-t evil-snipe-repeat evil-snipe-repeat-reverse)
;;     (+my!repeat-with-spc evil-snipe-T evil-snipe-repeat evil-snipe-repeat-reverse)
;;     (+my!repeat-with-spc evil-snipe-s evil-snipe-repeat evil-snipe-repeat-reverse)
;;     (+my!repeat-with-spc evil-snipe-S evil-snipe-repeat evil-snipe-repeat-reverse)
;;     (+my!repeat-with-spc evil-snipe-x evil-snipe-repeat evil-snipe-repeat-reverse)
;;     (+my!repeat-with-spc evil-snipe-X evil-snipe-repeat evil-snipe-repeat-reverse))

;;   ;; */#
;;   (after! evil-visualstar
;;     (+my!repeat-with-spc evil-visualstar/begin-search-forward
;;       evil-ex-search-next evil-ex-search-previous)
;;     (+my!repeat-with-spc evil-visualstar/begin-search-backward
;;       evil-ex-search-previous evil-ex-search-next)))

;; ;; (after! mu4e
;; ;;   (setq-default
;; ;;    smtpmail-stream-type 'starttls
;; ;;    smtpmail-default-smtp-server "smtp.gmail.com"
;; ;;    smtpmail-smtp-server "smtp.gmail.com"
;; ;;    smtpmail-smtp-service 587)

;; ;;   (set! :email "gmail.com"
;; ;;     '((mu4e-sent-folder       . "/%s/Sent Mail")
;; ;;       (mu4e-drafts-folder     . "/%s/Drafts")
;; ;;       (mu4e-trash-folder      . "/%s/Trash")
;; ;;       (mu4e-refile-folder     . "/%s/All Mail")
;; ;;       (smtpmail-smtp-user     . "brandonorther")
;; ;;       (user-mail-address      . "brandon.orther@gmail.com")
;; ;;       (mu4e-compose-signature . "---\nBrandon Orther")))

;; ;;   (set! :email "omt.tech"
;; ;;     '((mu4e-sent-folder       . "/%s/Sent Mail")
;; ;;       (mu4e-drafts-folder     . "/%s/Drafts")
;; ;;       (mu4e-trash-folder      . "/%s/Trash")
;; ;;       (mu4e-refile-folder . "/%s/All Mail") (smtpmail-smtp-user .
;; ;;       "brandon@omt.tech")
;; ;;       (user-mail-address      . "brandon@omt.tech")
;; ;;       (mu4e-compose-signature . "---\nBrandon Orther"))
;; ;;     t))

;; ;; app/irc
;; (setq +irc-notifications-watch-strings '("aka" "aka-" "aka--"))

;; (set! :irc "irc.snoonet.org"
;;   `(:tls t
;;     :nick "v0"
;;     :port 6697
;;     :sasl-username ,(+pass-get-user "irc/snoonet.org")
;;     :sasl-password ,(+pass-get-secret "irc/snoonet.org")
;;     :channels (:after-auth "#ynought")))

;; (set! :irc "irc.freenode.net"
;;   `(:tls t
;;     :nick "aka--"
;;     :port 6697
;;     :sasl-username ,(+pass-get-user "irc/aka@freenode.net")
;;     :sasl-password ,(+pass-get-secret "irc/aka@freenode.net")
;;     :channels (:after-auth "#javascript" "#emacs")))

;; (set! :irc "irc.mzima.net"
;;   `(:tls t
;;     :nick "aka--"
;;     :port 6697
;;     :channels ("#php")))

;; ;; make fullscreen on load
;; (after! evil
;;   (toggle-frame-fullscreen))
