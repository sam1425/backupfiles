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
(push '(vertical-scroll-bars) default-frame-alist)
;;(push '(mode-line-format . nil) default-frame-alist)

;(setq-default mode-line-format nil)

(show-paren-mode 0)
;;(tool-bar-mode 0)
;;(menu-bar-mode 0)
;;(scroll-bar-mode 0)

;; Supress builds on startup, builds ahead of time when installing packages
(setq native-comp-deferred-compilation nil)
;; Suppress warnings and errors during asynchronous native compilation
(setq native-comp-async-report-warnings-errors nil)

(setq comp-deferred-compilation nil)

(provide 'early-init)
