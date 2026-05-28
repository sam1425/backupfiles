(require 'subr-x)

(defvar simpc-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; C/C++ style comments
	(modify-syntax-entry ?/ ". 124b" table)
	(modify-syntax-entry ?* ". 23" table)
	(modify-syntax-entry ?\n "> b" table)
    ;; Preprocessor stuff?
    (modify-syntax-entry ?# "." table)
    ;; Chars are the same as strings
    (modify-syntax-entry ?' "\"" table)
    ;; Treat <> as punctuation (needed to highlight C++ keywords
    ;; properly in template syntax)
    (modify-syntax-entry ?< "." table)
    (modify-syntax-entry ?> "." table)

    (modify-syntax-entry ?& "." table)
    (modify-syntax-entry ?% "." table)
    table))

(defun revo-types ()
  '("const" "let" "comp"))

(defun revo-keywords ()
  '("when" "and" "or" "do" "while" "for" "mean" "is" "end" "match" "use" "struct" "inspect" "suite" "test" "fn" "in" "spawn" "if" "else" "global" "user" "return"))

(defun simpc-font-lock-keywords ()
  (list
   `("# *\\(warn\\|error\\)" . font-lock-warning-face)
   `("# *[#a-zA-Z0-9_]+" . font-lock-preprocessor-face)
   `("# *include\\(?:_next\\)?\\s-+\\(\\(<\\|\"\\).*\\(>\\|\"\\)\\)" . (1 font-lock-string-face))
   `("\\(?:enum\\|struct\\)\\s-+\\([a-zA-Z0-9_]+\\)" . (1 font-lock-type-face))
