Install
-------
```bash
git clone git@github.com:orther/doom-emacs-private.git ~/.config/doom
```

And use this `doom!` block in `~/.emacs.d/init.el`
```elisp
(require 'core (concat user-emacs-directory "core/core"))

(doom! :config (private +xdg))
```

## Install EmacsClient.app for org-protocol

   ```sh
   brew cask install emacsclient
   ```
