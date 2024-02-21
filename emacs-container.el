(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; set font
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11"))

;; Main typeface
(set-face-attribute 'default nil :family "DejaVu Sans Mono" :height 110)

;; Proportionately spaced typeface
(set-face-attribute 'variable-pitch nil :family "DejaVu Serif" :height 1.0)

;; Monospaced typeface
(set-face-attribute 'fixed-pitch nil :family "DejaVu Sans Mono" :height 1.2)

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

;; kill the whole line and don't leave the carriage
(setq kill-whole-line t)
(setq select-enable-clipboard t)            ; use the clipboard in addition to kill-ring
;; Let marks be set when shift arrowing, everybody does this
(setq shift-select-mode t)
(delete-selection-mode 1)

;; Remove the toolbar if it is bound, in terminal it isn't
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode 0))

;; Remove the menu bar - reintroduced
(menu-bar-mode 1)

;; use only spaces and no tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; replce yes/no with y/n 
(fset 'yes-or-no-p 'y-or-n-p)

;; Auto-revert on file-changed-on-disk
(global-auto-revert-mode t)

;; set window title to full filename
(setq frame-title-format '(" %b %+%+ %f"))

(global-visual-line-mode t)
(setq gc-cons-threshold 100000000)

(show-paren-mode)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package straight
  :custom (straight-use-package-by-default t))

;; set up backup behavior
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t    ; Don't delink hardlinks                           
      delete-old-versions t  ; Clean up the backups                             
      version-control t      ; Use version numbers on backups,                  
      kept-new-versions 2    ; keep some new versions                           
      kept-old-versions 1)   ; and some old ones, too
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(use-package yaml-mode)

;; Save places in buffers between sessions
(use-package saveplace
  :ensure nil ;builtin
  :init
  (setq-default save-place-mode t))

(use-package helm
  :diminish
  :bind
  (("C-c M-x" . 'execute-extended-command) ;; Save the default
   ("M-x"     . 'helm-M-x)                 ;; Replace M-x
   ("<menu>"  . 'helm-M-x)                 ;; ..and on the menu key as well
   ("C-x C-f" . 'helm-find-files)          ;; Find files
   ("C-x b" .   'helm-buffers-list))       ;; Find buffers
  :config
  (helm-mode 1)                            ;; All commands using completing-read (and what else?)
)

(use-package magit)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
