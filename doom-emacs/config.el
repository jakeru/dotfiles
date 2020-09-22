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
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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

(defun jr-day-of-week (dt)
  "Returns the day of the week, 1 to 7. Monday is 1."
  (string-to-number (format-time-string "%u" dt))
)

(defun jr-day-of-week-se (dt)
  "Returns the day of the week, in Swedish"
  (pcase (jr-day-of-week dt)
    (1 "måndag")
    (2 "tisdag")
    (3 "onsdag")
    (4 "torsdag")
    (5 "fredag")
    (6 "lördag")
    (7 "söndag")
  )
)

(defun jr-insert-current-date-time ()
  "Insert the current date and time into the current buffer."
  (interactive)
  (let ((now (current-time)))
     (insert (format-time-string "%Y-%m-%d " now))
     (insert (jr-day-of-week-se now))
     (insert (format-time-string " %H:%M" now))
     (insert "\n")
  )
)

(defun jr-insert-current-time ()
  "Insert the current time into the current buffer."
       (interactive)
       (insert (format-time-string "%H:%M" (current-time)))
       )

(map! :i "\C-cd" 'jr-insert-current-date-time)
(map! :i "\C-ct" 'jr-insert-current-time)

(map! :i "\C-h" 'evil-backward-char)
(map! :i "\C-j" 'evil-ret)

(setq! require-final-newline t)
