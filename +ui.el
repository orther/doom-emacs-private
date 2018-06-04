;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

;; **
;; ** Dark macOS native window title
;; **

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))


;; **
;; ** Fonts
;; **

(setq doom-font (font-spec :family "Fira Mono" :size 14)
      ;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 14)
      ;; doom-unicode-font (font-spec :family "DejaVu Sans Mono" :size 14)
      doom-big-font (font-spec :family "Fira Mono" :size 22))

;; **
;; ** Modeline
;; **

(setq +doom-modeline-buffer-file-name-style 'relative-from-project)

;; **
;; ** Neotree
;; **

(after! neotree
  :config
  (setq neo-window-width 35))
