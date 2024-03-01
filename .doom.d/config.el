;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;
;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'leuven)

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

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; fd as Esc key binding
;; https://discourse.doomemacs.org/t/typing-jk-deletes-j-and-returns-to-normal-mode/59/7
(after! evil-escape
  (setq evil-escape-key-sequence "fd"))

;; https://discourse.doomemacs.org/t/what-are-leader-and-localleader-keys/153
;; Doom Defaults: `SPC' leader key, `SPC m' local leader
;; Set local leader to `,'
(setq doom-localleader-key ",")
;; ------------------------------------------------


;; ------------------------------------------------
;; Over-ride or add to Doom Emacs default key bindings

(map! :leader
      "SPC" nil
      :desc "M-x" "SPC" #'execute-extended-command)

(map! :leader
       (:prefix ("w". "Window")
         :desc "split" "/"     #'evil-window-split))

;; Layout keys - disable `SPC TAB' workspace prefix
(map! :leader
       (:prefix-map ("TAB" . nil))
       (:prefix ("l". "Layouts")
         :desc "Last Layout" "<tab>" #'+workspace/other
         :desc "Display Tabs" "d"    #'+workspace/display
         :desc "Delete layout" "D"   #'+workspace/delete
         :desc "Layout list" "l"     #'+workspace/switch-to
         :desc "Load Layout" "L"     #'+workspace/load
         :desc "New Layout" "n"      #'+workspace/new
         :desc "Rename Layout" "r"   #'+workspace/rename
         :desc "Restore session" "R" #'+workspace/restore-last-session
         :desc "Save Layout" "s"     #'+workspace/save
         :desc "Kill Session" "x"    #'+workspace/kill-session
         :desc "Switch to 0" "0"     #'+workspace/switch-to-0
         :desc "Switch to 1" "1"     #'+workspace/switch-to-1
         :desc "Switch to 2" "2"     #'+workspace/switch-to-2
         :desc "Switch to 3" "3"     #'+workspace/switch-to-3
         :desc "Switch to 4" "4"     #'+workspace/switch-to-4
         :desc "Switch to 5" "5"     #'+workspace/switch-to-5
         :desc "Switch to 6" "6"     #'+workspace/switch-to-6
         :desc "Switch to 7" "7"     #'+workspace/switch-to-7
         :desc "Switch to 8" "8"     #'+workspace/switch-to-8
         :desc "Switch to 9" "9"     #'+workspace/switch-to-9))

;; Buffer customisations
(map! :leader
         "TAB" nil
         :desc "Last Buffer" "TAB" #'evil-switch-to-windows-last-buffer)

;; Replace Doom `/' highlight with buffer-search
(map! :after evil
      :map evil-normal-state-map
      "/" #'+default/search-buffer)

(map! :leader
       (:prefix "b"
         :desc "Dashboard" "h" #'+doom-dashboard/open
         :desc "Toggle Last" "TAB" #'evil-switch-to-windows-last-buffer))


;; Treemacs
;; Toggle treemacs project browser from project menu
(map! :leader
      (:prefix "p"
         "t" nil  ; disable project todos key binding
         :desc "Project browser" "t" #'+treemacs/toggle))


;; Change SPC g s to call Magit Status, rather than stage hunk at point
(map! :leader
      (:prefix "g"
        :desc "" "s" nil  ; remove existing binding
        :desc "Magit Status" "s" #'magit-status))

;; Diff of files
(map! :leader
       (:prefix "f"
        :desc "" "d" nil  ; remove existing binding
        (:prefix ("d" . "diff")
         :desc "3 files" "3" #'ediff3
         :desc "ediff" "d" #'diff
         :desc "ediff" "e" #'ediff
         :desc "version" "r" #'vc-root-diff
         :desc "version" "v" #'vc-ediff)))

;; Format
(map! :leader
       (:prefix ("=" . "format")
         :desc "buffer" "=" #'+format/buffer
         :desc "buffer" "b" #'+format/buffer
         :desc "region" "r" #'+format/region
         :desc "whitespace" "w" #'delete-trailing-whitespace))


;; ------------------------------------------------
;; Experiments
;; Use `,,` to close a commit message and `,k' to cancel
;; Doom maps `ZZ` to commit, `ZQ' to quit
(map! :after magit
      :map text-mode-map
      :localleader
      "," #'with-editor-finish
      "k" #'with-editor-cancel)

(after! key-chord
  (key-chord-mode 1)
  ;; (setq key-chord-one-key-delay 0.20
  ;;       key-chord-two-keys-delay 0.05)
  (key-chord-define-global ";l" 'kill-this-buffer)
  (key-chord-define-global "ii" 'org-capture)
  (key-chord-define-global ";'" 'my-get-tasks)
  (key-chord-define-global ";t" 'shell)
  (key-chord-define-global ";s" 'magit-status)
  (key-chord-define-global "wq" 'vim-wq)
  (key-chord-define-global "jk" 'my-escape-and-save)
  (key-chord-define-global "BB" 'my-escape-and-bury)
  (key-chord-define-global ";i" 'completion-at-point)
  (key-chord-define-global ";c" 'my-make)
  )

(after! org
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
     ("j" "Jobs" entry                      (file "~/org/0-capture.org")            "* TODO apply to %? %x \t :getjob:computer:")
     ;; ("J" "Jokes" entry                     (file "~/org/0-capture.org")            "* Joke: %?\n %U %i")
     ("b" "Braindumps" entry                (file "~/org/0-capture.org")            "* Braindump: %?\n %U\n %i")
     )
   org-agenda-files (-remove
                     (lambda (str) (string-match  "#" str))
                     (append
                      (list "~/cdt-sia/cdt.org")
                      (file-expand-wildcards "~/org/*.org")))
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

  (require 'ox-koma-letter)
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
  (setq
   org-confirm-babel-evaluate nil
   org-src-preserve-indentation t
   org-startup-with-inline-images nil)
  (setq
   org-agenda-include-diary t
   org-icalendar-use-deadline '(event-if-not-todo)
   org-icalendar-use-scheduled '(event-if-not-todo)
   )
  (setq org-archive-location "~/Sync/org/%s::datetree/")
  )
