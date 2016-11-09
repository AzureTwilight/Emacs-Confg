;;========================================
;; Start the emacsserver that listens to emacsclient
(server-start)

;; orgmode elpa 
(add-to-list 'load-path "~/.emacs.d/elpa")
;; (add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; (global-linum-mode 1)
(add-hook 'prog-mode-hook 'linum-mode)
(add-hook 'LaTeX-mode-hook 'linum-mode)
(add-hook 'Lua-mode-hook 'linum-mode)
(desktop-save-mode 1)

(setq confirm-kill-emacs 'y-or-n-p)
;; (setq x-select-enable-clipboard nil)
(setq x-select-enable-clipboard t)
(global-set-key (kbd "C-c y") 'x-clipboard-yank)

;; (add-hook 'before-make-frame-hook #'(lambda () (load-file "~/.emacs")))

;; Disable Tool-Bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; Solve Problem of Fonts when Chinese and English Co-Exist
;; (set-default-font "Fira Mono for Powerline Regular:antialias=none")
;; (set-default-font "Fira Mono for Powerline:antialias=none")
(set-face-attribute 'default nil :font "Fira Mono Medium for Powerline" )
(set-face-attribute 'default nil :height 120)
(set-frame-font "Fira Mono Medium for Powerline" nil t)
(set-fontset-font "fontset-default" 'chinese-gbk "PingFang SC Regular")

;; (setq face-font-rescale-alist '(("Songti SC Regular" . 1.2)
;;                ("Microsoft YaHei" . 1.2)
;;		("Adobe Heiti Std R" . 1.1)
;;                ))

(global-set-key (kbd "C-<up>") 'windmove-up)
(global-set-key (kbd "C-<down>") 'windmove-down)
(global-set-key (kbd "C-<left>") 'windmove-left)
(global-set-key (kbd "C-<right>") 'windmove-right)
(global-set-key (kbd "C-c =") 'align-regexp)
(global-set-key (kbd "C-c C-c =") '(align-regexp =))
(global-set-key (kbd "C-c j") 'imenu)
(global-set-key (kbd "C-c g") 'magit-status)

(set-register ?c (cons 'file "~/Dropbox/Fa16/Class Notes/Fa16 Class Notes Index.org"))
(set-register ?e (cons 'file "~/.emacs"))
(set-register ?f (cons 'file "~/Dropbox/Personal Notes/Food-List.org"))

;; Set Themes
(if (display-graphic-p)
    ;; (load-theme 'material t)
    (load-theme 'zenburn t)
  (enable-theme 'tango-dark))

;; Auto-Save Files and Backups for Dropbox
(add-to-list 'auto-save-file-name-transforms '("\\`.*/Dropbox/.*" "/tmp/" t))
(add-to-list 'backup-directory-alist '("\\`.*/Dropbox/.*" . "/tmp/"))

;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;(global-set-key (kbd "C-u C-c C-i") 'org-table-iterate-buffer-tables)
(setq backup-directory-alist '(("" . ".emacsbackup")))

(load-file "~/.emacs.d/org-conf.el")


(defun set-exec-path-from-shell-PATH ()
  "Sets the exec-path to the same value used by the user shell"
  (let ((path-from-shell
         (replace-regexp-in-string
          "[[:space:]\n]*$" ""
          (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)
;; Activate Smartparens
(require 'smartparens-config)

(require 'zlc)
(zlc-mode t)

(require 'popup)
;; Set up Auto-Complete
;; (require 'auto-complete)
;; (ac-config-default)

;; Activate Evil Mode
;; Evil -Leader
(require 'evil-leader)
(setq evil-leader/in-all-states 1)
(evil-leader/set-leader ",")
(global-evil-leader-mode)

(evil-leader/set-key
  "f" 'find-file
  "b" 'bs-show
  "B" 'ibuffer
  "x" 'smex
  "w" 'save-buffer
  "k" 'kill-buffer
  "Q" 'kill-emacs
  )
(require 'evil)
(evil-mode 1)
(require 'evil-org)
;;(evil-set-initial-state 'bs-mode 'emacs)
(define-key evil-normal-state-map (kbd "C-w") 'evil-scroll-line-up)
;; Set Cursor Style 
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("gray" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("green" bar))
(setq evil-replace-state-cursor '("red" box))
(setq evil-operator-state-cursor '("red" hollow))


;; Evil MC
(require 'evil-mc)
(global-evil-mc-mode 1)

; BS-menu
(defadvice bs-mode (before bs-mode-override-keybindings activate)
  ;; use the standard bs bindings as a base
  (evil-make-overriding-map bs-mode-map 'normal t)
  (evil-define-key 'normal bs-mode-map "h" 'evil-backward-char)
  (evil-define-key 'normal bs-mode-map "q" 'bs-abort)
  (evil-define-key 'normal bs-mode-map "j" 'bs-down)
  (evil-define-key 'normal bs-mode-map "k" 'bs-up)
  (evil-define-key 'normal bs-mode-map "l" 'evil-forward-char)
  (evil-define-key 'normal bs-mode-map "RET" 'bs-select))


;; Bind C-x b to bs-show
(global-set-key (kbd "C-x C-b") 'bs-show)

;; Activate Smex
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Activate Projectile
;; (require 'projectile)
;; (projectile-global-mode)
;; (setq projectile-require-project-root nil)

;; Activate Hightlight-Indentation
;; (require 'hightlight-indentation)
(add-hook 'prog-mode-hook #'highlight-indentation-mode)
(add-hook 'prog-mode-hook #'highlight-indentation-current-column-mode)


;; Activate Yasnippet
(require 'yasnippet)
;; Activate Global Mode
;; (yas-global-mode 1)
;; Activate Minor Mode on Buffer Basis
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'LaTeX-mode-hook #'yas-minor-mode)
;; Activate Powerline
;; (require 'powerline)
;; (require 'cl)

(require 'evil-matchit)
(global-evil-matchit-mode 1)

;; (setq powerline-arrow-shape 'arrow)   ;; the default
;; (custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 ;; '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

(require 'powerline-evil)
;; (powerline-center-evil-theme)
(powerline-evil-vim-color-theme)
(setq powerline-evil-tag-style 'verbose)

;; Chinese-pyim Input Method
;; (require 'chinese-pyim)
;; (require 'chinese-pyim-basedict)
;; (chinese-pyim-basedict-enable)

;; Enable Great Dict
;; (require 'chinese-pyim-greatdict)
;; (chinese-pyim-greatdict-enable)

;; Config ace-window
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-dispatch-always t)

;; Config guide-key
(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
(guide-key-mode 1)  ; Enable guide-key-mode

;; Latex Config
;; Enable LaTeX-Preview-Pane
;; (latex-preview-pane-enable)

;; Setup AUCTex
;; AucTeX User Settings
(load-file "~/.emacs.d/auctex-user-settings")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex -synctex=1")
 '(TeX-expand-list
   (quote
    (("%(masterdir)"
      (lambda nil
	(file-truename
	 (TeX-master-directory))))
     ("%(a)"
      (lambda nil
	(expand-file-name
	 (buffer-file-name)))
      nil))))
 '(TeX-source-correlate-mode t)
 '(ansi-color-faces-vector
   [default bold default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-theme
   (quote
    ("98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "e56ee322c8907feab796a1fb808ceadaab5caba5494a50ee83a13091d5b1a10c" default)))
 '(custom-safe-themes
   (quote
    ("98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" default)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
