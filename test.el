(defvar minc-mode-syntax-table nil "Syntax table for `minc-mode'.")

(defvar minc-keywords
  '("auto" "break" "case" "char" "const" "continue" "default" "do" "double"
    "else" "enum" "extern" "float" "for" "goto" "if" "int" "long" "register"
    "return" "short" "signed" "sizeof" "static" "struct" "switch" "typedef"
    "union" "unsigned" "void" "volatile" "while")) 

(defface minc-keywords-face
  '((t :foreground "gray"
       ))
  "Keywords Face"
  :group 'minc-mode)  

(defface minc-function-face
  '((t :foreground "white"
       :weight ultra-bold
       :width extra-expanded
       ))
  "Function Face"
  :group 'minc-mode)  

(defface minc-comment-face
  '((t :foreground "#7a7272"
       :slat italic
       ))
  "Comment Face"
  :group 'minc-mode)


(defvar minc-keywords-face 'minc-keywords-face)
(defvar minc-function-face 'minc-function-face) 
(defvar minc-comment-face 'minc-comment-face) 

(defvar minc-font-lock-defaults
  `((
     ;; stuff between double quotes
     ;; ("\"\\.\\*\\?" . font-lock-string-face)
     ;; ; : , ; { } =>  @ $ = are all special elements
     ( "\\<\\([0-9]*\\.[0-9]+\\|[0-9]+\\)[df]?\\>" . font-lock-string-face) 
     ( ,(regexp-opt minc-keywords 'words) . minc-keywords-face) 
     ("\\<\\([A-Z]*[a-z0-9_]+\\)\\([ \t]*\\)(" . (1. minc-function-face))
     )))

(setq minc-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?\/ ". 12b" synTable)
        (modify-syntax-entry ?\n "> b" synTable)
        synTable)) 

(define-derived-mode minc-mode c-mode "C"
  "minc-mode is a major mode for editing language minc."

  (set-syntax-table minc-mode-syntax-table) 
  (setq font-lock-defaults minc-font-lock-defaults)
  (setq-local comment-start "//")
  (setq-local comment-start-skip "/\\*+[ \t]*")
  (setq-local comment-end "")
  (setq-local comment-end-skip "[ \t]*\\*+/")
  ;; actually no need, because our syntax table name is “minc-mode” + “-syntax-table”, so define-derived-mode will find it and set it
  )
