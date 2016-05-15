(defconst emacs-start-time (current-time))
;; Turn off tool bar and scroll bars early in startup to avoid momentary display
(dolist (mode '(tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

(setq package-archives
      '(("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")))

;; store elisp that is not yet handled by the package system here
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/beancount"))

(setq package-load-list '(
                          ;; load bind-key, use-package and the
                          ;; zenburn-theme early
                          (use-package t)
                          (bind-key t)
                          (diminish t)
                          (zenburn-theme t)
			  (smex t)
			  (ido-ubiquitous t)
			  (ido-completing-read+ t)))


;; Run package-initialize here to get the non-deferrable dependencies
;; already loaded.

(package-initialize)

(require 'use-package)

(use-package bind-key
  :defer t)

(use-package starter-kit-eshell
  :defer t)

(use-package elisp-slime-nav
  :defer t)

(use-package paredit
  :defer t
  :config (bind-key "M-)" 'paredit-forward-slurp-sexp paredit-mode-map))

(use-package idle-highlight-mode
  :defer t)

(use-package find-file-in-project
  :defer t)

(use-package smex
  :defer f
  :init
  (progn
    (setq smex-save-file (concat user-emacs-directory ".smex-items"))
    (smex-initialize)
    (global-set-key (kbd "M-x") 'smex)))

(use-package ido-ubiquitous
  :defer f
  :init
  (progn
    (ido-ubiquitous-mode 1)))

(use-package magit
  :defer t)

(use-package clojure-mode
  :defer t)

(use-package clojure-test-mode
  :defer t)

(use-package cider
  :defer t)

(use-package rainbow-delimiters
  :defer t)

(use-package zenburn-theme
  :init
  (load-theme 'zenburn t))

(setq x-alt-keysym 'meta)
(server-start)

;; ensure that all other packages are loaded later on by resetting
;; package-load-list

(setq package-load-list '(all))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-generic-program "firefox")
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "be7eadb2971d1057396c20e2eebaa08ec4bfd1efe9382c12917c6fe24352b7c1" default)))
 '(imenu-auto-rescan t t)
 '(menu-bar-mode t)
 '(org-agenda-files (quote ("~/orgmode/logins.org.gpg")))
 '(org-default-notes-file (concat org-directory "/notes"))
 '(org-directory "~/orgmode")
 '(python-remove-cwd-from-path nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; globally disallow tabs in indentation
(setq-default indent-tabs-mode nil)

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; global key bindings for org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; my own instaparse mode
(use-package instaparse-mode
  :load-path "/home/flo/.emacs.d/site-lisp/instaparse-mode"
  :mode ( "\\.grammar\\'" .  instaparse-mode))

;; beancount mode for beancount ledger files
;;; FIXME: integrate into use-package
(require 'beancount)
(add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))

(put 'downcase-region 'disabled nil)

(use-package org
  :defer t
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t))))


;;
;; Key bindings copy-pasted from starter-kit bindings 2.0.3
;;
;; FIXME: clean up things I don't use

;; It's all about the project.

(global-set-key (kbd "C-c f") 'find-file-in-project)

;; You know, like Readline.

(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Completion that uses many different methods to find options.

(global-set-key (kbd "M-/") 'hippie-expand)

;; Perform general cleanup.

(global-set-key (kbd "C-c n") 'esk-cleanup-buffer)

;; Turn on the menu bar for exploring new modes

(global-set-key (kbd "C-<f10>") 'menu-bar-mode)

;; Font size

(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Use regex searches by default.

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "\C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; Jump to a definition in the current file. (Protip: this is
;; awesome.)

(global-set-key (kbd "C-x C-i") 'imenu)

;; File finding

(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)

;; Window switching. (C-x o goes to the next window)

(windmove-default-keybindings) ;; Shift+direction

(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one

(global-set-key (kbd "C-x C-o") (lambda () (interactive) (other-window 2))) ;; forward two

;; Start eshell or switch to it if it's active.

(global-set-key (kbd "C-x m") 'eshell)

;; Start a new eshell even if one is active.

(global-set-key (kbd "C-x M") (lambda () (interactive) (eshell t)))

;; Start a regular shell if you prefer that.

(global-set-key (kbd "C-x C-m") 'shell)

;; If you want to be able to M-x without meta (phones, etc)

(global-set-key (kbd "C-c x") 'execute-extended-command)

;; Help should search more than just commands

(global-set-key (kbd "C-h a") 'apropos)

;; Should be able to eval-and-replace anywhere.

(global-set-key (kbd "C-c e") 'esk-eval-and-replace)

;; M-S-6 is awkward

(global-set-key (kbd "C-c q") 'join-line)

;; So good!

(global-set-key (kbd "C-c g") 'magit-status)

;; Activate occur easily inside isearch

(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

;;;
;;; Stuff copied from starter-kit-defuns.el
;;;
;;; FIXME: refactor to use-package specific sections
;;;



;;; These belong in prog-mode-hook:

;; We have a number of turn-on-* functions since it's advised that lambda
;; functions not go in hooks. Repeatedly evaling an add-to-list with a
;; hook value will repeatedly add it since there's no way to ensure
;; that a byte-compiled lambda doesn't already exist in the list.

(defun esk-local-column-number-mode ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t))

(defun esk-local-comment-auto-fill ()
  (set (make-local-variable 'comment-auto-fill-only-comments) t)
  (auto-fill-mode t))

(defun esk-turn-on-hl-line-mode ()
  (when (> (display-color-cells) 8)
    (hl-line-mode t)))

(defun esk-turn-on-save-place-mode ()
  (require 'saveplace)
  (setq save-place t))

(defun esk-turn-on-whitespace ()
  (whitespace-mode t))

(defun esk-turn-on-paredit ()
  (paredit-mode t))

(defun esk-turn-on-idle-highlight-mode ()
  (idle-highlight-mode t))

(defun esk-add-watchwords ()
  (font-lock-add-keywords
   nil '(("\\<\\(FIXME\\|TODO\\|FIX\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'esk-local-column-number-mode)
(add-hook 'prog-mode-hook 'esk-local-comment-auto-fill)
(add-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
(add-hook 'prog-mode-hook 'esk-turn-on-save-place-mode)
(add-hook 'prog-mode-hook 'esk-add-watchwords)
(add-hook 'prog-mode-hook 'esk-turn-on-idle-highlight-mode)

(defun esk-prog-mode-hook ()
  (run-hooks 'prog-mode-hook))

(defun esk-turn-off-tool-bar ()
  (tool-bar-mode -1))

(defun esk-untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun esk-indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun esk-cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (esk-indent-buffer)
  (esk-untabify-buffer)
  (delete-trailing-whitespace))

;; Commands

(defun esk-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun esk-sudo-edit (&optional arg)
  (interactive "p")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun esk-paredit-nonlisp ()
  "Turn on paredit mode for non-lisps."
  (interactive)
  (set (make-local-variable 'paredit-space-for-delimiter-predicates)
       '((lambda (endp delimiter) nil)))
  (paredit-mode 1))

;;;
;;; Stuff copied from starter-kit-lisp.el
;;;
;;; FIXME: break this into sections
;;;

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'emacs-lisp-mode-hook 'esk-remove-elc-on-save)
(add-hook 'emacs-lisp-mode-hook 'esk-prog-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)

(defun esk-remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (make-local-variable 'after-save-hook)
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))))

(define-key emacs-lisp-mode-map (kbd "C-c v") 'eval-buffer)

;;; Enhance Lisp Modes


(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)
(define-key lisp-mode-shared-map (kbd "RET") 'reindent-then-newline-and-indent)



(dolist (mode '(scheme emacs-lisp lisp clojure))
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
            'esk-turn-on-paredit)
  (add-hook (intern (concat (symbol-name mode) "-mode-hook"))
            'esk-turn-on-paredit))

;;;
;;; Stuff copied from starter-kit-misc.el
;;;
;;; FIXME: refactor to use-package specific sections
;;;


(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

;; can't do it at launch or emacsclient won't always honor it
(add-hook 'before-make-frame-hook 'esk-turn-off-tool-bar)

(setq visible-bell t
      inhibit-startup-message t
      color-theme-is-global t
      sentence-end-double-space nil
      shift-select-mode nil
      mouse-yank-at-point t
      uniquify-buffer-name-style 'forward
      whitespace-style '(face trailing lines-tail tabs)
      whitespace-line-column 80
      ediff-window-setup-function 'ediff-setup-windows-plain
      oddmuse-directory "~/.emacs.d/oddmuse"
      save-place-file "~/.emacs.d/places"
      backup-directory-alist `(("." . ,(expand-file-name "~/.emacs.d/backups")))
      diff-switches "-u")

(add-to-list 'safe-local-variable-values '(lexical-binding . t))
(add-to-list 'safe-local-variable-values '(whitespace-line-column . 80))

;; Set this to whatever browser you use
;; (setq browse-url-browser-function 'browse-url-firefox)
;; (setq browse-url-browser-function 'browse-default-macosx-browser)
;; (setq browse-url-browser-function 'browse-default-windows-browser)
;; (setq browse-url-browser-function 'browse-default-kde)
;; (setq browse-url-browser-function 'browse-default-epiphany)
;; (setq browse-url-browser-function 'browse-default-w3m)
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "~/src/conkeror/conkeror")

;; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

;; ido-mode is like magic pixie dust!
(ido-mode t)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-auto-merge-work-directories-length nil
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-use-virtual-buffers t
      ido-handle-duplicate-virtual-buffers 2
      ido-max-prospects 10)

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)

(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'auto-tail-revert-mode 'tail-mode)

(random t) ;; Seed the random-number generator

;; Hippie expand: at times perhaps too hip
(dolist (f '(try-expand-line try-expand-list try-complete-file-name-partially))
  (delete f hippie-expand-try-functions-list))

;; Add this back in at the end of the list.
(add-to-list 'hippie-expand-try-functions-list 'try-complete-file-name-partially t)

(eval-after-load 'grep
  '(when (boundp 'grep-find-ignored-files)
     (add-to-list 'grep-find-ignored-files "*.class")))

;; Cosmetics

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

(eval-after-load 'magit
  '(progn
     (set-face-foreground 'magit-diff-add "green4")
     (set-face-foreground 'magit-diff-del "red3")))

;; Get around the emacswiki spam protection
(eval-after-load 'oddmuse
  (add-hook 'oddmuse-mode-hook
            (lambda ()
              (unless (string-match "question" oddmuse-post)
                (setq oddmuse-post (concat "uihnscuskc=1;" oddmuse-post))))))


;;;
;;; Stuff copied from starter-kit.el
;;;
;;; FIXME: refactor to use-package specific sections
;;;

(require 'uniquify)

(unless noninteractive
  (message "Loading time for %s: %0.3fs"
           load-file-name
           (- (time-to-seconds (current-time))
              (time-to-seconds emacs-start-time))))
