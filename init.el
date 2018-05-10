;;; init.el -*- lexical-binding: t; -*-

;; Set shell to bash to protect against problems caused by fish shell
(setq-default explicit-shell-file-name (executable-find "bash"))
(setq-default shell-file-name (executable-find "bash"))

(doom! :feature
       (popup            ; tame sudden yet inevitable temporary windows
        +all             ; catch all popups that start with an asterix
        +defaults)       ; default popup rules
       debugger          ; FIXME stepping through code, to help you add bugs
       eval              ; run code, run (also, repls)
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       (lookup           ; helps you navigate your code and documentation
        +devdocs         ; ...on devdocs.io online
        +docsets)        ; ...or in Dash docsets locally
       services          ; TODO managing external services & code builders
       snippets          ; my elves. They type so I don't have to
       spellcheck        ; tasing you for misspelling mispelling
       (syntax-checker   ; tasing you for every semicolon you forget
        +childframe)     ; use childframes for error popups (Emacs 26+ only)
       version-control   ; remember, remember that commit in November
       workspaces        ; tab emulation, persistence & separate workspaces
       ;search          ; advanced searching functionality (copied from bmacs)


       :completion
       (company          ; the ultimate code completion backend
        +auto            ; as-you-type code completion
        +childframe)     ; a nicer company UI (Emacs 26+ only)
       (ivy              ; a search engine for love and life
        +childframe)     ; uses childframes for popups (Emacs 26+ only)

       :ui
       doom            ; what makes DOOM look the way it does
       doom-dashboard  ; a nifty splash screen for Emacs
       doom-modeline   ; a snazzy Atom-inspired mode-line
       doom-quit       ; DOOM quit-message prompts when you quit Emacs
       hl-todo         ; highlight TODO/FIXME/NOTE tags
       nav-flash       ; blink the current line after jumping
       evil-goggles    ; display visual hints when editing in evil
      ;unicode         ; extended unicode support for various languages
      ;tabbar          ; FIXME an (incomplete) tab bar for Emacs
       vi-tilde-fringe ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       ;; posframe          ; use child frames where possible (Emacs 26+ only)

       :tools
       dired           ; making dired pretty [functional]
       electric-indent ; smarter, keyword-based electric-indent
       eshell          ; a consistent, cross-platform shell (WIP)
       gist            ; interacting with github gists
       imenu           ; an imenu sidebar and searchable code index
       impatient-mode  ; show off code over HTTP
      ;macos           ; MacOS-specific commands
       make            ; run make tasks from Emacs
       magit
       neotree         ; a project drawer, like NERDTree for vim
       password-store ; password manager for nerds
       ;; (password-store ; password manager for nerds
       ;;  +auth)         ; use password-store as auth-source backend
       pdf               ; pdf enhancements
       rotate-text     ; cycle region at point between text candidates
       term            ; terminals in Emacs
       ;tmux            ; an API for interacting with tmux
       upload          ; map local to remote projects via ssh/ftp

       :lang
       data              ; config/data formats
       elixir            ; erlang done right
       emacs-lisp        ; drown in parentheses
       ess               ; emacs speaks statistics
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       latex             ; writing papers in Emacs has never been so fun
       markdown          ; writing docs for people to ignore
       (org              ; organize your plain life in plain text
        +attach          ; custom attachment system
        +babel           ; running code in org
        +capture         ; org-capture in and outside of Emacs
        +export          ; Exporting org to whatever you want
        +present         ; Emacs for presentations
        +publish)        ; Emacs+Org as a static site generator
       php               ; perl's insecure younger brother
       plantuml          ; diagrams for confusing people more
       python            ; beautiful is better than ugly
       rest              ; Emacs as a REST client
       sh                ; she sells (ba|z)sh shells on the C xor
       typescript        ; javascript, but better
       web               ; the tubes

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
      ;(email +gmail)    ; emacs as an email client
      ;irc               ; how neckbeards socialize
      ;(rss +org)        ; emacs as an RSS reader
      ;twitter           ; twitter client https://twitter.com/vnought
      (write            ; emacs as a word processor (latex + org + markdown)
       +wordnut         ; wordnet (wn) search
       +langtool)       ; a proofreader (grammar/style check) for Emacs

       :config
       (default +bindings +snippets +evil-commands)

       ;; :private personal
       )
