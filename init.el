;; .emacs.d/init.el


;; ===================================

;; MELPA Package Support

;; ===================================

;; Enables basic packaging support

(require 'package)


;; Adds the Melpa archive to the list of available repositories

(add-to-list 'package-archives

             '("melpa-stable" . "https://stable.melpa.org/packages/") t)


;; Initializes the package infrastructure

(package-initialize)


;; If there are no archived package contents, refresh them

(when (not package-archive-contents)

  (package-refresh-contents))


;; Installs packages

;;

;; myPackages contains a list of package names

(defvar myPackages

  '(better-defaults                 ;; Set up some better Emacs defaults

    elpy                            ;; Emacs Lisp Python Environment

    flycheck                        ;; On the fly syntax checking

    py-autopep8                     ;; Run autopep8 on save

    vscode-dark-plus-theme          ;; Theme

    solaire-mode                    ;; solaire folder view

    )

  )


;; Scans the list in myPackages

;; If the package listed is not already installed, install it

(mapc #'(lambda (package)

          (unless (package-installed-p package)

            (package-install package)))

      myPackages)


;; ===================================

;; Basic Customization

;; ===================================


(setq inhibit-startup-message t)    ;; Hide the startup message

(solaire-global-mode +1)            ;; Folder view

(load-theme 'vscode-dark-plus t)    ;; Visual Studio Code Theme 

(global-linum-mode t)               ;; Enable line numbers globally

(add-hook 'window-setup-hook 'toggle-frame-maximized t) ;; Maximize window while startup

(windmove-default-keybindings)      ;; Move windows by SHIFT + Arrow

(setq linum-format "%d ")	    ;; Default indend after line number		

;; ===================================

;; Org mode 

;; ===================================

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

;; ===================================

;; Default Directory Windows ONLY

;; ===================================

(setq default-directory "C:/Users/AswinSivaramanR/Documents")

(setq command-line-default-directory "C:/Users/AswinSivaramanR/Documents")

;; ====================================

;; Development Setup

;; ====================================

;; Enable elpy

(elpy-enable)


;; Enable Flycheck

(when (require 'flycheck nil t)

  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))

  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; Enable autopep8

(require 'py-autopep8)

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; ===================================

;; User-Defined init.el ends here

;; ===================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(better-defaults)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

