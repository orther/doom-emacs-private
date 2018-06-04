;;; ~/.doom.d/+emacs.el -*- lexical-binding: t; -*-

;; use coreutils gls (not default osx ls) to prevent "ls does not support --dired;" error
(let ((gls "/usr/local/bin/gls"))
  (if (file-exists-p gls) (setq insert-directory-program gls)))
