;;; private/personal/init.el -*- lexical-binding: t; -*-

;; (cond (IS-MAC
;;        (setq mac-command-modifier 'super
;;              mac-option-modifier  'meta))
;; 	  (IS-LINUX
;; 	   (setq x-super-keysym 'super
;; 			 x-alt-keysym   'meta)
;; 	  ))

;; Prevents the unstyled mode-line flash at startup
(setq-default mode-line-format nil)


(setq user-mail-address "brandon@uptrend.tech"
      user-full-name    "Brandon Orther"

      +doom-modeline-height 25)

(setq doom-font (font-spec :family "Fira Mono" :size 12)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 12)
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 12)
      doom-big-font (font-spec :family "Fira Mono" :size 19)

      frame-resize-pixelwise t
      )

(add-hook! doom-big-font-mode
  (setq +doom-modeline-height (if doom-big-font-mode 37 29)))

(setq
 epa-file-encrypt-to user-mail-address
      auth-sources (list (expand-file-name ".authinfo.gpg" "~")))

;; (require 'auth-source-pass)
;; (auth-source-pass-enable)

;; ;; troubleshoot auth-source
;; (setq auth-source-debug t)
;; (setq auth-source-do-cache nil)
