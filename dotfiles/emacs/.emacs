;; ==============================
;; Smadi0x86 Emacs Configuration
;; ==============================

;; -------------------------
;; Custom Paths and Files
;; -------------------------

(setq custom-file "~/.emacs.custom.el")      ; Store UI customizations separately
(add-to-list 'load-path "~/.emacs.local/")   ; Custom lisp module path

;; -------------------------
;; Initialize package system
;; -------------------------
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")
        ("org"   . "https://orgmode.org/elpa/")))
(package-initialize)

;; -------------------------
;; Load modular configuration
;; -------------------------
(load-file "~/.emacs.rc/rc.el")              ; Load core config
(load-file "~/.emacs.rc/misc-rc.el")         ; Load misc config
(load "~/.emacs.rc/autocommit-rc.el")        ; Load autocommit config
(load-file custom-file)                      ; Load theme, variables, etc.

;; -------------------------
;; Basic UI Settings
;; -------------------------

(add-to-list 'default-frame-alist '(fullscreen . fullboth))
(add-to-list 'default-frame-alist `(font . "DejaVu Sans Mono-20"))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(global-display-line-numbers-mode)
(cua-mode t)
(column-number-mode 1)
(show-paren-mode 1)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-`") 'toggle-frame-fullscreen)

;; -------------------------
;; Magit (Git Interface)
;; -------------------------

(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;; -------------------------
;; Theme
;; -------------------------

(rc/require-theme 'gruber-darker)

;; -------------------------
;; Command Execution (M-x)
;; -------------------------

(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; -------------------------
;; Ido (Better File/Buffer Switching)
;; -------------------------

(ido-mode 1)
(ido-everywhere 1)

;; -------------------------
;; Dired (File Manager)
;; -------------------------

(require 'dired-x)

(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;; -------------------------
;; YASnippet (Snippets)
;; -------------------------

(rc/require 'yasnippet)
(require 'yasnippet)

(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))
(yas-global-mode 1)

;; -------------------------
;; Move Text (Up/Down)
;; -------------------------

(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;; -------------------------
;; TRAMP (Remote Editing)
;; -------------------------

(setq tramp-auto-save-directory "/tmp")

;; -------------------------
;; Modes and Language Support
;; -------------------------

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

(rc/require
 'yaml-mode
 'cmake-mode
 'rust-mode
 'csharp-mode
 'nim-mode
 'markdown-mode
 'dockerfile-mode
 'toml-mode
 'nginx-mode
 'go-mode
 'php-mode
 'typescript-mode)

;; -------------------------
;; Extra Compilation Patterns
;; -------------------------

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

;; =========================
;; End of Config
;; =========================
