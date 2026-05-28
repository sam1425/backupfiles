(require 'generic-x)

(define-generic-mode revo-mode
  ;; 1. COMMENT-LIST: Line comments start with '#'
  '("#")
  
  ;; 2. KEYWORD-LIST: Core control flow and definitions
  '("const" "fn" "match" "when" "and" "or" "do" "end" "test" "use" "struct" "while" "for" "mean" "inspect" "is" "let" "global")
  
  ;; 3. FONT-LOCK-LIST: Aggressive, multi-colored regex rules
  '(
    ;; Atoms / Symbols (e.g., :true, :ok, :err) -> Cyan/Teal
    (":[a-zA-Z_0-9!]+" . font-lock-constant-face)
    
    ;; Numbers (integers, decimals, ranges like 0..10) -> Purple/Pink
    ("\\b[0-9]+\\b" . font-lock-number-face)
    
    ;; Pipe Operator ( |> ) -> Highly visible bright warning color
    ("|>" . font-lock-warning-face)
    
    ;; Structural Metamethods & Decorators (e.g., @defer, @doc) -> Orange/Gold
    ("@[a-zA-Z_0-9]+" . font-lock-variable-name-face)
    
    ;; Double-quoted strings -> Green
    ("\"\\([^\"\\]\\|\\\\.\\)*\"" . font-lock-string-face)
    
    ;; Single-quoted strings/chars -> Light Green / Alternate String
    ("'\\([^'\\]\\|\\\\.\\)*'" . font-lock-string-face)
    
    ;; Function invocations (e.g., double(2), print(i)) -> Blue
    ;; The final "\\(" ensures Emacs reads the open parenthesis as a literal character match
    ("\\b\\([a-zA-Z_][a-zA-Z0-9_]*\\??\\)\\(" 1 font-lock-function-name-face)
    
    ;; Standard Operators (+, -, *, /, =, ==, <, >, |, ::) -> Subtle grey/red accent
    ("[-+*/=<>|:]" . font-lock-builtin-face)
    )
    
  ;; 4. AUTO-MODE-LIST: Bind to .revo files automatically
  '("\\.revo\\'")
  
  ;; 5. FUNCTION-LIST: Extra setup functions
  nil
  
  ;; 6. DOCSTRING
  "A highly colorful generic major mode for editing Revo source files.")

(provide 'revo-mode)
