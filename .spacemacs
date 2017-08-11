;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     ;; auto-completion
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-private-snippets-directory nil)
     better-defaults
     spacemacs-evil
     emacs-lisp
     git
     lua
     (markdown
      :eval-after-load
      ;; (auto-fill-mode 1)
      (spacemacs/toggle-auto-completion)
      )
     pandoc
     ;; org
     (org :variables
          ;; org-enable-github-support t
          org-enable-bootstrap-support t)
     (latex
      :variables latex-enable-auto-fill t
      :eval-after-load
      ;; (auto-fill-mode 1)
      (spacemacs/toggle-auto-completion)
      )
     shell-scripts
     ;; (spell-checking
     ;;  :variables spell-checking-enable-auto-dictionary t)
     syntax-checking
     ;; version-control
     (ess :variables
          ess-enable-smart-equals t)
     python
     ranger
     ;; vinegar
     csv
     ipython-notebook
     ;; (ipython-notebook :variables ein:use-auto-complete t)
     javascript
     html
     vimscript
     ibuffer
     pdf-tools
     ;; themes-megapack
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
                                      ;; xclip
                                      ;; csv
                                      zotxt
                                      ox-pandoc
                                      key-chord
                                      ;; vdiff
                                      org-ref
                                      paperless
                                      ;; let-alist
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(
                                    ;; ipython
                                    )
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update t
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 9)
                                (projects . 3))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         leuven
                         default
                         spacemacs-light
                         spacemacs-dark
                         )
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("Source Code Pro"
   ;;                             :size 12
   ;;                             :weight normal
   ;;                             :width normal
   ;;                             :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ t
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 12
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   )
  )

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; set this before evil loads
  (setq evil-toggle-key (kbd "C-e"))
  (setq ess-eval-visibly nil)
  (setq ess-ask-for-ess-directory nil)
  (setq org-todo-keywords
        '((sequence "OPEN" "NEXT" "WAIT" "|" "DONE"))
        )
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs
initialization after layers configuration.  This is the place
where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a
package is loaded, you should place your code here."
  ;; (xclip-mode 1)
  ;; (fset 'evil-visual-update-x-selection 'ignore)
  (setq x-select-enable-primary t)
  (setq x-select-enable-clipboard nil)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
  (setq-default kill-ring-max 666)
  (setq history-length 666)
  (setq-default history-delete-duplicates t)
  (setq-default kill-do-not-save-duplicates t)
  (setq visible-bell t)
  (defalias 'ttl         'toggle-truncate-lines)
  (defalias 'ke          'kill-emacs)
  (defalias 'es          'eshell)
  (defalias 'at          'ansi-term)
  (defalias 'ss          'shell)
  (defalias 'sd          'desktop-save-in-desktop-dir)
  (defalias 'ed          'ediff-files)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (defun my-escape-and-save ()
    "My escape and save"
    (interactive)
    (evil-escape)
    (save-buffer)
    )
  (defun vim-wq ()
    "My save and quit"
    (interactive)
    (evil-escape)
    (save-buffer)
    (kill-this-buffer)
    )
  (defun my-escape-and-bury ()
    "My save and quit"
    (interactive)
    (evil-escape)
    (bury-buffer)
    )
  (setq sentence-end-double-space t)
  (add-to-list 'auto-mode-alist '("\\.Rmd\\'" . markdown-mode))
  (key-chord-mode 1)
  ;; (key-chord-define evil-insert-state-map "jk" 'evil-escape)
  ;; (key-chord-define evil-normal-state-map "lk" 'kill-this-buffer)
  ;; (key-chord-define evil-insert-state-map "df" 'evil-escape)
  (key-chord-define-global ";l" 'kill-this-buffer)
  (key-chord-define-global "wq" 'vim-wq)
  (key-chord-define-global "jk" 'my-escape-and-save)
  (key-chord-define-global "BB" 'my-escape-and-bury)
  (key-chord-define-global "ii" 'completion-at-point)
  (setq text-mode-hook (quote (text-mode-hook-identify toggle-truncate-lines)))
  (setq-default fill-column 78)
  ;; ;; Visual stuff
  ;; (set-frame-width (selected-frame) 112)
  ;; (set-frame-height (selected-frame) 76)
  ;; (setq frame-title-format '("%b | " mode-name))
  (setq frame-title-format '("%b"))
  (setq-default spacemacs-show-trailing-whitespace nil)
  (setq doc-view-continuous t)
  (setq font-use-system-font t)
  (setq display-time-day-and-date t display-time-24hr-format t)
  (display-time-mode 1)
  (setq truncate-lines t)
  ;; (setq-default cursor-type '(bar . 3))
  ;; (setq evil-move-cursor-back nil)
  (setq evil-want-Y-yank-to-eol t)
  (setq kill-buffer-query-functions (remq 'process-kill-buffer-query-function kill-buffer-query-functions))
  (setq ediff-split-window-function 'split-window-horizontally
        ediff-window-setup-function 'ediff-setup-windows-plain)
  ;; Ispell
  (eval-after-load "ispell"
    (progn
      (setq ispell-extra-args '("-w" "äöüÄÖÜß")
            ispell-dictionary "english"
            ispell-silently-savep t)))
  (setq-default ispell-program-name "aspell")
  ;; For R-Sweave chunks
  (add-to-list 'ispell-skip-region-alist '("^<<.*>>=" . "^@"))
  ;; Rmarkdown
  (add-to-list 'ispell-skip-region-alist '("^```" . "^```"))
  ;; skip org chunks
  (add-to-list 'ispell-skip-region-alist '("^#\\+.*" . "^#\\+.*"))
  ;; LaTeX crap
  (add-to-list 'ispell-skip-region-alist '("\\\\cite.*{" . "}"))
  (add-to-list 'ispell-skip-region-alist '("\\\\chem{" . "}"))
  (add-to-list 'ispell-skip-region-alist '("\\$" . "\\$"))
  (setq latex-run-command "pdflatex")
  (setq tex-process-asynchronous t)
  (set-face-attribute 'default nil :height 94)
  (add-hook 'LaTeX-mode-hook (lambda () (require 'org-ref)))
  (add-hook 'sh-mode-hook
            (lambda ()
              (spacemacs/set-leader-keys-for-major-mode 'sh-mode
                "," 'sh-send-line-or-region-and-step
                "i" 'complete-symbol
                ;; "," 'sh-execute-region
                ;; "." 'sh-exec
                ;; "hh" 'sh-heredoc
                )
              )
            )
  
  ;; (add-hook 'ein:notebook-multilang-mode-hook
  ;;           ;; ein:console-open
  ;;           ;; To use this function, `ein:console-security-dir' and
  ;;           ;; `ein:console-args' must be set properly.
  ;;           (lambda ()
  ;;             (setq ein:console-executable "/d/documents/eaternity/bw2-py/envs/bw2/bin/jupyter-console")
  ;;             (setq ein:console-args '("--profile" "bw2"))
  ;;             ;; (setq ein:console-args
  ;;             ;;       '(
  ;;             ;;         (8888 . '("--profile" "bw2"))
  ;;             ;;         ;; (8889 . '("--ssh" "HOSTNAME"))
  ;;             ;;         (default . '("--profile" "bw2"))))
  ;;             (spacemacs/set-leader-keys-for-major-mode 'ein:notebook-multilang-mode
  ;;               ","   'ein:worksheet-execute-cell-and-goto-next
  ;;               "."   'ein:worksheet-execute-cell
  ;;               "RET" 'ein:worksheet-execute-cell-and-insert-below
  ;;               "TAB" 'ein:console-open
  ;;               )
  ;;             (defun my-escape-and-kill-ein ()
  ;;               "My escape and save"
  ;;               (interactive)
  ;;               (evil-escape)
  ;;               (ein:notebook-close 1)
  ;;               )
  ;;             (defun my-escape-and-save-ein ()
  ;;               "My escape and save"
  ;;               (interactive)
  ;;               (evil-escape)
  ;;               (ein:notebook-save-notebook-command)
  ;;               )
  ;;             ;; (key-chord-define-local "kj" 'my-escape-and-save-ein)
  ;;             ;; (key-chord-define-local "lk" 'my-escape-and-kill-ein)
  ;;             (spacemacs/toggle-auto-completion-on)
  ;;             (setq ein:use-auto-complete t
  ;;                   ein:use-auto-complete-superpack t
  ;;                   ein:enable-keepalive t
  ;;                   ;; ein:jupyter-default-notebook-directory "/home/oney/documents/eaternity/eaternity"
  ;;                   ;; ein:jupyter-default-server-command "/home/oney/documents/eaternity/bw2-py/bin/jupyter"
  ;;                   ;; ein:jupyter-server-args nil
  ;;                   ein:notebook-autosave-frequency 60
  ;;                   ein:notebook-checkpoint-frequency 60
  ;;                   ein:notebook-modes
  ;;                   (quote
  ;;                    (ein:notebook-multilang-mode ein:notebook-python-mode))
  ;;                   ;; ein:org-execute-timeout 120
  ;;                   ;; ein:slice-image t
  ;;                   ein:worksheet-enable-undo 'yes
  ;;                   )
  ;;             ;; (setq python-shell-interpreter "/d/documents/eaternity/bw2-py/envs/bw2/bin/ipython"
  ;;             ;; python-shell-interpreter-args "--simple-prompt -i")
  ;;             (setq python-shell-interpreter "ipython")
  ;;             )
  ;;           )
  (add-hook 'python-mode-hook
            (lambda ()
              (spacemacs/set-leader-keys-for-major-mode 'python-mode
                ;; "."   'python-shell-send-defun
                ;; "."   'python-shell-send-defun-switch
                ","   'python-shell-send-region
                "."   'python-shell-send-region-switch
                ;; "r"   'python-shell-send-buffer-switch
                "k"   'anaconda-mode-complete
                "TAB" 'python-start-or-switch-repl
                )
              ;; (setq python-shell-interpreter "/usr/bin/ipython3")
              ;; (setq python-shell-interpreter "ipython"
              ;;       python-shell-interpreter-args "--simple-prompt -i")
              )
            )
  (add-hook 'ess-mode-hook
            (lambda ()
              (spacemacs/set-leader-keys-for-major-mode 'ess-mode
                ;; "'"  'spacemacs/ess-start-repl
                ;; "si" 'spacemacs/ess-start-repl
                ;; ;; noweb
                ;; "cC" 'ess-eval-chunk-and-go
                ;; "cc" 'ess-eval-chunk
                ;; "cd" 'ess-eval-chunk-and-step
                ;; "cm" 'ess-noweb-mark-chunk
                ;; "cN" 'ess-noweb-previous-chunk
                ;; "cn" 'ess-noweb-next-chunk
                ;; REPL
                ","   'ess-eval-function-or-paragraph-and-step
                "`"   'ess-show-traceback
                "i"   'complete-symbol
                "."   'ess-eval-region-or-line-and-step
                "hh"  'ess-display-help-on-object
                "TAB" 'ess-switch-to-inferior-or-script-buffer
                )
              (setq ess-eval-visibly nil)
              )
            )
  (add-hook 'org-mode-hook
            (lambda ()
              ;; (require 'org-ref)
              ;; ;; (defun helm-bibtex-format-pandoc-citation (keys)
              ;; ;;   (concat "[" (mapconcat (lambda (key) (concat "@" key)) keys "; ") "]"))
              ;; ;; ;; inform helm-bibtex how to format the citation in org-mode
              ;; ;; (setf (cdr (assoc 'org-mode helm-bibtex-format-citation-functions))
              ;; ;;       'helm-bibtex-format-pandoc-citation)
              ;; ;;(
              ;; (setq helm-bibtex-format-citation-functions
              ;;       '((org-mode . (lambda (x) (insert (concat
              ;;                                          "\\cite{"
              ;;                                          (mapconcat 'identity x ",")
              ;;                                          "}")) ""))))
              ;; ))
              (defun org-todo-list-next ()
                "My escape and save"
                (interactive)
                (org-todo-list "NEXT")
                (ace-maximize-window)
                )
              (setq reftex-default-bibliography    "~/zotero/Insects.bib"
                    org-ref-bibliography-notes     "~/zotero/biblio-notes.org"
                    org-ref-default-bibliography   "~/zotero/Insects.bib"
                    org-ref-pdf-directory          "~/zotero/"
                    bibtex-completion-bibliography "~/zotero/Insects.bib"
                    helm-bibtex-library-path       "~/action/bugs/literature/"
                    bibtex-completion-notes-path   "~/zotero"
                    ) 
              ;; (spacemacs/set-leader-keys-for-minor-mode 'org-mode
              ;;   "ir"   'org-ref-helm-insert-cite-link
              ;;   )
              (spacemacs/set-leader-keys-for-major-mode 'org-mode
                "ir"  'org-ref-helm-insert-cite-link
                "p"   'org-priority
                "z"   'org-pomodoro
                ;; "an"   'org-todo-list-next
                )
              (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode
                "p"   'org-priority
                "z"   'org-pomodoro
                )
              (require 'org-ref)
              (require 'org-ref-latex)
              (require 'org-ref-pdf)
              (require 'org-ref-url-utils)
              (setq org-latex-pdf-process
                    '("pdflatex -interaction nonstopmode -output-directory %o %f"
                      "bibtex %b"
                      "pdflatex -interaction nonstopmode -output-directory %o %f"
                      "pdflatex -interaction nonstopmode -output-directory %o %f"))
              (setq org-table-use-standard-references t)
              (org-babel-do-load-languages
               'org-babel-load-languages
               '(
                 (emacs-lisp . nil)
                 (R          . t)
                 (shell      . t)
                 (python     . t)
                 (ditaa      . t)
                 ))
              (setq org-confirm-babel-evaluate nil)
              ;; (defun my-org-confirm-babel-evaluate (lang body)
              ;;   (not (string= lang "ditaa")))  ; don't ask for ditaa
              ;; (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
              (setq org-startup-with-inline-images nil)
              ;; (setq org-file-apps
              ;;       (append '(
              ;;                 ("\\.png\\'"   . system)
              ;;                 ("\\.pdf\\'"   . system)
              ;;                 ("\\.docx?\\'" . system)
              ;;                 ("\\.html\\'"  . system)
              ;;                 )
              ;;               org-file-apps )
              ;;       )
              ;; (auto-fill-mode 1)
              (spacemacs/toggle-auto-completion)
              ;; (setq org-agenda-files (file-expand-wildcards "~/org/*.org"))
              ;; (setq org-agenda-start-day "+0d")
              (setq org-agenda-span-to-ndays "10d")
              (setq org-agenda-include-diary t)
              ;; (setq org-time-stamp-custom-formats '("<%y-%m-%d>" . "<%y-%m-%d %H:%M>"))

              ;; ics export
              (setq
               ;;  ;; org-icalendar-include-todo t
               ;;  ;; org-icalendar-use-deadline '(event-if-not-todo todo-due)
               org-icalendar-use-deadline '(event-if-not-todo)
               org-icalendar-use-scheduled '(event-if-not-todo)
               )
              ;; org-agenda-sorting-strategy
              ;; (setq org-todo-keywords
              ;;       '((sequence "TODO" "NEXT" "OPEN" "|" "DONE"))
              ;;       )
              (setq paperless-capture-directory "/home/oney/documents/scans"
                    paperless-root-directory    "/home/oney/documents")
              (require 'org-paperless)
            )
            )
  ;; XMODIFIERS=@im=none
  ;; (setenv "XMODIFIERS" "@im=none") 
  (add-to-list 'auto-mode-alist '("\\.eml\\'" . org-mode))
  (add-hook 'markdown-mode-hook
            '(lambda () (define-key markdown-mode-map "\c-c[" 'helm-bibtex)))
  ;; (setq bibtex-completion-bibliography '("~/zotero/insects.bib"))
  (setq bibtex-completion-bibliography '("~/documents/pubmaterials/anthropogenicsignal/carbocountch.bib"))
  (setq reftex-default-bibliography '("~/documents/pubmaterials/anthropogenicsignal/carbocountch.bib"))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol t)
 '(org-agenda-files
   (quote
    ("~/org/ensectable.org" "~/org/notes.org" "~/org/personal.org" "~/org/sibs.org")))
 '(package-selected-packages
   (quote
    (paperless zotxt yapfify ws-butler winum which-key web-mode web-beautify volatile-highlights vimrc-mode vi-tilde-fringe uuidgen use-package unfill toc-org tagedit spaceline smeargle slim-mode scss-mode sass-mode restart-emacs ranger rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pdf-tools pcre2el paradox pandoc-mode ox-twbs ox-pandoc orgit org-ref org-projectile org-present org-pomodoro org-plus-contrib org-download org-bullets open-junk-file neotree mwim move-text mmm-mode markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode live-py-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc insert-shebang info+ indent-guide ibuffer-projectile hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gnuplot gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md fuzzy flycheck-pos-tip flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu ess-smart-equals ess-R-object-popup ess-R-data-view emmet-mode elisp-slime-nav ein dumb-jump define-word dactyl-mode cython-mode csv-mode company-web company-tern company-statistics company-shell company-auctex company-anaconda column-enforce-mode coffee-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol auto-compile auctex-latexmk aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
