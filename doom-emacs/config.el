;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Jakob Ruhe"
      user-mail-address "jakob.ruhe@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-acario-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Notes/org")

;; org-roam configuration
(setq org-roam-directory "~/Notes/org/roam")
(add-hook 'after-init-hook 'org-roam-mode)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Insert date and time
;; With inspiration from:
;; https://stackoverflow.com/questions/251908/how-can-i-insert-current-date-and-time-into-a-file-using-emacs

(defun jr-day-of-week-as-number (dt)
  "Return the day of the week of DT, 1 to 7. Monday is 1."
  (string-to-number (format-time-string "%u" dt))
)

(defun jr-day-of-week-sv (day-of-week)
  "Return the day as a string of DAY-OF-WEEK, in Swedish."
  (pcase day-of-week
    (1 "måndag")
    (2 "tisdag")
    (3 "onsdag")
    (4 "torsdag")
    (5 "fredag")
    (6 "lördag")
    (7 "söndag")
  )
)

(defun jr-day-of-week-en (day-of-week)
  "Return the day as a string of DAY-OF-WEEK, in English."
  (pcase day-of-week
    (1 "Monday")
    (2 "Tuesday")
    (3 "Wednesday")
    (4 "Thursday")
    (5 "Friday")
    (6 "Saturday")
    (7 "Sunday")
  )
)

(defun jr-day-of-week (dt lang)
  "Get the day of week of DT in language LANG."
  (let ((day-of-week (jr-day-of-week-as-number dt)))
    (if (equal lang "sv")
      (jr-day-of-week-sv day-of-week)
      (jr-day-of-week-en day-of-week)
    )
  )
)

(defun jr-current-date-in-lang (lang)
  "Get the current date using language LANG.
Note that only Swedish and English are supported.
If LANG is 'sv', Swedish will be used, otherwise English."
  (let ((now (current-time)))
    (concat
     (format-time-string "%Y-%m-%d " now)
     (jr-day-of-week now lang)
    )
  )
)

(defun jr-insert-current-date-in-lang (lang)
  "Insert the current date using language LANG."
  (interactive)
  (insert "* [" (jr-current-date-in-lang lang) "]\n")
)

(defun jr-insert-current-date ()
  "Insert the current date into the current buffer."
  (interactive)
  (jr-insert-current-date-in-lang ispell-current-dictionary)
)

(defun jr-insert-current-time ()
  "Insert the current time into the current buffer."
       (interactive)
       (insert "** " (format-time-string "%H:%M" (current-time)) "\n")
)

(map! :i "\C-cd" 'jr-insert-current-date)
(map! :i "\C-ct" 'jr-insert-current-time)

(map! :i "\C-h" 'evil-delete-backward-char)
(map! :i "\C-j" 'evil-ret)

;; Require final newline
(setq require-final-newline t)

;; Make it possible to copy text to and from emacs.
;; Note: This only works when running in X, not within
;; a terminal.
(setq select-enable-clipboard t)

;; Inspired by https://www.emacswiki.org/emacs/FlySpell
;; Swedish dictionary installed with:
;; apt install aspell-sv
(defvar lang-ring)
(let ((langs '("english" "sv")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))
(defun jr-switch-language()
  "Switch the language of the dictionary used for spell checking."
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))
(global-set-key [f6] 'jr-switch-language)

;; Note that on Ubuntu 20.04 and Emacs 27 I got the following
;; error:
;; Symbol's value as variable is void: ispell-menu-map-needed
;; I fixed this by updating the package dictionaries-common to
;; version 28.3 like so:
;; wget https://launchpad.net/ubuntu/+archive/primary/+files/dictionaries-common_1.28.3_all.deb
;; sudo apt install ./dictionaries-common_1.28.3_all.deb

(with-eval-after-load 'org
  (auto-fill-mode t))

(use-package! org-superstar
  :config
  (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
  (setq org-superstar-headline-bullets-list '("◉" "○" "✸" "◉"  "✿" "✿"  "✿"  "✿" ))
)

(use-package! org
  :config
  (setq org-ellipsis " ▾")
  (setq org-log-done 'time)
  (setq org-log-into-drawer t))

(add-to-list 'org-file-apps '("\\.pdf" . "zathura %s"))

(add-to-list 'auto-mode-alist '("\\Makefile.[a-zA-Z0-9_\-]+\\'" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("\\[a-zA-Z0-9_]+.zsh\\'" . shell-mode))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(with-eval-after-load "ox-latex"
  (add-to-list 'org-latex-classes
               '("koma-article" "\\documentclass{scrartcl}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  (add-to-list 'org-latex-classes
               '("wsf"
                 "\\documentclass{wsf}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes
               '("wjs"
                 "\\documentclass{wjs}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes
               '("wsf_agenda"
                 "\\documentclass{wsf_agenda}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes
               '("wjs_agenda"
                 "\\documentclass{wjs_agenda}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  )
;;; End of config.el
