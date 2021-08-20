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

(setq message-log-max t)

(add-hook 'window-setup-hook 'toggle-frame-maximized t) ;; Maximize window while startup

(setq inhibit-startup-message t)    ;; Hide the startup message

(global-linum-mode t)               ;; Enable line numbers globally

(setq linum-format "%4d ")	    ;; Default indend after line number	

(solaire-global-mode +1)            ;; Folder view

(load-theme 'vscode-dark-plus t)    ;; Visual Studio Code Theme 

(ac-config-default)           ;; autocomplete

(global-company-mode)         ;; global company-mode

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

(setq default-directory "C:\\Users\\0018SI744\\GITHUB")

(setq command-line-default-directory "C:\\Users\\0018SI744\\GITHUB")

;; ====================================

;; Development Setup

;; ====================================

;; neotree

(add-to-list 'load-path "C:\\Users\\0018SI744\\AppData\\Roaming\\.emacs.d\\elpa\\neotree-0.5.2")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; ====================================

;; Python

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

;; Enable electric-pair

(defun electric-pair ()
  "If at end of line, insert character pair without surrounding spaces.
   Otherwise, just insert the typed character."
  (interactive)
  (if (eolp) (let (parens-require-spaces) (insert-pair)) 
    (self-insert-command 1)))

(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map "\"" 'electric-pair)
            (define-key python-mode-map "\'" 'electric-pair)
            (define-key python-mode-map "(" 'electric-pair)
            (define-key python-mode-map "[" 'electric-pair)
            (define-key python-mode-map "'" 'electric-pair)
            (define-key python-mode-map "{" 'electric-pair)))

;; ===================================

;; yaml-mode

;; ===================================


(require 'yaml-mode)
    (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))


(add-hook 'yaml-mode-hook
      '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(require 'docker-compose-mode)

;; ===================================

;; User-Defined init.el ends here

;; ===================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(powershell docker-compose-mode dockerfile-mode yaml-mode all-the-icons-ibuffer all-the-icons-ivy all-the-icons-ivy-rich all-the-icons-dired all-the-icons neotree projectile better-defaults)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
