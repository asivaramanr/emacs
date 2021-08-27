;; .emacs.d/init.el

;; ===================================

;; MELPA Package Support

;; ===================================

;; Enables MELPA Stable  packaging support

(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

;; If there are no archived package contents, refresh them

(when (not package-archive-contents)
  (package-refresh-contents))

;; Installs packages

;; myPackages contains a list of package names

(defvar myPackages

  '(better-defaults               ;; Set up some better Emacs defaults

    vscode-dark-plus-theme        ;; Theme

    projectile                    ;; open files within projects

    solaire-mode                  ;; solaire folder view
   
    auto-complete                 ;; auto-completion for codes

    magit 			  ;; github

    neotree                       ;; neotree side view

    org-bullets                   ;; for org mode

    elpy                          ;; Emacs Lisp Python Environment

    flycheck                      ;; On the fly syntax checking

    py-autopep8                   ;; Run autopep8 on save

    python-black                     ;; Black formatting on save

    docker-compose-mode           ;; docker-compose

    dockerfile-mode               ;; docker file

    yaml-mode                     ;; yaml mode

    all-the-icons                 ;; icons for neotree

    )

  )

;; Scans the list in myPackages

(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;; ===================================

;; Basic Customization

;; ===================================

(setq message-log-max t)				         ;;message log

(add-to-list 'default-frame-alist '(fullscreen . maximized))     ;; Maximize window while startup

(setq inhibit-startup-message t)    			         ;; Hide the startup message

(global-linum-mode t)               			         ;; Enable line numbers globally

(setq linum-format "%4d ")	    			         ;; Default indend after line number

(show-paren-mode 1)					         ;; shows pair brackets	

;;(global-hl-line-mode)        				         ;; Highlighting the Current Line

(load-theme 'vscode-dark-plus t)    			         ;; Visual Studio Code Theme 

(solaire-global-mode +1)            			         ;; Folder view

(ac-config-default)           				         ;; autocomplete

;; ===================================

;; Default Directory

;; ===================================

(setq default-directory "C:\\Users\\AswinSivaramanR\\Documents\\github")
(setq command-line-default-directory "C:\\Users\\AswinSivaramanR\\Documents\\github")

;; ===================================

;; projectile

;; ===================================

(projectile-mode +1)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-indexing-method 'alien)
(setq projectile-sort-order 'default)
(setq projectile-enable-caching t)

;; ===================================

;; neotree

;; ===================================

(global-set-key [f8] 'neotree-toggle)

(setq neo-autorefresh nil)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; Work with Projectile

(setq projectile-switch-project-action 'neotree-projectile-action)

(defun my-neotree-project-dir-toggle ()
 (interactive)
  (require 'neotree)
  (let* ((filepath (buffer-file-name))
         (project-dir
          (with-demoted-errors
              (cond
               ((featurep 'projectile)
                (projectile-project-root))
               ((featurep 'find-file-in-project)
                (ffip-project-root))
               (t ;; Fall back to version control root.
                (if filepath
                    (vc-call-backend
                     (vc-responsible-backend filepath) 'root filepath)
                  nil)))))
         (neo-smart-open t))

    (if (and (fboundp 'neo-global--window-exists-p)
             (neo-global--window-exists-p))
        (neotree-hide)
      (neotree-show)
      (when project-dir
        (neotree-dir project-dir))
      (when filepath
        (neotree-find filepath)))))

(define-key global-map (kbd "M-e") 'my-neotree-project-dir-toggle)

;; ===================================

;; Org mode 

;; ===================================

(require 'org)

;; Orgmode Agenda

(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-include-diary t)

;; Default Directories

  (setq org-directory (expand-file-name "C:\\Users\\AswinSivaramanR\\Documents\\github\\org"))
  (setq org-agenda-files '("C:\\Users\\AswinSivaramanR\\Documents\\github\\org"))

;; Agenda style

(setq org-agenda-breadcrumbs-separator " ❱ "
      org-agenda-current-time-string "⏰ ┈┈┈┈┈┈┈┈┈┈┈ now"
      org-agenda-time-grid '((weekly today require-timed)
                             (800 1000 1200 1400 1600 1800 2000)
                             "---" "┈┈┈┈┈┈┈┈┈┈┈┈┈")
      org-agenda-prefix-format '((agenda . "%i %-12:c%?-12t%b% s")
                                 (todo . " %i %-12:c")
                                 (tags . " %i %-12:c")
                                 (search . " %i %-12:c")))

(setq org-agenda-format-date (lambda (date) (concat "\n" (make-string (window-width) 9472)
                                                    "\n"
                                                    (org-agenda-format-date-aligned date))))
(setq org-cycle-separator-lines 2)
(require 'all-the-icons)
(setq org-agenda-category-icon-alist
      `(("Work" ,(list (all-the-icons-faicon "cogs")) nil nil :ascent center)
        ("Personal" ,(list (all-the-icons-material "person")) nil nil :ascent center)
        ("Calendar" ,(list (all-the-icons-faicon "calendar")) nil nil :ascent center)
        ("Reading" ,(list (all-the-icons-faicon "book")) nil nil :ascent center)))


;; Keyword sequence

(setq org-todo-keywords
  '(
    (sequence "TODO(t)" "STARTED(s)" "NEXT(n)" "WAITING(w)" "CANCELLED(c)" "REPEAT(r)"
              "HOLD(h)" "VERIFY(v)" "|" "DONE(d)" "DELEGATE(d)") 
    (sequence "BUG(b)" "ISSUE(i)" "TESTING(t)" "|" "FIXED(f)")
   
   ))

;; Faces

(setq org-todo-keyword-faces
 '(("TODO" . "GoldenRod") 
   ("STARTED" . "yellow") 
   ("NEXT" . "IndianRed1") 
   ("WAITING" . "coral")
   ("CANCELLED"  . "amber")
   ("REPEAT" . "red") 
   ("HOLD" . "magenta")
   ("VERIFY" . "cyan") 
   ("BUG" . "red") 
   ("ISSUE" . "orange") 
   ("TESTING" . "yellow") 
   ("FIXED" . "green")
   ("DELEGATE" . "forest green")  
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

;; ====================================
;; Development Setup
;; ====================================

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

;;(require 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(all-the-icons dockerfile-mode docker-compose-mode vscode-dark-plus-theme solaire-mode py-autopep8 projectile org-bullets neotree magit flycheck elpy better-defaults auto-complete)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
