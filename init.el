(defconst emacs-start-time (current-time))
(setq package-archives
      '(("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
        ("marmalade". "http://marmalade-repo.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")))

;; store elisp that is not yet handled by the package system here
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/use-package-20140601/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/bind-key-20140601/"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elpa/zenburn-theme-2.1/"))

(require 'use-package)

(use-package bind-key
  :defer t)

(use-package starter-kit
  :defer f)

(use-package starter-kit-lisp
  :defer t)

(use-package starter-kit-eshell
  :defer t)

(use-package elisp-slime-nav
  :defer t)

(use-package paredit
  :defer t)

(use-package idle-highlight-mode
  :defer t)

(use-package find-file-in-project
  :defer t)

(use-package smex
  :defer t)

(use-package ido-ubiquitous
  :defer t)

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

;; I have to run package-initialize here. If I don't do it, then
;; something above disables menu-bar-mode, without respecting
;; customize.
;;
;; FIXME: get rid of package-initialize, as it makes emacs startup slow.
(package-initialize)

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

;; get rid of special rendered fn symbol in clojure mode
(remove-hook 'clojure-mode-hook 'esk-pretty-fn)

;; global key bindings for org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; my own instaparse mode
(use-package instaparse-mode
  :mode ( "\\.grammar\\'" .  instaparse-mode))

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

;; This is a little hacky since VC doesn't support git add
;; internally

(eval-after-load 'vc
  (define-key vc-prefix-map "i"
    '(lambda () (interactive)
       (if (not (eq 'Git (vc-backend buffer-file-name)))
           (vc-register)
         (shell-command (format "git add %s" buffer-file-name))
         (message "Staged changes.")))))

;; Activate occur easily inside isearch

(define-key isearch-mode-map (kbd "C-o")
  (lambda () (interactive)
    (let ((case-fold-search isearch-case-fold-search))
      (occur (if isearch-regexp isearch-string (regexp-quote isearch-string))))))

(unless noninteractive
  (message "Loading time for %s: %0.3fs"
           load-file-name
           (- (time-to-seconds (current-time))
              (time-to-seconds emacs-start-time))))


