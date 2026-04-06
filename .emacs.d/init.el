(require 'server)
(unless (server-running-p)
  (server-start))

;;; Appearance
(defun my-top-padding ()
  "Create a visual gap at the top of the window."
  (setq-default header-line-format " ")
  (set-face-attribute 'header-line nil
                      :background (face-background 'default nil t)
                      :foreground (face-background 'default nil t)
                      :height 200 ;; Adjust this number for more/less padding
                      :underline nil
                      :overline nil
                      :box nil))

;; Run after the theme loads to prevent 'Invalid face' errors
(add-hook 'window-setup-hook #'my-top-padding)

(defun rc/get-default-font ()
  (cond
   ;;((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "MonaspiceKr Nerd Font-12")
   ;;((eq system-type 'gnu/linux) "Iosevka-20")
   ;;;((eq system-type 'gnu/linux) "Comic Shanns Mono-20")
   ))
(add-to-list 'default-frame-alist '(background-color . "#111314"))

(setq custom-file "~/.emacs.custom.el")
(add-to-list 'load-path "~/.emacs.local/")
(load "~/.emacs.rc/rc.el")

;;; Theme: Gruvbox
(rc/require 'gruvbox-theme)
(load-theme 'gruvbox-dark-hard t)
 (custom-theme-set-faces
  'gruvbox-dark-hard
  `(default ((t (:background "#111314"))))
  `(line-number ((t (:foreground "#665c54" :background "#111314"))))
  `(line-number-current-line ((t (:foreground "#ebdbb2" :background "#111314" :weight bold))))
  `(mode-line ((t (:foreground "#ebdbb2" :background "#1d2021" :box nil))))
  `(mode-line-inactive ((t (:foreground "#928374" :background "#111314" :box nil)))))

(load "~/.emacs.rc/misc-rc.el")
(load "~/.emacs.rc/org-mode-rc.el")
;;;(load "~/.emacs.rc/autocommit-rc.el")

(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq use-dialog-box nil)
(setq window-combination-resize nil)
(setq even-window-sizes nil)
(setq display-buffer-alist
      '((".*"
         (display-buffer-reuse-window display-buffer-same-window))))
(setq window-resize-pixelwise t)
(setq frame-resize-pixelwise t)

;;config
(setq backup-directory-alist
      `(("." . "~/.emacs.d/filebackups/")))

(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-saves/" t)))

;;; ido
(rc/require 'smex 'ido-completing-read+)

(require 'ido-completing-read+)

(ido-mode 1)
(ido-everywhere 1)
(ido-ubiquitous-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(setq default-directory "~/")

(with-eval-after-load 'ido
  (define-key ido-common-completion-map (kbd "C-j") 'ido-next-match)
  (define-key ido-common-completion-map (kbd "C-k") 'ido-prev-match)

  (define-key ido-file-completion-map (kbd "C-l") 'ido-exit-minibuffer)
  (define-key ido-file-completion-map (kbd "C-h") 'ido-delete-backward-updir)

  (define-key minibuffer-local-map (kbd "C-j") 'next-line)
  (define-key minibuffer-local-map (kbd "C-k") 'previous-line)

  (define-key ido-completion-map (kbd "<escape>") 'keyboard-escape-quit)
  (define-key ido-common-completion-map (kbd "<escape>") 'keyboard-escape-quit))

;; (with-eval-after-load 'smex
;;   (define-key minibuffer-local-map (kbd "C-h") 'ido-prev-match)
;;   (define-key minibuffer-local-map (kbd "C-l") 'ido-next-match))

;;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;;; Paredit
(rc/require 'paredit)

(defun rc/turn-on-paredit ()
  (interactive)
  (paredit-mode 1))

(add-hook 'emacs-lisp-mode-hook  'rc/turn-on-paredit)
(add-hook 'clojure-mode-hook     'rc/turn-on-paredit)
(add-hook 'lisp-mode-hook        'rc/turn-on-paredit)
(add-hook 'common-lisp-mode-hook 'rc/turn-on-paredit)
(add-hook 'scheme-mode-hook      'rc/turn-on-paredit)
(add-hook 'racket-mode-hook      'rc/turn-on-paredit)

(rc/turn-on-paredit)

;;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-c C-j")
                            (quote eval-print-last-sexp))))
(add-to-list 'auto-mode-alist '("Cask" . emacs-lisp-mode))

;;; uxntal-mode
(rc/require 'uxntal-mode)

;;; Haskell mode
;;(rc/require 'haskell-mode)

;;(setq haskell-process-type 'cabal-new-repl)
;;(setq haskell-process-log t)

;;(add-hook 'haskell-mode-hook 'haskell-indent-mode)
;;(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
;;(add-hook 'haskell-mode-hook 'haskell-doc-mode)

(require 'basm-mode)

(require 'fasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm\\'" . fasm-mode))

(require 'porth-mode)

(require 'noq-mode)

(require 'jai-mode)

(require 'simpc-mode)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))
(add-to-list 'auto-mode-alist '("\\.[b]\\'" . simpc-mode))

(require 'umka-mode)

(require 'c3-mode)

(require 'gdscript-mode)

;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 0)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

;;(add-hook 'tuareg-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'simpc-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'fasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
:;(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)

;;; display-line-numbers-mode
(when (version<= "26.0.50" emacs-version)
  (setq-default display-line-numbers-width-start t)
  (setq-default display-line-numbers-grow-only t)
  (global-display-line-numbers-mode))

(add-hook 'text-scale-mode-hook
          (lambda ()
            (let ((step (expt text-scale-mode-step text-scale-mode-amount)))
              (set-face-attribute 'line-number nil :height step)
              (set-face-attribute 'line-number-current-line nil :height step))))

;;; magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
;;(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;;; multiple cursors
;;;(rc/require 'multiple-cursors)

;;;(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;;(global-set-key (kbd "C-n")         'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
;; (global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
;; (global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)


;;; dired
(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(setq-default dired-dwim-target t)
(setq dired-listing-switches "-alh")
(setq dired-mouse-drag-files t)

;;; helm
(rc/require 'helm 'helm-ls-git)

(setq helm-ff-transformer-show-only-basename nil)

(global-set-key (kbd "C-c h t") 'helm-cmd-t)
(global-set-key (kbd "C-c h g g") 'helm-git-grep)
(global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings)
(global-set-key (kbd "C-c h r") 'helm-recentf)


;;; yasnippet
(rc/require 'yasnippet)

(require 'yasnippet)
(setq yas/triggers-in-field nil)
(setq yas-snippet-dirs '("~/.emacs.snippets/"))

(yas-global-mode 1)

;;; word-wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; nxml
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.ant\\'" . nxml-mode))

;;; tramp
;;; http://stackoverflow.com/questions/13794433/how-to-disable-autosave-for-tramp-buffers-in-emacs
(setq tramp-auto-save-directory "/tmp")

;;; powershell
;;;(rc/require 'powershell)
;;;(add-to-list 'auto-mode-alist '("\\.ps1\\'" . powershell-mode))
;;;(add-to-list 'auto-mode-alist '("\\.psm1\\'" . powershell-mode))

;;; eldoc mode
(defun rc/turn-on-eldoc-mode ()
  (interactive)
  (eldoc-mode 1))

(add-hook 'emacs-lisp-mode-hook 'rc/turn-on-eldoc-mode)

;;; Company
(rc/require 'company)
(require 'company)

(global-company-mode)

(add-hook 'tuareg-mode-hook
          (lambda ()
            (interactive)
            (company-mode 0)))

;;; Typescript
(rc/require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.mts\\'" . typescript-mode))

;;; Tide
(rc/require 'tide)

(defun rc/turn-on-tide-and-flycheck ()  ;Flycheck is a dependency of tide
  (interactive)
  (tide-setup)
  (flycheck-mode 1))

(add-hook 'typescript-mode-hook 'rc/turn-on-tide-and-flycheck)

;;; Proof general
;;;(rc/require 'proof-general)
;; (add-hook 'coq-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "C-c C-q C-n")
;;                             (quote proof-assert-until-point-interactive))))
;LaTeX mode
;; (add-hook 'tex-mode-hook
;;           (lambda ()
;;             (interactive)
;;             (add-to-list 'tex-verbatim-environments "code")))

;; (setq font-latex-fontify-sectioning 'color)

;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;;; Ebisp
;;;(add-to-list 'auto-mode-alist '("\\.ebi\\'" . lisp-mode))

;;; Packages that don't require configuration
(rc/require
 'scala-mode
 'd-mode
 'yaml-mode
 'glsl-mode
 'tuareg
 'lua-mode
 'less-css-mode
 'graphviz-dot-mode
 'clojure-mode
 'cmake-mode
 'rust-mode
 'csharp-mode
 'nim-mode
 'jinja2-mode
 'markdown-mode
 'purescript-mode
 'nix-mode
 'dockerfile-mode
 'toml-mode
 'nginx-mode
 'kotlin-mode
 'go-mode
 'php-mode
 'racket-mode
 'qml-mode
 'ag
 'elpy
 'typescript-mode
 'rfc-mode
 'sml-mode
 ;;mine
 'evil
 'evil-goggles
 'evil-collection
 'compile
 )

(defun astyle-buffer (&optional justify)
  (interactive)
  (let ((saved-line-number (line-number-at-pos)))
    (shell-command-on-region
     (point-min)
     (point-max)
     "astyle --style=kr"
     nil
     t)
    (goto-line saved-line-number)))

(add-hook 'simpc-mode-hook
          (lambda ()
            (interactive)
            (setq-local fill-paragraph-function 'astyle-buffer)))

;;evil
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump nil)
(evil-mode 1)
(evil-collection-init )
(evil-goggles-mode)
(evil-define-key 'emacs 'global (kbd "M-SPC") #'execute-extended-command)
(setq select-enable-clipboard t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(global-evil-mc-mode 1)
(defun my-evil-mc-escape ()
  (interactive)
  (evil-mc-undo-all-cursors)
  (evil-ex-nohighlight)
  (keyboard-quit))

(with-eval-after-load 'evil
  (define-key evil-motion-state-map (kbd "C-b")   'compile)
  (define-key evil-normal-state-map (kbd "C-r")   'undo)
  (define-key evil-normal-state-map (kbd "&")     'evil-first-non-blank)
  (define-key evil-normal-state-map (kbd "^")     'evil-ex-substitute-repeat-simple)
  (define-key evil-normal-state-map (kbd "Y")     (kbd "y$"))
  (define-key evil-normal-state-map (kbd "C-n")   'evil-mc-make-and-goto-next-match)
  (define-key evil-normal-state-map (kbd "C-S-j") 'evil-mc-make-cursor-move-next-line)
  (define-key evil-normal-state-map (kbd "C-S-k") 'evil-mc-make-cursor-move-prev-line)
  (define-key evil-normal-state-map [escape]      'my-evil-mc-escape))
(setq compile-command "")

(defun toggle-mode-line ()
  (interactive)
  (setq mode-line-format
        (if mode-line-format nil (default-value 'mode-line-format)))
  (redraw-display))

(global-set-key (kbd "<f8>") 'toggle-mode-line)

;; pascalik.pas(24,44) Error: Can't evaluate constant expression
compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

(custom-set-faces
 '(line-number ((t (:height 1.0))))
 '(line-number-current-line ((t (:height 1.0))))
 )

(load-file custom-file)
