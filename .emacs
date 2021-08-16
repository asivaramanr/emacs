;;Basic Setup
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t
      initial-buffer-choice  nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode)
(setq ring-bell-function 'ignore)
(global-prettify-symbols-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("44ac1ad9ed61c0ba621691a59740310429dfae4995e4846db8350cdebfe245cc" default))
 '(package-selected-packages
   '(magit yaml-mode vscode-dark-plus-theme use-package python-mode pyenv-mode py-isort py-autopep8 powershell org-kanban org-bullets moody json-mode flycheck-color-mode-line elpy company-jedi auto-compile ansible ac-html)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; Package repo

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; use-package

(require 'use-package-ensure)
;; (setq use-package-always-ensure t)

;; Load up a theme

(load-theme 'vscode-dark-plus t)

;; Default Directory Windows ONLY

(setq default-directory "C:\\Users\\name\\GITHUB")
(setq command-line-default-directory "C:\\Users\\name\\GITHUB")


;;company

(use-package company
  :custom
  (company-idle-delay 0)
  (company-tooltip-align-annotations t)
  :config
  (add-hook 'prog-mode-hook 'company-mode))

;; flycheck

(use-package let-alist)
(use-package flycheck
  :init (global-flycheck-mode))


;;Org mode 

(setq org-support-shift-select t)
(require 'org)
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "VERIFY" "ISSUE" "TESTING" "|" "COMPLETED" "FIXED" )))

;; Color for TODO's
(setq org-todo-keyword-faces
 '(("TODO" . "yellow") ("IN-PROGRESS" . "orange") ("ISSUE" . "orange") ("TESTING" . "yellow") ("WAITING" . "magenta") 
 ("VERIFY" . "cyan") ("COMPLETED" . "green") ("FIXED" . "green"))
 )

;; Orgmode Bullets

(require 'org-bullets)
;; (setq org-bullets-bullet-list '("☯" "○" "✸" "✿" "~"))
 (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Org-mode Priority color

(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
                           (?B . (:foreground "yellow"))
                           (?C . (:foreground "green"))))

;; Exporting

(require 'ox-md)
(require 'ox-beamer)
(setq org-confirm-babel-evaluate nil)
(setq org-html-postamble nil)

(setq org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

;; Tex Configuration

(setq TeX-parse-self t)
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (LaTeX-math-mode)
            (setq TeX-master t)))

;; Python mode

(use-package python-mode)

;; Enable elpy. 

(use-package elpy)
(elpy-enable)

;; Use flycheck.
(add-hook 'elpy-mode-hook 'flycheck-mode)

;; Format code according to PEP8 on save:

(use-package py-autopep8)
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;;magit 

(autoload 'magit-status "magit" nil t)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
