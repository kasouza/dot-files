(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes '(wheatgrass))
 '(package-selected-packages '(smart-tabs-mode highlight-parentheses)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Macros for insert | and \ because my keyboard do not have these keys for
;; some reason
(global-set-key (kbd "M-p") (lambda ()
			      (interactive)
			      (insert "\\")))

(global-set-key (kbd "M-ç") (lambda ()
			      (interactive)
			      (insert "|")))

;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Use highlight parentheses mode in every buffer
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))

(global-highlight-parentheses-mode t)

;; Disable tool bar and menu bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Line Numbers
(global-display-line-numbers-mode t)

;; C-style
(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode t)

;; Smart tabs
(smart-tabs-insinuate 'c)

;; Set all backups to call to a single folder
(setq backup-directory-alist '(("." . "~/MyEmacsBackups")))

;; Use ibuffer as default instead of list-buffer
(defalias 'list-buffers 'ibuffer)
(display "sas")
