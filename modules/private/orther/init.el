;;; private/orther/init.el -*- lexical-binding: t; -*-

;; This is a special file, unique to private modules, that is loaded after DOOM
;; core but before any module is activated, giving you an opportunity to
;; overwrite variables or settings before initialization.

(setq user-mail-address "brandon@omt.tech"
      user-full-name    "Brandon Orther"

      +doom-modeline-height 25)

(setq doom-font (font-spec :family "Fira Mono" :size 10)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 10)
      doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 10)
      doom-big-font (font-spec :family "Fira Mono" :size 19))

;; ;; An extra measure to prevent the flash of unstyled mode-line while Emacs is
;; ;; booting up (when Doom is byte-compiled).
;; (setq-default mode-line-format nil)

;; ;; host-specific settings
;; (pcase (system-name)
;;   ((or "imac" "linux")
;;    ;; smaller screen, smaller fonts
;;    (set! :font "Fira Mono" :size 10)
;;    (set! :variable-font "Fira Sans" :size 10)
;;    (set! :unicode-font "DejaVu Sans Mono" :size 10))
;;   ;; ("nereid")
;;   ;; ("io")
;;   ;; ("sao")
;;   )
