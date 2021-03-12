(defvar xpy-mode-syntax-table nil "Syntax table for `xpy-mode'.")

(defvar xpy-keywords
  '("auto" "break" "case" "char" "const" "continue" "default" "do" "double"
    "else" "enum" "extern" "float" "for" "goto" "if" "int" "long" "register"
    "return" "short" "signed" "sizeof" "static" "struct" "switch" "typedef"
    "union" "unsigned" "void" "volatile" "while")) 

(defvar xpy-font-lock-defaults
  `((
     ;; stuff between double quotes
     ;; ("\"\\.\\*\\?" . font-lock-string-face)
     ;; ; : , ; { } =>  @ $ = are all special elements
     ( "\\<\\([0-9]*\\.[0-9]+\\|[0-9]+\\)[df]?\\>" . font-lock-string-face)
     ( ,(regexp-opt xpy-keywords 'words) . font-lock-keyword-face)
     ("\\<\\([A-Z]*[a-z0-9_]+\\)\\([ \t]*\\)(" . (1. font-lock-function-name-face))
     )))

(setq xpy-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?\/ ". 12b" synTable)
        (modify-syntax-entry ?\n "> b" synTable)
        synTable)) 

(define-derived-mode xpy-mode c-mode "xpy"
  "xpy-mode is a major mode for editing language xpy."

  (set-syntax-table xpy-mode-syntax-table) 
  (setq font-lock-defaults xpy-font-lock-defaults)
  (setq-local comment-start "//")
  (setq-local comment-start-skip "/\\*+[ \t]*")
  (setq-local comment-end "")
  (setq-local comment-end-skip "[ \t]*\\*+/")
  ;; actually no need, because our syntax table name is “xpy-mode” + “-syntax-table”, so define-derived-mode will find it and set it
  )
