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
