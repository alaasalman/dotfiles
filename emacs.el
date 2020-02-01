;;; e.el --- my stuff  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; set color theme
(if (display-graphic-p)
    (load-theme 'wombat t))

;; set font
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11"))

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)
;; Don't let Emacs hurt your ears
(setq visible-bell t)

;; Remove the toolbar if it is bound, in terminal it isn't
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode 0))

;; Remove the menu bar
(menu-bar-mode 0)
; use only spaces and no tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

;; added several emacs pkg repos
(require 'package)
(package-initialize)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; for auto complete with buffers and misc. isn't that already on?
(require 'ido)
(ido-mode t)

;; stuff for el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))
(el-get 'sync)

;; for syntax checking
;;(add-hook 'after-init-hook #'global-flycheck-mode)

;; set window title to full filename
(setq frame-title-format '(" %b %+%+ %f"))

;; add js2-mode for better JS support
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; nginx mode for editing config files, activated for .com files
(add-to-list 'auto-mode-alist '("\\.com$" . nginx-mode))

;; rainbowmode to turn color names into colors
;;(add-hook 'css-mode-hook 'rainbow-mode)

;; rainbow-delimiters to highlight matching braces
;; and parens with different colors
;;(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; activate web-mode for html and templates
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; and customize it
(defun web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-enable-current-element-highlight t))

(add-hook 'web-mode-hook 'web-mode-hook)

;; some org-mode config
(require 'org)
(setq org-startup-indented t)
(setq org-hide-leading-stars t)
(setq org-completion-use-ido t)
(setq org-indent-mode t)
(setq org-startup-folded 'showeverything)
(setq org-log-done 'time)
(global-visual-line-mode t)

(require 'org-archive)
(setq org-archive-mark-done t)
(setq org-archive-save-context-info '(ltags itags category olpath))
(setq org-archive-location "::* Finished")

(defun custom-clean-done-todo ()
"Move DONE items to archive on state change."
  (when (member org-state org-done-keywords)
    (org-archive-subtree)))

(add-hook 'org-after-todo-state-change-hook 'custom-clean-done-todo)

(defun custom-insert-date-todo (&rest ignore)
  "Insert a CREATED property to track how long todos remain in my list"
  (when (not (org-entry-get nil "CREATED")))
  (org-entry-put nil "CREATED" (format-time-string (cdr org-time-stamp-formats))))

(advice-add 'org-insert-todo-heading :after 'custom-insert-date-todo)
(add-hook 'org-after-todo-state-change-hook 'custom-insert-date-todo)
;; end org-mode config

;; Auto-revert on file-changed-on-disk
(global-auto-revert-mode t)

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flycheck-mode)))

;; Configure to wait a bit longer after edits before starting
(setq-default flymake-no-changes-timeout '2)


;; Some flycheck config options
(setq-default flycheck-highlighting-mode 'symbols)

;;; .emacs.el ends here
