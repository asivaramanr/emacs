;; .emacs.d/init.el


;; ===================================

;; MELPA Package Support

;; ===================================

;; Enables basic packaging support

(require 'package)


;; Adds the Melpa archive to the list of available repositories

(add-to-list 'package-archives

             '("melpa-stable" . "https://stable.melpa.org/packages/") 
             '("org" . "https://orgmode.org/elpa/"))


;; Initializes the package infrastructure

(package-initialize)

;; If there are no archived package contents, refresh them

(when (not package-archive-contents)

  (package-refresh-contents))

;; Installs packages

;; myPackages contains a list of package names

(defvar myPackages

  '(better-defaults                 ;; Set up some better Emacs defaults

    vscode-dark-plus-theme          ;; Theme

    projectile                     ;; open files within projects

    solaire-mode                    ;; solaire folder view
   
   auto-complete                  ;; auto-completion for codes

    magit 			  ;; github

    neotree                        ;; neotree side view

    org-bullets                    ;; for org mode

    elpy                            ;; Emacs Lisp Python Environment

    flycheck                        ;; On the fly syntax checking

    py-autopep8                     ;; Run autopep8 on save

   python-black                   ;; python buffer formating

    docker-compose-mode            ;; docker-compose

    dockerfile-mode                ;; docker file

    yaml-mode                      ;; yaml mode


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

(setq inhibit-startup-message t)    			;; Hide the startup message

(global-linum-mode t)               			;; Enable line numbers globally

(setq linum-format "%4d ")	    			;; Default indend after line number

(show-paren-mode 1)					;; shows pair brackets	

;;(global-hl-line-mode)        				;; Highlighting the Current Line

(load-theme 'vscode-dark-plus t)    			;; Visual Studio Code Theme 

(solaire-global-mode +1)            			;; Folder view

(ac-config-default)           				;; autocomplete

;; ===================================

;; projectile

;; ===================================

(projectile-mode +1)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(setq projectile-indexing-method 'alien)

(setq projectile-sort-order 'default)

(setq projectile-enable-caching t)


;; ===================================

;; Org mode 

;; ===================================

;; Default Directories

(string-equal system-type "windows-nt")

(setq org-directory (expand-file-name "C:\\Users\\AswinSivaramanR\\Documents\\github\\org"))
(setq org-agenda-files '("C:\\Users\\AswinSivaramanR\\Documents\\github\\org"))

;; Keyword sequence

(setq org-todo-keywords
  '(
   (sequence "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "REPEAT(r)" "ON-HOLD(h)" "VERIFY(v)" "|" "DONE(d)" "COMPLETED(d)") 
   (sequence "BUG(b)" "ISSUE(i)" "TESTING(t)" "|" "FIXED(f)")
   
   ))

;; keyword Color

(setq org-todo-keyword-faces
 '(("TODO" . "GoldenRod") 
   ("STARTED" . "yellow") 
   ("NEXT" . "IndianRed1") 
   ("WAITING" . "coral")
   ("REPEAT" . "red") 
   ("ON-HOLD" . "magenta")
   ("VERIFY" . "cyan") 
   ("BUG" . "red") 
   ("ISSUE" . "orange") 
   ("TESTING" . "yellow") 
   ("FIXED" . "green")
   ("COMPLETED" . "green")  
   ("DONE" . "green"))
  )



;; Orgmode Bullets

(require 'org-bullets)
;; (setq org-bullets-bullet-list '("☯" "○" "✸" "✿" "~"))
 (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Orgmode priority color

(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
                           (?B . (:foreground "yellow"))
                           (?C . (:foreground "green"))))

;; Orgmode Agenda

(require 'org)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Orgmode blank line

(setq org-blank-before-new-entry
	'((heading . nil) (plain-list-item . nil)))

;; ===================================

;; Default Directory

;; ===================================

(setq default-directory "C:\\Users\\AswinSivaramanR\\Documents\\github")

(setq command-line-default-directory "C:\\Users\\AswinSivaramanR\\Documents\\github")

;; ====================================

;; Development Setup

;; ====================================

;; neotree

(global-set-key [f8] 'neotree-toggle)

;; Work with Projectile

(setq projectile-switch-project-action 'neotree-projectile-action)

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; ====================================

;; Python

;; ====================================

;; Enable elpy

(elpy-enable)

;; Enable Flycheck

(when (require 'flycheck nil t)
 ;; (setq flycheck-highlighting-mode 'lines)
  (setq flycheck-indication-mode 'left-fringe)
  (setq flycheck-checker-error-threshold 2000)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; Enable autopep8

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; python-black

;;(add-hook 'elpy-mode-hook 'python-black-buffer)
;;(add-hook 'elpy-mode-hook 'python-black-on-save-mode-enable-dwim)


;; ===================================

;; yaml-mode

;; ===================================

(require 'yaml-mode)
    (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))


(add-hook 'yaml-mode-hook
      '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; ===================================

;; Docker

;; ===================================

(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(require 'docker-compose-mode)

;; ===================================

;; User-Defined init.el ends here

;; ===================================
