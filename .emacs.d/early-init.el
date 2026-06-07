;; -*- lexical-binding: t; -*-

;; --- Early Performance Tweaks ---

;; Set GC threshold high during startup, restore later
(setq gc-cons-threshold (* 128 1024 1024)) ; 128 MiB during startup
(setq gc-cons-percentage 0.5)

;; Defer file handler processing during startup
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Process communication tweaks (helps with LSP, sub-processes, terminals)
(setq read-process-output-max (* 2 1024 1024)) ; 2 MiB buffer
(setq process-adaptive-read-buffering nil)

;; --- User's Original Configuration Settings ---

;;(column-number-mode 1)
;;(fringe-mode 0)
(setq
 ring-bell-function 'ignore
 visible-bell t
 use-short-answers t
 vc-follow-symlinks t
 inhibit-startup-screen t
 inhibit-compacting-font-caches t
 create-lockfiles nil
 auto-mode-case-fold nil
 utf-translate-cjk-mode nil
 initial-scratch-message nil)

(defun display-startup-echo-area-message ()
  (message ""))

;;(setq initial-scratch-message ";; Welcome back, Sam.\n")
;; Maximize the Emacs frame on startup
(push '(fullscreen . maximized) initial-frame-alist)
(push '(fullscreen . maximized) default-frame-alist)

;; Prevent the glimpse of un-styled Emacs by disabling these UI elements early.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)
;; (push '(vertical-scroll-bars) default-frame-alist)

(setq-default mode-line-format nil)

(show-paren-mode 0)
;;(tool-bar-mode 0)
;;(menu-bar-mode 0)
;;(scroll-bar-mode 0)

;; Supress builds on startup, builds ahead of time when installing packages
(setq native-comp-deferred-compilation nil)
;; Suppress warnings and errors during asynchronous native compilation
(setq native-comp-async-report-warnings-errors nil)

;; --- Restore Settings After Startup ---
(add-hook 'emacs-startup-hook
          (lambda ()
            ;; Restore GC to a value suitable for interactive use / LSP
            (setq gc-cons-threshold (* 16 1024 1024)) ; 16 MiB
            (setq gc-cons-percentage 0.1)
            ;; Restore file name handler alist
            (setq file-name-handler-alist file-name-handler-alist-original)
            (message "GC threshold and file handlers restored.")))

(provide 'early-init)
