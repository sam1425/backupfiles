;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "evil-multiedit" "20211121.1650"
  "Multiple cursors for evil-mode."
  '((emacs  "25.1")
    (evil   "1.14.0")
    (iedit  "0.9.9")
    (cl-lib "0.5"))
  :url "https://github.com/hlissner/evil-multiedit"
  :commit "23b53bc8743fb82a8854ba907b1d277374c93a79"
  :revdesc "23b53bc8743f"
  :keywords '("multiple cursors" "editing" "iedit")
  :authors '(("Henrik Lissner" . "http://github/hlissner"))
  :maintainers '(("Henrik Lissner" . "contact@henrik.io")))
