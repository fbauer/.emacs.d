(require 'package)
(require 'cl)
(setq package-archives '( ("marmalade" . "http://marmalade-repo.org/packages/") 
			  ("gnu" . "http://elpa.gnu.org/packages/")))


(package-initialize)

(defvar my-packages '(starter-kit starter-kit-lisp
                      starter-kit-bindings starter-kit-eshell
                      clojure-mode clojure-test-mode cider
                      rainbow-delimiters zenburn-theme))


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
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (zenburn)))
 '(custom-safe-themes (quote ("dd4db38519d2ad7eb9e2f30bc03fba61a7af49a185edfd44e020aa5345e3dca7" "be7eadb2971d1057396c20e2eebaa08ec4bfd1efe9382c12917c6fe24352b7c1" default)))
 '(imenu-auto-rescan t)
 '(js2-auto-indent-p nil)
 '(js2-bounce-indent-p t)
 '(js2-cleanup-whitespace t)
 '(js2-mode-indent-ignore-first-tab t)
 '(menu-bar-mode t)
 '(org-agenda-files (quote ("~/orgmode/logins.org.gpg")))
 '(python-remove-cwd-from-path nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; globally disallow tabs in indentation
(setq-default indent-tabs-mode nil)

(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
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
;; work-around for dead key problem
;; see http://www.emacswiki.org/emacs/DeadKeys
(require 'iso-transl)
