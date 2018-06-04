;;; ~/.doom.d/+org.el -*- lexical-binding: t; -*-

(setq +org-dir (expand-file-name "~/work/org"))

;; ;; display plantuml images inline
;; (add-hook 'org-babel-after-execute-hook
;;           (lambda ()
;;             (when org-inline-image-overlays
;;               (org-redisplay-inline-images))))

;; ;; setup custom node modules for babel es6-7 support in org src blocks
;; (setenv "NODE_PATH"
;;   (concat
;;    (getenv "HOME") "/.org/node_modules" ":"
;;    (getenv "NODE_PATH")))


;; lang/org
;; (add-hook 'org-mode-hook #'auto-fill-mode)
;; The standard unicode characters are usually misaligned depending on the font.
;; This bugs me. Personally, markdown #-marks for headlines are more elegant.
;; (setq org-bullets-bullet-list '("#"))
