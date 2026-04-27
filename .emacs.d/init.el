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
(load-file custom-file)

(add-to-list 'load-path "~/.emacs.local/")
(load "~/.emacs.rc/rc.el")

(require 'server)

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

(add-hook 'ido-setup-hook
  (lambda ()
    (define-key ido-file-completion-map (kbd "C-o") 'ido-enter-dired)
    (define-key ido-completion-map (kbd "C-h") nil)
    (define-key ido-completion-map (kbd "C-l") nil)
    (define-key ido-completion-map (kbd "M-h") nil)
    (define-key ido-completion-map (kbd "M-l") nil)
    (define-key ido-completion-map (kbd "C-l") 'ido-next-match)
    (define-key ido-completion-map (kbd "C-h") 'ido-prev-match)
    (define-key ido-completion-map (kbd "M-l") 'ido-next-match)
    (define-key ido-completion-map (kbd "M-h") 'ido-prev-match)
    (define-key ido-completion-map (kbd "C-j") 'ido-exit-minibuffer)
    (define-key ido-completion-map (kbd "C-k") 'ido-delete-backward-updir)
    (define-key ido-completion-map (kbd "<escape>") 'keyboard-escape-quit)))

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
;;(rc/require 'uxntal-mode)

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
;;(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'fasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
;;(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)

;;; display-line-numbers-mode
(when (version<= "26.0.50" emacs-version)
  (setq display-line-numbers-type 'relative)
  (setq-default display-line-numbers-width-start t)
  (setq-default display-line-numbers-grow-only t)
  (global-display-line-numbers-mode))

;;; Toggle function
(defun toggle-relative-numbers ()
  (interactive)
  (if (eq display-line-numbers 'relative)
      (setq display-line-numbers t)
    (setq display-line-numbers 'relative)))

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

;; multiple cursors
;;;(rc/require 'multiple-cursors)

;;;(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;;(global-set-key (kbd "C-n")         'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
;; (global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
;; (global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)


;;; helm
;; (rc/require 'helm 'helm-ls-git)

;; (setq helm-ff-transformer-show-only-basename nil)

;; (global-set-key (kbd "C-c h t") 'helm-cmd-t)
;; (global-set-key (kbd "C-c h g g") 'helm-git-grep)
;; (global-set-key (kbd "C-c h g l") 'helm-ls-git-ls)
;; (global-set-key (kbd "C-c h f") 'helm-find)
;; (global-set-key (kbd "C-c h a") 'helm-org-agenda-files-headings)
;; (global-set-key (kbd "C-c h r") 'helm-recentf)


;;; yasnippet
;; (rc/require 'yasnippet)

;; (require 'yasnippet)
;; (setq yas/triggers-in-field nil)
;; (setq yas-snippet-dirs '("~/.emacs.snippets/"))

;; (yas-global-mode 1)

;;; word-wrap
(defun rc/enable-word-wrap ()
  (interactive)
  (toggle-word-wrap 1))

(add-hook 'markdown-mode-hook 'rc/enable-word-wrap)

;;; nxml
;; (add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))
;; (add-to-list 'auto-mode-alist '("\\.xsd\\'" . nxml-mode))
;; (add-to-list 'auto-mode-alist '("\\.ant\\'" . nxml-mode))

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


(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-j") 'company-select-next)
  (define-key company-active-map (kbd "C-k") 'company-select-previous))


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

;;; Ebisp
;;;(add-to-list 'auto-mode-alist '("\\.ebi\\'" . lisp-mode))

(setq evil-want-keybinding nil)
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
 'dirvish
 'nerd-icons
 ;;mine
 'evil
 'evil-goggles
 'evil-collection
 'evil-multiedit
 'evil-surround
 'evil-visualstar
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
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump nil)
(setq evil-undo-system 'undo-redo)
(setq select-enable-clipboard t)

(setq evil-undo-system 'undo-redo)
(setq select-enable-clipboard t)
;(setq evil-collection-setup-minibuffer t)

(evil-mode 1)
(global-evil-surround-mode 1)
(global-evil-visualstar-mode 1)
(global-evil-mc-mode 1)
(evil-collection-init )
(evil-goggles-mode)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(defun my/escape-or-mc-undo ()
  (interactive)
  (if (evil-mc-has-cursors-p)
      (progn
        (evil-mc-undo-all-cursors)
        (evil-ex-nohighlight)
        (keyboard-quit))
    (evil-force-normal-state)))

(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "M-j") 'move-text-down)
  (define-key evil-normal-state-map (kbd "M-k") 'move-text-up)
  (define-key evil-normal-state-map (kbd "M-j") 'move-text-down)
  (define-key evil-normal-state-map (kbd "M-k") 'move-text-up)
  (define-key evil-motion-state-map (kbd "C-b")   'my/compile)
  (define-key evil-normal-state-map (kbd "&")     'evil-first-non-blank)
  (define-key evil-normal-state-map (kbd "^")     'evil-ex-substitute-repeat-simple)
  (define-key evil-normal-state-map (kbd "Y")     (kbd "y$"))
  (define-key evil-normal-state-map (kbd "C-S-j") 'evil-mc-make-cursor-move-next-line)
  (define-key evil-normal-state-map (kbd "C-S-k") 'evil-mc-make-cursor-move-prev-line)
  ;;multicursors
  (define-key evil-normal-state-map (kbd "C-n")  'evil-multiedit-match-and-next)

  )

;; evil-multiedit
(require 'evil-multiedit)
;(evil-multiedit-default-keybinds)
(with-eval-after-load 'evil-multiedit
   (evil-define-key '(normal visual) evil-multiedit-mode-map
    (kbd "C-a") #'evil-multiedit-match-all
    (kbd "C-n") #'evil-multiedit-match-and-next
    (kbd "C-S-n") #'evil-multiedit-match-and-prev
    (kbd "*")   #'evil-multiedit-next
    (kbd "#")   #'evil-multiedit-prev
    (kbd "<escape>") #'evil-multiedit-abort
    ))

;; evil-mc
;; (evil-define-key '(normal visual) 'global
;;   "gzm" #'evil-mc-make-all-cursors
;;   "gzu" #'evil-mc-undo-all-cursors
;;   "gzz" #'+evil/mc-toggle-cursors
;;   "gzc" #'+evil/mc-make-cursor-here
;;   "gzn" #'evil-mc-make-and-goto-next-cursor
;;   "gzp" #'evil-mc-make-and-goto-prev-cursor
;;   "gzN" #'evil-mc-make-and-goto-last-cursor
;;   "gzP" #'evil-mc-make-and-goto-first-cursor)
(with-eval-after-load 'evil-mc
   (evil-define-key '(normal visual) evil-mc-key-map
    ;(kbd "C-n") #'evil-mc-make-and-goto-next-cursor
    ;(kbd "C-n") #'evil-mc-make-and-goto-last-cursor
    ;(kbd "C-n") #'evil-mc-make-and-goto-next-match
    ;(kbd "C-N") #'evil-mc-make-and-goto-first-cursor
    (kbd "<escape>") #'my/escape-or-mc-undo
    )
 )


(rc/require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")

(evil-leader/set-key
  ;; files
  "ff" 'find-file
  "fs" 'save-buffer
  ;; buffers
  "bb" 'switch-to-buffer
  "bk" 'kill-buffer
  "bd" 'kill-current-buffer
  ;; magit
  "ms" 'magit-status
  "ml" 'magit-log
  ;; dired
  "dd" 'dired
  ;; compile
  "cc" 'compile
  ;; misc
  ";" 'smex
  "w" 'save-buffer)

;;; Dired
(require 'dired)
(require 'dired-x)
;;(require 'dired+)
;;(require 'dirvish)

(require 'dired-rainbow)
(with-eval-after-load 'dired-rainbow

  ;; --- files ---
  (dired-rainbow-define media "#d65d0e"        ; dark orange — warm/entertainment
    ("mp3" "mp4" "mkv" "webm" "flac" "ogg" "wav" "avi" "mov" "wmv"))

  (dired-rainbow-define image "#98971a"        ; muted green — natural/visual
    ("jpg" "jpeg" "png" "gif" "svg" "webp" "bmp" "ico" "tiff"))

  (dired-rainbow-define archive "#b16286"      ; muted purple — compressed/sealed
    ("zip" "tar" "gz" "bz2" "xz" "zst" "7z" "rar" "deb" "rpm"))

  (dired-rainbow-define document "#a89984"     ; warm gray — prose/text
    ("pdf" "doc" "docx" "odt" "epub" "md" "rst" "txt" "org"))

  ;; --- systems ---
  (dired-rainbow-define prog-systems "#5fd7ff" ; bright orange — hot/metal
    ("c" "h" "cpp" "hpp" "cc" "hh" "cxx" "hxx" "s" "asm"))

  (dired-rainbow-define prog-rust "#cc241d"    ; dark red — close to Ruby but subdued
    ("rs"))

  (dired-rainbow-define prog-ruby "#fb4934"    ; bright red — Ruby's own
    ("rb" "rbs" "rake" "gemspec"))

  ;; --- managed/compiled ---
  (dired-rainbow-define prog-jvm "#fabd2f"     ; bright yellow — enterprise/verbose
    ("java" "class" "jar" "kt" "kts" "scala"))

  (dired-rainbow-define prog-go "#8ec07c"      ; bright aqua — Go's clean aesthetic
    ("go" "mod" "sum"))

  ;; --- scripting ---
  (dired-rainbow-define prog-scripted "#b8bb26" ; bright green — alive/dynamic
    ("py" "pl" "lua" "sh" "bash" "zsh" "fish" "awk" "sed"))

  ;; --- web ---
  (dired-rainbow-define prog-web "#83a598"     ; bright blue — calm/frontend
    ("html" "htm" "css" "scss" "sass" "less"
     "js" "mjs" "cjs" "ts" "tsx" "jsx" "vue" "svelte"))

  ;; --- lisp family ---
  (dired-rainbow-define prog-lisp "#d3869b"    ; bright purple — lisp is special
    ("el" "elc" "lisp" "clj" "cljs" "cljc" "scm" "rkt" "hy"))

  ;; --- functional ---
  (dired-rainbow-define prog-functional "#689d6a" ; muted aqua — cool/mathematical
    ("hs" "lhs" "ml" "mli" "fs" "fsx" "elm" "ex" "exs" "erl" "hrl"))

  ;; --- config/data ---
  (dired-rainbow-define prog-config "#d79921"  ; yellow — needs attention
    ("json" "jsonc" "toml" "yaml" "yml" "ini" "cfg" "conf" "env" "nix" "lock"))

  (dired-rainbow-define prog-data "#458588"    ; blue — structured/deep
    ("csv" "tsv" "sql" "db" "sqlite" "parquet"))

  ;; --- build infrastructure ---
  (dired-rainbow-define prog-build "#928374"   ; gray — plumbing
    ("Makefile" "makefile" "GNUmakefile" "CMakeLists.txt"
     "Dockerfile" "docker-compose.yml" "Cargo.toml"
     "package.json" "go.mod" "build.gradle" "pom.xml" "meson.build"))

  (dired-rainbow-define-chmod executable "#b8bb26" "-.*x.*"))

(setq dired-omit-files "^\\.[^.].*")
(setq dired-listing-switches "-lAhvG --group-directories-first")
(setq dired-kill-when-opening-new-dired-buffer t)

(add-hook 'dired-mode-hook
          (lambda ()
            ;(message "HOOK WORKED")
            (dired-hide-details-mode 1)
            (dired-omit-mode 1)))

(defvar my/dired-cut-files nil
  "Files marked for cut (move) in dired.")

(defun my/dired-cut ()
  "Mark files for cut (move)."
  (interactive)
  (setq my/dired-cut-files (dired-get-marked-files))
  (message "Cut %d file(s)" (length my/dired-cut-files)))

(defun my/dired-paste ()
  "Paste (move or copy) files into current directory."
  (interactive)
  (if my/dired-cut-files
      (progn
        (dolist (file my/dired-cut-files)
          (dired-rename-file file (expand-file-name
                                   (file-name-nondirectory file)
                                   (dired-current-directory)) nil))
        (setq my/dired-cut-files nil)
        (revert-buffer)
        (message "Pasted files"))
    (dired-do-copy)))

(with-eval-after-load 'wdired
  (setq wdired-allow-to-change-permissions t)
  (evil-define-key 'normal wdired-mode-map
    (kbd "ZZ")    #'wdired-finish-edit
    (kbd "q")     #'wdired-finish-edit
    [escape]      #'wdired-abort-changes))


(with-eval-after-load 'dired
  (set-face-attribute 'dired-directory nil
                      :foreground "#328374"
                      :weight 'bold)

  (set-face-attribute 'dired-symlink nil
                      :foreground "#e5e5e5"
                      :slant 'italic)

  (set-face-attribute 'dired-ignored nil
                      :foreground "#626262")
  ;keybinds
  ;;emacs keybindins
  ;; (define-key dired-mode-map (kbd "l") #'dired-find-file)
  ;; (define-key dired-mode-map (kbd "h") #'dired-up-directory)
  ;; (define-key dired-mode-map (kbd "C-d") #'dired-hide-details-mode)
  ;; (define-key dired-mode-map (kbd "C-.") #'dired-omit-mode)
  ;; (define-key dired-mode-map (kbd "C-c h") #'dired-omit-mode)
  ;; (define-key dired-mode-map (kbd "q") #'quit-window)
  ;; (evil-define-key 'emacs 'global (kbd "M-SPC") #'execute-extended-command)
  ;; (global-set-key (kbd "C-c p d") #'projectile-dired)
  (evil-define-key 'normal dired-mode-map
    ;; navigation
    (kbd "h")   #'dired-up-directory
    (kbd "l")   #'dired-find-file
    ;; selection
    (kbd "SPC") #'dired-mark               ; mark/unmark single file
    (kbd "v")   #'dired-mark               ; also on v like visual
    (kbd "V")   #'dired-unmark-all-marks   ; clear all marks
    (kbd "u")   #'dired-undo               ; unmark under cursor
    ;; file ops — yazi style
    (kbd "x")   #'my/dired-cut
    (kbd "y")   #'dired-do-copy            ; yank/copy
    (kbd "p")   #'my/dired-paste
    (kbd "d")   #'dired-do-delete          ; delete marked or file at point
    (kbd "r")   #'wdired-change-to-wdired-mode
    ;(kbd "r")   #'dired-do-rename          ; rename
    (kbd "R")   #'dired-do-rename          ; alias
    ;; toggles
    (kbd "C-h") #'dired-hide-details-mode
    (kbd "C-.") #'dired-omit-mode
    (kbd "q")   #'quit-window
    ;; refresh
    (kbd "gr")  #'revert-buffer)
  )


(defun my/title-case-buffer ()
  "Capitalize the first letter of every word in the buffer, similar to :Title in Vim."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\<\\(\\w\\)\\(\\w*\\)\\>" nil t)
      (replace-match (concat (upcase (match-string 1))
                             (downcase (match-string 2)))))))

(evil-ex-define-cmd "Uppercasefile" 'my/title-case-buffer)

(defun toggle-mode-line ()
  (interactive)
  (setq mode-line-format
        (if mode-line-format nil (default-value 'mode-line-format)))
  (redraw-display))

(global-set-key (kbd "<f6>") 'toggle-mode-line)

(defun my/compile-toggle-comint ()
  (interactive)
  (if (derived-mode-p 'comint-mode)
      (compilation-mode)
    (comint-mode)))

;; Compile config
(with-eval-after-load 'compile
  (define-key compilation-mode-map (kbd "C-t") 'my/compile-toggle-comint)
  (define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit))

(defun my/compile (command &optional comint)
  (interactive
   (list (read-string "Command: " compile-command)))
  (compile command comint))



;; pascalik.pas(24,44) Error: Can't evaluate constant expression
;compilation-error-regexp-alist-alist

(add-to-list 'compilation-error-regexp-alist
             '("\\([a-zA-Z0-9\\.]+\\)(\\([0-9]+\\)\\(,\\([0-9]+\\)\\)?) \\(Warning:\\)?"
               1 2 (4) (5)))

(custom-set-faces
 '(line-number ((t (:height 1.0))))
 '(line-number-current-line ((t (:height 1.0))))
 )
