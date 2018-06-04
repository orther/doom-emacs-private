;;; ~/.doom.d/+editor.el -*- lexical-binding: t; -*-

;; ** hide trailing whitespace
(setq show-trailing-whitespace t)
(add-hook! minibuffer-setup (setq-local show-trailing-whitespace nil))
;; TODO confirm both ^^ are needed
