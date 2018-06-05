;;; ~/.doom.d/+lang|javascript.el -*- lexical-binding: t; -*-

;; ** Jest (mocha.el)
(load! "local/jest")
(after! mocha
  (set! :popup "^\\*mocha tests*"
    '((size . 80) (side . right))
    '((select . nil) (quit . nil) (autokill . t))))

;; ** coverlay - code coverage overlays
(setq coverlay:untested-line-background-color (doom-blend 'red 'bg 0.3)
      coverlay:tested-line-background-color (doom-blend 'green 'bg 0.0))
