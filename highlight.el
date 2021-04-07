(defvar minc-mode-syntax-table nil "Syntax table for `minc-mode'.")

;; specify all 32 keywords in C 
(defvar minc-keywords
  '("auto" "break" "case" "char" "const" "continue" "default" "do" "double"
    "else" "enum" "extern" "float" "for" "goto" "if" "int" "long" "register"
    "return" "short" "signed" "sizeof" "static" "struct" "switch" "typedef"
    "union" "unsigned" "void" "volatile" "while")) 

;; custom face for keywords
(defface minc-keywords-face
  '((t :foreground "gray"
       ))
  "Keywords Face"
  :group 'minc-mode)  

;; custom face for function headers and calls
(defface minc-function-face
  '((t :foreground "white"
       :weight ultra-bold
       :width extra-expanded
       ))
  "Function Face"
  :group 'minc-mode)  

(defvar minc-keywords-face 'minc-keywords-face)
(defvar minc-function-face 'minc-function-face) 

;; match font faces with regex
(defvar minc-font-lock-defaults
  `((
     ;; regex to match all digits
     ( "\\<\\([0-9]*\\.[0-9]+\\|[0-9]+\\)[df]?\\>" . font-lock-string-face) 
     ;; regex to match all 32 C keywords 
     ( ,(regexp-opt minc-keywords 'words) . minc-keywords-face) 
     ;; regex for matching words followed by "("
     ("\\<\\([A-Z]*[a-z0-9_]+\\)\\([ \t]*\\)(" . (1. minc-function-face))
     )))

(setq minc-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        (c-populate-syntax-table synTable)
        synTable)) 

(define-derived-mode minc-mode c-mode "C"
  "Minimalistic syntax highlight mode for C programming"

  (set-syntax-table minc-mode-syntax-table) 
  (setq font-lock-defaults minc-font-lock-defaults)
  (setq-local comment-start "//")
  (setq-local comment-end "")
  )

; add symbol name to features list
(provide 'minc-mode) 
