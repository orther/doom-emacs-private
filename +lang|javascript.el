;;; ~/.doom.d/+lang|javascript.el -*- lexical-binding: t; -*-

(after! flycheck
  (flycheck-jest-setup)
  (flycheck-add-mode 'jest 'js2-mode))

;; TODO replace this by setting up flycheck-jest to create coverage reports
;; ** Jest (mocha.el)
(load! "local/jest")
(after! mocha
  (set! :popup "^\\*mocha tests*"
    '((size . 80) (side . right))
    '((select . nil) (quit . nil) (autokill . t))))

;; ** coverlay - code coverage overlays
(setq coverlay:untested-line-background-color (doom-blend 'red 'bg 0.3)
      coverlay:tested-line-background-color (doom-blend 'green 'bg 0.0))
