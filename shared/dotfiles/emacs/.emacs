; ==============================
;; Smadi0x86 Emacs Configuration
;; ==============================

;; 1. Allow upgrading built-in packages like 'seq'
(setq package-install-upgrade-built-in t)

;; 2. Setup Package Archives
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Only refresh if archives are missing
(unless (file-exists-p (expand-file-name "archives/melpa" package-user-dir))
  (package-refresh-contents))

;; 3. Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; 4. Custom file
(setq custom-file "~/.emacs.custom.el")
(load custom-file 'noerror)

;; 5. Load extra Lisp modules from ~/.emacs.local
(add-to-list
 'load-path "~/.emacs.local/")

;; -------------------------
;; UI
;; -------------------------
(add-hook 'emacs-startup-hook
          (lambda ()
            (set-frame-font "DejaVu Sans Mono-20" nil t)
            (toggle-frame-fullscreen)))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(column-number-mode t)
(show-paren-mode t)
(cua-mode t)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-`") 'toggle-frame-fullscreen)

(setq confirm-kill-emacs 'y-or-n-p)

;; -------------------------
;; Theme
;; -------------------------
(use-package gruber-darker-theme
  :config
  (load-theme 'gruber-darker t))

;; -------------------------
;; Magit
;; -------------------------
(use-package magit
  :bind (("C-x g" . magit-status))
  :config
)

;; -------------------------
;; Better M-x (smex)
;; -------------------------
(use-package smex
  :bind (("M-x" . smex)
         ("C-c C-c M-x" . execute-extended-command)))

;; -------------------------
;; IDO - Better switching
;; -------------------------
(ido-mode 1)
(ido-everywhere 1)

;; -------------------------
;; Dired File Manager
;; -------------------------
(require 'dired-x)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;; -------------------------
;; Snippets (Yasnippet)
;; -------------------------
(use-package yasnippet
  :config
  (setq yas/triggers-in-field nil
        yas-snippet-dirs '("~/.emacs.snippets/"))
  (yas-global-mode 1))

;; -------------------------
;; Custom keybinds
;; -------------------------

; Move a line up or down using alt+<p,n>
(use-package move-text
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

; Jump to relative lines using ctrl+c l <line number (- moves upwards)>
(defun jump-to-relative-line ()
  "Jump to a line relative to the current line, as shown by relative line numbers."
  (interactive)
  (let ((n (read-number "Jump to relative line: ")))
    (forward-line n)))
(global-set-key (kbd "C-c l") 'jump-to-relative-line)

;; -------------------------
;; TRAMP - Remote Files
;; -------------------------
(setq tramp-auto-save-directory "/tmp")

;; -------------------------
;; Language Modes
;; -------------------------
(use-package yaml-mode :defer t)
(use-package cmake-mode :defer t)
(use-package rust-mode :defer t)
(use-package csharp-mode :defer t)
(use-package nim-mode :defer t)
(use-package markdown-mode :defer t)
(use-package dockerfile-mode :defer t)
(use-package toml-mode :defer t)
(use-package nginx-mode :defer t)
(use-package go-mode :defer t)
(use-package php-mode :defer t)
(use-package typescript-mode :defer t)

;; -------------------------
;; Custom Modes
;; -------------------------
(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

;; -------------------------
;; Extra Compilation Regex
;; -------------------------
(require 'compile)

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

;; =========================
;; End of Config
;; =========================
