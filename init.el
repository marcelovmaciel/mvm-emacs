;;; init.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2020 Marcelo Veloso Maciel
;;
;; Author: Marcelo Veloso Maciel <http://github/mvmaciel>
;; Maintainer: Marcelo Veloso Maciel <marcelovmaciel@protonmail.com>
;; Created: junho 29, 2020
;; Modified: junho 29, 2020
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/mvmaciel/init
;; Package-Requires: ((emacs 26.3) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  description
;;
;;; Code:

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

; (add-to-list 'load-path "~/nano-emacs")
; (load "~/nano-emacs/nano.el")
;; (require 'disp-table)
;; (require 'nano-colors)
;; (require 'nano-faces)
;; (require 'nano-layout)
;; (require 'nano-theme)
;; (require 'nano-splash)
;; (require 'nano-modeline)
;; (require 'nano-help)



;; Packages installation

;; (straight-use-package
;;  '(nano-emacs :type git :host github :repo "rougier/nano-emacs"))

(straight-use-package 'all-the-icons)
(straight-use-package 'avy)
(straight-use-package 'aio)
(straight-use-package 'counsel)
(straight-use-package 'ivy)
(straight-use-package 'ivy-bibtex)
(straight-use-package 'julia-mode)
(straight-use-package 'julia-repl)
(straight-use-package 'multiple-cursors)
(straight-use-package 'olivetti)
(straight-use-package 'page-break-lines)
(straight-use-package 'pdf-tools)
(straight-use-package 'projectile)
(straight-use-package 'smartparens)
(straight-use-package 'swiper)
(straight-use-package 'rainbow-delimiters)
(straight-use-package 'use-package)
(straight-use-package 'helpful)

(straight-use-package
 '(el-patch :type git :host github :repo "dandavison/xenops"))
(add-hook 'latex-mode-hook #'xenops-mode)
(add-hook 'LaTeX-mode-hook #'xenops-mode)

;; (straight-use-package '(nano-theme :type git :host github
;;                                    :repo "rougier/nano-theme"))

;; (straight-use-package '(nano-modeline :type git :host github
;;                                    :repo "rougier/nano-modeline"))

;; (load-library "nano-theme")
;; (nano-light)

;; (load-library "nano-modeline")
;; (nano-modeline)

(straight-use-package
 '(nano-emacs :type git :host github :repo "rougier/nano-emacs"))
(load-library "nano")


(use-package dashboard
  :straight t


  :demand t

  :ensure t
  
  :init
  (dashboard-setup-startup-hook)
  (add-hook 'after-init-hook 'dashboard-refresh-buffer)

;;  (add-hook 'dashboard-mode-hook 'my/dashboard-banner)

  :config
  (defun dashboard-setup ()
    "Setup post initialization hooks.
If a command line argument is provided,
assume a filename and skip displaying Dashboard."
    ;; Display useful lists of items
    (dashboard-insert-startupify-lists)
    (when (< (length command-line-args) 2 )
      (switch-to-buffer dashboard-buffer-name)
      (goto-char (point-min))
      (redisplay)))
  (dashboard-setup)

  (setq initial-buffer-choice #'(lambda () (get-buffer "*dashboard*")))

  (setq dashboard-items '((recents  . 5)
                          (projects . 5)
                          (agenda . 5)
                          ))

  (setq dashboard-startup-banner  1)
  (setq dashboard-center-content t)
;;  (setq dashboard-banner-logo-title "Through the bit glass λ")
 )


;; On and off configs

;(run-with-idle-timer 0.1 nil 'toggle-fullscreen)



(add-to-list 'default-frame-alist '(fullscreen . maximized))
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(ivy-mode 1)
(counsel-mode 1)
; (global-page-break-lines-mode 1 )
(smartparens-global-mode 1)
(windmove-default-keybindings)
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
(setq explicit-shell-file-name "/bin/bash")
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Line spacing, can be 0 for code and 1 or 2 for text
; (setq-default line-spacing 0)

;; Underline line at descent position, not baseline position
; (setq x-underline-at-descent-line t)

;; No ugly button for checkboxes
; (setq widget-image-enable nil)

;; Line cursor and no blink
; (set-default 'cursor-type  '(bar . 1))
(blink-cursor-mode 0)

;; No sound
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; No Tooltips
(tooltip-mode 0)

;; Paren mode is part of the theme
(show-paren-mode t)

(smartparens-global-mode 1)
(setq shell-file-name "/bin/sh")
; (set-face-font 'default "Roboto Mono Light 14")

(setq
 bibtex-completion-notes-path "~/Drive/Org/org-roam-mvm"
 bibtex-completion-bibliography "~/Drive/Org/bib/refs.bib"
 bibtex-completion-library-path "~/Drive/Org/pdfs"
  bibtex-completion-notes-template-multiple-files
 (concat
  "#+TITLE: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n"
  "* TODO Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journal}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"
  )
 )
(pdf-tools-install)
(provide 'init)

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "fe94e2e42ccaa9714dd0f83a5aa1efeef819e22c5774115a9984293af609fce7" default)))
 '(org-agenda-files (quote ("~/Drive/Org/agenda/week-agenda.org")))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
