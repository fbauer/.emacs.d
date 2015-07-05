(defconst emacs-start-time (current-time))
(require 'package)
(require 'cl)
(setq package-archives
      '(("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
        ("marmalade". "http://marmalade-repo.org/packages/")
        ("gnu" . "http://elpa.gnu.org/packages/")))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-to-load-path '())
  (normal-top-level-add-subdirs-to-load-path))

(package-initialize)

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      elisp-slime-nav
                      paredit
                      idle-highlight-mode
                      find-file-in-project
                      smex
                      ido-ubiquitous
                      magit
                      clojure-mode
                      clojure-test-mode
                      cider
                      rainbow-delimiters
                      zenburn-theme))


(defun my-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (package-refresh-contents)
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(setq x-alt-keysym 'meta)
(server-start)
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

(load-theme 'zenburn t)

;; get rid of special rendered fn symbol in clojure mode
(remove-hook 'clojure-mode-hook 'esk-pretty-fn)

;; global key bindings for org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; store elisp that is not yet handled by the package system here
(add-to-list 'load-path (expand-file-name "~/.emacs.d/site-lisp/"))

;; my own instaparse mode
(require 'instaparse-mode)
(put 'downcase-region 'disabled nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)))

(unless noninteractive
  (message "Loading time for %s: %0.3fs"
           load-file-name
           (- (time-to-seconds (current-time))
              (time-to-seconds emacs-start-time))))
