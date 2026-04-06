<<<<<<< HEAD
;; -*- lexical-binding: t; -*-

;; --- Initialize Package Manager and use-package ---
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(package-initialize)

;; Bootstrap use-package (built-in in Emacs 29+, but ensures compatibility)
(require 'use-package)
(setq use-package-always-ensure t)

;; --- Backward Compatibility Wrappers using use-package ---
(defun rc/require-one-package (package)
  "Install and load PACKAGE using use-package."
  (eval `(use-package ,package :ensure t)))

(defun rc/require (&rest packages)
  "Install and load PACKAGES using use-package."
  (dolist (package packages)
    (rc/require-one-package package)))

(defun rc/require-theme (theme)
  "Install and load THEME package, then activate theme."
  (let ((theme-package (->> theme
                            (symbol-name)
                            (funcall (-flip #'concat) "-theme")
                            (intern))))
    (eval `(use-package ,theme-package :ensure t))
    (load-theme theme t)))

;; Core helper libraries
(use-package dash :ensure t)
(use-package dash-functional :ensure t)
||||||| (empty tree)
=======
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(defvar rc/package-contents-refreshed nil)

(defun rc/package-refresh-contents-once ()
  (when (not rc/package-contents-refreshed)
    (setq rc/package-contents-refreshed t)
    (package-refresh-contents)))

(defun rc/require-one-package (package)
  (when (not (package-installed-p package))
    (rc/package-refresh-contents-once)
    (package-install package)))

(defun rc/require (&rest packages)
  (dolist (package packages)
    (rc/require-one-package package)))

(defun rc/require-theme (theme)
  (let ((theme-package (->> theme
                            (symbol-name)
                            (funcall (-flip #'concat) "-theme")
                            (intern))))
    (rc/require theme-package)
    (load-theme theme t)))

(rc/require 'dash)
(require 'dash)

(rc/require 'dash-functional)
(require 'dash-functional)
>>>>>>> 3fe26ac (adding configs)
