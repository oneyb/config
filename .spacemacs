;; -*- mode: emacs-lisp; lexical-binding: t -*-

;; Bug in emacs 26.1
(if (string-match "26\.1" (emacs-version)) 
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
  )

(defun home-config ()
  (interactive)
  (setq
   dotspacemacs-default-font '(
                               ;; "Monospace"
                               "Ubuntu Mono"
                               :size 18
                               :weight normal
                               :width normal
                               :powerline-scale 1.0
                               )
   pdf-misc-print-programm "/usr/bin/gtklpq"
   browse-url-firefox-program "chromium-browser"
   x-select-enable-primary t
   x-select-enable-clipboard nil
   interprogram-paste-function 'x-cut-buffer-or-selection-value
   )
  (with-eval-after-load "python"
    (setq
     python-shell-interpreter "ipython"
     )
    )
  (with-eval-after-load "org"
    (setq
     org-capture-templates
     '(
       ("t" "General Tasks" entry             (file "~/org/0-capture.org")            "* TODO %?\t\t%^G\n %i")
       ("l" "Linked Task" entry               (file "~/org/0-capture.org")            "* TODO %? %a \t\t :computer:\n %i")
       ("p" "Programming Task" entry          (file "~/org/0-capture.org")            "* TODO %? \t\t :computer:\n %i")
       ("s" "Specific Programming Task" entry (file "~/org/0-capture.org")            "* TODO %? %a \t\t :computer:\n %i")
       ("a" "Set Appt." entry                 (file "~/org/0-capture.org")            "* %?\t\t%^G\n SCHEDULED: %^T\n %i")
       ("w" "Prepare apt. template" entry     (file "~/org/personal-development.org") "* TODO apt: %?; %x;\n %i")
       ("i" "Collect Info" entry              (file "~/org/0-capture.org")            "* %? %x \t\t:note:\n %i")
       ("m" "Emails to write" entry           (file "~/org/0-capture.org")            "* TODO %?%x \t\t:computer:phone:\n %i ")
       ("c" "Phone calls to make" entry       (file "~/org/0-capture.org")            "* TODO call %?%x \t\t:phone:\n %i     ")
       ;; ("j" "Jobs" entry                      (file "~/org/0-capture.org")            "* TODO apply to %? %x \t :getjob:computer:")
       ("J" "Jokes" entry                     (file "~/org/0-capture.org")            "* Joke: %?\n %U %i")
       ("b" "Braindumps" entry                (file "~/org/0-capture.org")            "* Braindump: %?\n %U\n %i")
       )
     org-agenda-files (-remove
                       (lambda (str) (string-match  "#" str))
                       (file-expand-wildcards "~/org/*.org"))
     org-tag-alist '(
                     ("ARCHIVE"  . ?a)
                     ("out"      . ?o)
                     ("home"     . ?h)
                     ("phone"    . ?p)
                     ("computer" . ?c)
                     ("learn"    . ?l)
                     ;; ("getjob"   . ?j)
                     ("note"     . ?n)
                     )
     org-agenda-custom-commands
     '(
       ("o" tags-todo "out/NEXT"     ) 
       ("h" tags-todo "home/NEXT"    ) 
       ("p" tags-todo "phone/NEXT"   ) 
       ("c" tags-todo "computer/NEXT") 
       ("l" tags-todo "learn/NEXT"   )
       ("j" tags-todo "getjob/NEXT"  ) 
       ("d" "My next action" todo "NEXT")
       )
     )
    (require 'org-contacts)
    (setq org-contacts-files (list "~/documents/contacts/contacts.org" ))
    (setq org-contacts-vcard-file "~/documents/contacts/org-contacts.vcf")
    (org-link-set-parameters "tel")

    (require 'ox-koma-letter)
    ;; re-enable template expansion
    (key-chord-define org-mode-map ";i" 'pcomplete) 
  (add-to-list 'org-latex-classes
               '("a4-labels"
                 "\\documentclass[a4paper,12pt]{article}
                             \\usepackage[newdimens]{labels}
                             \\LabelCols=3% Number of columns of labels per page
                             \\LabelRows=8% Number of rows of labels per page
                             \\LeftPageMargin=7mm% These four parameters give the
                             \\RightPageMargin=7mm% page gutter sizes. The outer edges of
                             \\TopPageMargin=15mm% the outer labels are the specified
                             \\BottomPageMargin=15mm% distances from the edge of the paper.
                             \\InterLabelColumn=2mm% Gap between columns of labels
                             \\numberoflabels=24
                             "
                 ))
  (add-to-list 'org-latex-classes
               '("letter-de"
                 "\\documentclass[DIV=14,
                                fontsize=11pt,
                                parskip=half,
                                backaddress=false,
                                fromemail=true,
                                fromphone=true,
                              fromalign=left]{scrlttr2}
                             \\usepackage[ngerman]{babel}"
                 ))
  (add-to-list 'org-latex-classes
               '("letter-en"
                 "\\documentclass[DIV=14,
                                fontsize=11pt,
                                parskip=half,
                                backaddress=false,
                                fromemail=true,
                                fromphone=true,
                              fromalign=left]{scrlttr2}
                              \\usepackage[english]{babel}"
                 ))
  (setq org-table-use-standard-references t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (emacs-lisp . t)
     (R          . t)
     (C          . t)
     (shell      . t)
     (python     . t)
     (ditaa      . t)
     (plantuml   . t)
     ))
  (setq
   org-confirm-babel-evaluate nil
   org-src-preserve-indentation t
   org-startup-with-inline-images nil)
  (require 'ob-shell)
  (spacemacs/toggle-auto-completion)
  (setq
   org-agenda-include-diary t
   org-icalendar-use-deadline '(event-if-not-todo)
   org-icalendar-use-scheduled '(event-if-not-todo)
   )
  (setq org-archive-location "~/Sync/org/%s::datetree/")
  )
  )
(defun work-config ()
  (interactive)
  (setq dotspacemacs-default-font '(
                                    "Source Code Pro"
                                    :size 14
                                    :weight normal
                                    :width normal
                                    :powerline-scale 1.0)
        )
  (global-set-key (kbd "<S-Insert>") #'clipboard-yank)
  (add-to-list 'exec-path "C:\\Program Files\\Git\\mingw64\\bin")
  (setenv "PATH" (mapconcat #'identity exec-path path-separator))
  (setq 
   helm-ag-ignore-patterns '("cscope.out" "cscope.files" "*TAGS" "*.map" "*.mac" "*.lst" "*.csv" "*.html" "*.xml")
   projectile-globally-ignored-file-suffixes 'helm-ag-ignore-patterns
   )
  (with-eval-after-load "projectile"
    (add-to-list 'projectile-globally-ignored-files "cscope.out")
    (add-to-list 'projectile-globally-ignored-files "cscope.files")
    (add-to-list 'projectile-globally-ignored-files "*TAGS")
    (add-to-list 'projectile-globally-ignored-files "*.map")
    (add-to-list 'projectile-globally-ignored-files "*.mac")
    ;; (add-to-list 'projectile-globally-ignored-files ".ld")
    (add-to-list 'projectile-globally-ignored-files "*.lst")
    (add-to-list 'projectile-globally-ignored-files "*.csv")
    (add-to-list 'projectile-globally-ignored-files "*.html")
    (add-to-list 'projectile-globally-ignored-files "*.xml")
    )
  (setq explicit-cmd.exe-args '("/K bigc"))
  (setq explicit-cmdproxy.exe-args '("/K bigc"))
  (setq shell-default-term-shell "C:\\Windows\\System32\\cmd.exe")
  (add-to-list 'exec-path "C:\\Program Files\\Git\\bin")
  ;; (add-to-list 'exec-path "C:\\Sources\\programs\\python36")
  (add-to-list 'exec-path "C:\\Python26")
  ;; (add-to-list 'exec-path "C:\\MinGW\\msys\\1.0\\bin")
  ;; (setq find-program "C:\\MinGW\\msys\\1.0\\bin\\find.exe"
  ;;       grep-program "C:\\MinGW\\msys\\1.0\\bin\\grep.exe")
  (setq python-shell-interpreter  "C:\\Python26\\python.exe")
  ;; (setenv "PATH" (mapconcat #'identity exec-path path-separator))
  ;; (setq grep-find-template
  ;;       "fd . <X> -type f <F> -exec grep <C> -nH -e <R> \\{\\} +")
  (with-eval-after-load "org"
    (setq
     org-capture-templates
     '(
       ("t" "General Tasks" entry (file "~/work-exchange/org/work.org") "* TODO %?\n %i")
       ("p" "Programming Task" entry (file "~/work-exchange/org/work.org") "* TODO %? \t\t :computer:\n %i")
       ("s" "Specific Programming Task" entry (file "~/work-exchange/org/work.org") "* TODO %? %a \t\t :computer:\n %i")
       ("i" "Collect Info" entry (file "~/work-exchange/org/work.org") "* %? %x \t\t:note:\n %i")
       ("b" "Braindumps" entry (file "~/work-exchange/org/work.org") "* Braindump: %?\n %U\n %i")
       )
     org-agenda-files (-remove
                       (lambda (str) (string-match  "#" str))
                       (file-expand-wildcards "~/work-exchange/org/*.org"))
     )
    )
  )
(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
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
   dotspacemacs-ask-for-lazy-installation nil
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     autohotkey
     windows-scripts
     yaml
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'complete
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-private-snippets-directory nil)
     better-defaults
     c-c++
     ;; for windows https://code.google.com/archive/p/cscope-win32/downloads
     cscope
     gtags
     spacemacs-misc
     ;; version-control
     ;; ycmd ;; above 
     ;; semantic
     spacemacs-defaults
     evil-commentary
     emacs-lisp
     lua
     pandoc
     spacemacs-evil
     shell-scripts
     ;; (spell-checking
     ;;  :variables spell-checking-enable-auto-dictionary t)
     syntax-checking
     ess
     ;; (ess :variables
     ;;      ess-enable-smart-equals t)
     python
     ranger
     csv
     javascript
     html
     ansible
     vimscript
     (plantuml :variables
               org-plantuml-jar-path (expand-file-name "~/bin/plantuml.jar")
               plantuml-jar-path (expand-file-name "~/bin/plantuml.jar"))
     ibuffer
     (markdown
      :eval-after-load
      ;; (auto-fill-mode 1)
      (spacemacs/toggle-auto-completion))
     (org :variables
          ;; org-enable-github-support t
          org-enable-bootstrap-support nil
          org-list-allow-alphabetical t
          org-want-todo-bindings t
          )
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(
                                      ;; xclip
                                      undo-tree
                                      zotxt
                                      ox-pandoc
                                      platformio-mode
                                      key-chord
                                      org-ref
                                      auctex
                                      company-auctex
                                      mmm-mode
                                      ob-async
                                      ;; ob-dart
                                      dart-mode
                                      ;; vdiff
                                      ripgrep
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(
                                    exec-path-from-shell
                                    spaceline
                                    )
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only)
  (if (string= (getenv "USER") "oney")
      (setf dotspacemacs-configuration-layers (cl-list*
                                               'graphviz
                                               'git
                                               'github
                                               '(erc :variables
                                                     erc-server-list '(("chat.freenode.net" :port "6697" :ssl t :nick "oneyb"))
                                                     erc-autojoin-channels-alist '(("freenode.net" "#lineageos-dev" "#lineageos"))
                                                     erc-enable-sasl-auth t
                                                     erc-autojoin-timing 'ident
                                                     erc-prompt-for-nickserv-password nil
                                                     )
                                               'pdf
                                               dotspacemacs-configuration-layers))
    (setf dotspacemacs-configuration-layers (cl-list*
                                             'debug
                                             'csharp
                                             'multiple-cursors
                                             'treemacs
                                             'cmake
                                             dotspacemacs-configuration-layers))
    )
  )
(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil
   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"
   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"
   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 6
   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)
   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil
   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil
   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
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
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '(
                                ;; (agenda . 10)
                                (todos . 9)
                                (recents . 9)
                                (projects . 12)
                                ;; (bookmarks . 6)
                                )
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'org-mode
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'org-mode
   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         leuven
                         default
                         dichromacy
                         )
   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)
   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '(
                               ;; ;; "Source Code Pro"
                               ;; "Courier New"
                               ;; :size 13
                               ;; :weight normal
                               ;; :width normal
                               ;; :powerline-scale 1.1
                               )
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
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
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil
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
   dotspacemacs-max-rollback-slots 30
   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar nil
   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t
   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling nil
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers
   '(:relative nil
               :disabled-for-modes dired-mode
               doc-view-mode
               markdown-mode
               org-mode
               pdf-view-mode
               ;; text-mode
               :size-limit-kb 1000)
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
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
   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t
   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil
   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server t
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%b"
   ;; dotspacemacs-frame-title-format "%b in %t"
   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format  nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil
   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil
   vim-style-remap-Y-to-y$ t
   )
  )
(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )
(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  ;; set this before evil loads
  ;; (setq evil-toggle-key (kbd "C-h"))
  ;; (add-to-list 'package-archives
  ;;            '("melpa" . "https://melpa.org/packages/") t)
  (setq ess-eval-visibly nil)
  (setq ess-ask-for-ess-directory nil)
  (setq org-todo-keywords '((sequence "TODO" "NEXT" "|" "DONE" "WAIT")))
  ;; (add-to-list 'default-frame-alist '(background-color . "beige"))
  ;; (setq helm-grep-default-command 
  ;;       ;; Its value is "grep --color=always -a -d skip %e -n%cH -e %p %f"
  ;;       "rg --vimgrep --no-heading --smart-case"
  ;;  )
  )
(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )
(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs
initialization after layers configuration.  This is the place
where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a
package is loaded, you should place your code here."
  (require 'dash)
  (if (string= (getenv "USER") "oney")
      (progn
        (message "Go to bed on time...")
        (home-config)
        )
    (message "Get to work!")
    (work-config)
    )
  ;; (fset 'evil-visual-update-x-selection 'ignore)
  (setq sentence-end-double-space t)
  (customize-set-variable 'helm-ff-lynx-style-map nil)
  (setq helm-ff-DEL-up-one-level-maybe t)
  (evil-leader/set-key
    ;; "?" 'ripgrep-regexp
    ;; "/" 'projectile-ripgrep
    "?" 'spacemacs/helm-dir-do-rg
    "/" 'spacemacs/helm-project-do-rg
    "fm" 'toggle-frame-maximized
    "fd" 'delete-frame
    "yf" 'my-put-file-path-in-clipboard
    "yb" 'my-put-buffer-name-in-clipboard
    "yl" 'my-put-file-path+line-number-in-clipboard
    "yd" 'my-put-current-directory-in-clipboard
    "oc" 'org-capture
    "oa" 'org-agenda
    "ob" 'org-iswitchb
    "ol" 'org-store-link
    "ot" 'org-todo-list
    )
  ;; (setq term-ansi-default-program "C:\\Program Files\\Git\\git-bash.exe") 
  (add-hook 'ediff-prepare-buffer-hook #'outline-show-all)
  (add-hook 'plantuml-mode-hook '(lambda ()
                                   (setq plantuml-default-exec-mode 'jar)
                                   (spacemacs/set-leader-keys-for-major-mode 'plantuml-mode
                                     "," 'plantuml-preview
                                     )
                                   ))
  (global-set-key (kbd "C-h") 'spacemacs/toggle-holy-mode)
  ;; (edit-server-start)
  ;; (require 'atomic-chrome)
  ;; (atomic-chrome-start-server)
  ;; (setq atomic-chrome-default-major-mode 'org-mode)
  (define-key evil-normal-state-map (kbd "g a") 'evil-lion-left)
  (define-key evil-normal-state-map (kbd "g A") 'evil-lion-right)
  (define-key evil-visual-state-map (kbd "g a") 'evil-lion-left)
  (define-key evil-visual-state-map (kbd "g A") 'evil-lion-right)
  (define-key evil-normal-state-map (kbd "g i") 'what-cursor-position)
  (define-key evil-visual-state-map (kbd "g i") 'what-cursor-position)
  (defun my-capitalize-first-char (&optional string)
    "Capitalize only the first character of the input STRING."
    (when (and string (> (length string) 0))
      (let ((first-char (substring string nil 1))
            (rest-str   (substring string 1)))
        (concat (capitalize first-char) rest-str))))
  (defun my-put-current-directory-in-clipboard ()
    "Put the current directory name on the clipboard"
    (interactive)
    (let ((x-select-enable-clipboard t)
          (res (my-capitalize-first-char default-directory)))
      (kill-new res)
      (message (concat "Copied: " res))
      )
    )
  (defun my-put-file-path+line-number-in-clipboard ()
    "Put the current file path with lineno on the clipboard"
    (interactive)
    (let ((filename (if (equal major-mode 'dired-mode)
                        default-directory
                      (buffer-file-name))))
      (when filename
        (let ((x-select-enable-clipboard t)
              (res (concat (my-capitalize-first-char filename) ":"
                           (number-to-string (line-number-at-pos)))))
          (kill-new res)
          (message (concat "Copied: " res))
          )
        )
      )
    )
  (defun my-put-buffer-name-in-clipboard ()
    "Put the current buffer path on the clipboard"
    (interactive)
    (let ((x-select-enable-clipboard t)
          (res (buffer-name)))
      (kill-new res)
      (message (concat "Copied: " res)))
    )
  (defun my-put-file-path-in-clipboard ()
    "Put the current file name on the clipboard"
    (interactive)
    (let ((filename (if (equal major-mode 'dired-mode)
                        default-directory
                      (buffer-file-name))))
      (when filename
        (let ((x-select-enable-clipboard t)
              (res (my-capitalize-first-char filename)))
          (kill-new res)
          (message (concat "Copied: " res)))
        )
      )
    )
  (setq-default kill-ring-max 666)
  (setq history-length 666)
  ;; (setq gdb-many-windows t)
  ;; (setq gdb-show-main t)
  (setq-default history-delete-duplicates t)
  (setq-default kill-do-not-save-duplicates t)
  (setq visible-bell t)
  (set-face-attribute 'line-number nil :background "gray96" :foreground "gray42")
  (set-face-attribute 'line-number-current-line nil :foreground "gray6")
  (defalias 'ttl         'toggle-truncate-lines)
  (defalias 'ke          'kill-emacs)
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
  (defun my-get-tasks ()
    "Get org tasks"
    (interactive)
    (org-tags-view t "computer")
    (delete-other-windows)
    )
  (defun my-make ()
    "fave make settings"
    (interactive)
    (helm-make '(3))
    )
  (setq auto-mode-alist
        (append '(
                  ("\\.Rmd\\'" . markdown-mode)
                  ("\\.ino\\'" . c++-mode)
                  ("\\.eml\\'" . org-mode)
                  ("mailto:"   . system)
                  ;; ("\\.png\\'"   . system)
                  ;; ("\\.pdf\\'"   . system)
                  ;; ("\\.ps\\'"    . system)
                  ;; ("\\.docx?\\'" . system)
                  ;; ("\\.xlsx?\\'" . "xdg-open %s")
                  ;; ("\\.html\\'"  . system)
                  )
                auto-mode-alist)
        )
  (setq sentence-end-double-space t)
  (key-chord-mode 1)
  ;; (key-chord-define evil-insert-state-map "jk" 'evil-escape)
  ;; (key-chord-define evil-normal-state-map "lk" 'kill-this-buffer)
  ;; (key-chord-define evil-insert-state-map "df" 'evil-escape)
  (setq recentf-auto-cleanup "1:00pm")
  (key-chord-define-global ";l" 'kill-this-buffer)
  (key-chord-define-global "ii" 'org-capture)
  (key-chord-define-global ";'" 'my-get-tasks)
  (key-chord-define-global ";t" 'shell)
  (key-chord-define-global "wq" 'vim-wq)
  (key-chord-define-global "jk" 'my-escape-and-save)
  (key-chord-define-global "BB" 'my-escape-and-bury)
  (key-chord-define-global ";i" 'completion-at-point)
  (key-chord-define-global ";c" 'my-make)
  (add-hook 'prog-mode-hook
            #'(lambda ()
                (modify-syntax-entry ?_ "w")
                (key-chord-define prog-mode-map ";i" 'completion-at-point)
                ))
  (setq-default fill-column 78)
  ;; ;; Visual stuff
  ;; (setq frame-title-format '("%b | " mode-name))
  ;; (setq frame-title-format '("%b | " projectile-project-name))
  (setq frame-title-format '("%b | " default-directory))
  (setq-default spacemacs-show-trailing-whitespace nil)
  (setq doc-view-continuous t)
  (setq font-use-system-font t)
  (setq display-time-day-and-date t display-time-24hr-format t)
  (display-time-mode 1)
  (setq truncate-lines t)
  ;; (setq-default cursor-type '(bar . 3))
  ;; (setq evil-move-cursor-back nil)
  ;; (setq evil-want-Y-yank-to-eol t)
  (setq kill-buffer-query-functions (remq 'process-kill-buffer-query-function kill-buffer-query-functions))
  (setq ediff-split-window-function 'split-window-horizontally
        ediff-window-setup-function 'ediff-setup-windows-plain)
  ;; Ispell
  (with-eval-after-load "ispell"
    (setq ispell-extra-args '("-w" "äöüÄÖÜß")
          ispell-dictionary "english"
          ispell-silently-savep t))
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
  ;; (defun my-c-config ()
  ;;   (interactive)
  ;;   )
  (with-eval-after-load "cc-mode"
    (setq
     c-c++-enable-clang-support t
     c-c++-default-mode-for-headers 'c++-mode
     realgud-safe-mode nil
     gdb-many-windows t
     gdb-show-main t
     )
    (define-key c-mode-map [C-down-mouse-1] 'spacemacs/jump-to-definition)
    (define-key c++-mode-map [C-down-mouse-1] 'spacemacs/jump-to-definition)
    (key-chord-define-local ";k" 'realgud-short-key-mode)
    (spacemacs/set-leader-keys-for-major-mode 'c++-mode
      "gc" 'helm-cscope-find-calling-this-function
      "gC" 'helm-cscope-find-called-function
      "gt" 'helm-gtags-create-tags
      "gI" 'cscope-index-files
      )
    (spacemacs/set-leader-keys-for-major-mode 'c-mode
      "gc" 'helm-cscope-find-calling-this-function
      "gC" 'helm-cscope-find-called-function
      "gt" 'helm-gtags-create-tags
      "gI" 'cscope-index-files
      )
    )

  (defun my-c-config ()
    (interactive)
    (c-add-style "own" 
                 '("linux"
                   (c-basic-offset . 2)
                   )
                 t)
    (setq c-default-style "own")
    )
  (add-hook 'c++-mode-hook 'my-c-config)
  (add-hook 'c-mode-hook   'my-c-config)

  (add-hook 'realgud-short-key-mode-hook
            (lambda ()
              (key-chord-define-local ";k" 'realgud-short-key-mode)
              ;; (gdb-display-locals-buffer)
              ;; ;; If you're having key mapping conflicts with other mode (e.g. evil-mode), you can assign a prefix to the same key shortcuts by adding the following hook:
              ;; (local-set-key "\C-c" realgud:shortkey-mode-map)
              )
            )
  ;; (add-hook 'dart-mode
  ;;           (lambda ()
  ;;             (spacemacs/set-leader-keys-for-major-mode 'dart-mode
  ;;               ;; "," 'dart-send-line-or-region-and-step
  ;;               "i" 'complete-symbol
  ;;               "?" 'dart-show-hover
  ;;               "r" 'dart-find-refs 
  ;;               "f" 'dart-format
  ;;               "hh" 'dart-goto
  ;;               ;; "," 'sh-execute-region
  ;;               ;; "." 'sh-exec
  ;;               ;; "hh" 'sh-heredoc
  ;;               )
  ;;             (setq dart-sdk-path "/home/oney/Android/flutter/bin/cache/dart-sdk/")
  ;;             (setq dart-executable-path "/home/oney/Android/flutter/bin/cache/dart-sdk/bin/dart")
  ;;             (setq dart-enable-analysis-server t)
  ;;             (setq dart-format-on-save t)
  ;;             (flycheck-mode)
  ;;             (setq dart-debug t)
  ;;             )
  ;;           )
  (with-eval-after-load "make-mode"
    (spacemacs/set-leader-keys-for-major-mode 'make-mode
      "," 'my-make
      "i" 'completion-at-point
      )
    (define-key evil-insert-state-map (kbd "TAB") 'completion-at-point           )
    ;; (define-key evil-normal-state-map (kbd "j"  ) 'makefile-browser-next-line    )
    ;; (define-key evil-insert-state-map (kbd "k"  ) 'makefile-browser-previous-line)
    )
  (with-eval-after-load "sh-script"
    (spacemacs/set-leader-keys-for-major-mode 'sh-mode
      "," 'sh-send-line-or-region-and-step
      "i" 'complete-symbol
      ;; "," 'sh-execute-region
      ;; "." 'sh-exec
      ;; "hh" 'sh-heredoc
      )
    )
  (with-eval-after-load "python"
    (spacemacs/set-leader-keys-for-major-mode 'python-mode
      ;; "."   'python-shell-send-defun
      ;; "."   'python-shell-send-defun-switch
      ","   'python-shell-send-region
      "."   'python-shell-send-region-switch
      ;; "r"   'python-shell-send-buffer-switch
      "k"   'anaconda-mode-complete
      "TAB" 'python-start-or-switch-repl
      )
    ;; (remove-hook 'python-mode-hook 'spacemacs//init-eldoc-python-mode)
    ;; (setq python-shell-interpreter "/usr/bin/ipython")
    (setq python-shell-interpreter "ipython3")
    (setq python-enable-yapf-format-on-save t)
    ;;       python-shell-interpreter-args "--simple-prompt -i")
    )
  (with-eval-after-load "ess-mode"
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
  ;; (with-eval-after-load "yaml-mode"
  ;;             (defun my-newline-and-indent ()
  ;;               "My newline and indent"
  ;;               (interactive)
  ;;               (newline-and-indent)
  ;;               (insert "- ")
  ;;               )
  ;;             (spacemacs/set-leader-keys-for-major-mode 'yaml-mode
  ;;               "o" 'my-newline-and-indent
  ;;               ) 
  ;;           )

  (with-eval-after-load "elisp-mode"
    ;; change what is considered a word (w-o-r-d)
    (modify-syntax-entry ?- "w")
    )
  (with-eval-after-load "org"
    ;; re-enable template expansion
    ;; change what is considered a word (w_o_r_d)
    ;; (message "Org config loaded")
    (modify-syntax-entry ?_ "w")
    (setq
     org-export-with-toc nil
     org-export-with-sub-superscripts '{}
     org-want-todo-bindings t
     org-export-with-date nil
     org-export-with-creator nil
     org-export-time-stamp-file nil
     )
    (setq org-stuck-projects '("+LEVEL=1/-DONE" ("TODO" "NEXT") ("ref") "\\<SCHEDULED\\>|\\<DEADLINE\\>"))
    (delete '("\\.pdf\\'" . default) org-file-apps)
    (add-to-list 'org-file-apps '(
                                  ("\\.pdf\\'" . "evince %s")
                                  ("\\.xlsx?\\'" . "xdg-open %s")
                                  )
                 )
    (require 'ob-async)     
    (setq org-refile-targets '((org-agenda-files :maxlevel . 2)))	
    (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
    (setq org-refile-use-outline-path 'file)
    ;; (setq org-refile-use-outline-path t)                  ; Show full paths for refiling
    (add-hook 'org-capture-mode-hook 'evil-insert-state)
    (setq org-tags-column -91)
    (setq org-table-use-standard-references t)
    (setq org-confirm-babel-evaluate nil)
    (setq org-src-preserve-indentation t)
    (setq org-startup-with-inline-images nil)
    (setq org-agenda-include-diary t)
    ;; (setq org-time-stamp-custom-formats '("<%y-%m-%d>" . "<%y-%m-%d %H:%M>"))
    (require 'org-tempo)
    (key-chord-define org-mode-map ";i" 'pcomplete) 
    (spacemacs/set-leader-keys-for-major-mode 'org-mode
      "ir"  'org-ref-helm-insert-cite-link
      "p"   'org-priority
      "z"   'org-pomodoro
      "xd"  'org-do-demote
      "r"   'org-refile
      "TAB" 'org-babel-switch-to-session
      )
    (spacemacs/set-leader-keys-for-major-mode 'org-agenda-mode
      "p" 'org-priority
      "z" 'org-pomodoro
      "c" 'org-capture
      "r" 'org-refile
      )
    (org-babel-do-load-languages
     'org-babel-load-languages
     '(
       (emacs-lisp . t)
       (R          . t)
       (C          . t)
       (shell      . t)
       (python     . t)
       (ditaa      . t)
       (plantuml   . t)
       ))
    ;; (require 'ob-sh)
    ;; see: C:/emacs/share/emacs/26.2/lisp/progmodes/sh-script.el
    ;; (require 'ob-shell)
    ;; (defadvice org-babel-sh-evaluate (around set-shell activate)
    ;;   "Add header argument :shcmd that determines the shell to be called."
    ;;   (let* ((org-babel-sh-command (or (cdr (assoc :shcmd params)) org-babel-sh-command)))
    ;;     ad-do-it
    ;; ))
    ;; (defun my-org-confirm-babel-evaluate (lang body)
    ;;   (not (string= lang "ditaa")))  ; don't ask for ditaa
    ;; (setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
    (spacemacs/toggle-auto-completion)
    )
  ;; (add-hook 'org-mode-hook
  ;;   (lambda ()
  ;;   )
  ;;   )
  ;; (setq request-backend 'url-retrieve )
  (setq request-message-level 'debug)
  (setq warning-minimum-level :error)
  )

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-want-Y-yank-to-eol t)
 '(helm-ff-lynx-style-map nil)
 '(org-agenda-files
   (quote
    ("~/org/0-capture.org" "~/org/baerfutt.org" "~/org/gtd.org" "~/org/personal-development.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
