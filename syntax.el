(defvar mydsl-mode-syntax-table nil "Syntax table")

(setq mydsl-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        (modify-syntax-entry ?\/ "<" synTable)
        (modify-syntax-entry ?\n ">" synTable) 
        synTable))

;; (provide 'duoton-mode) 
(defvar mydsl-constants
  '("reservedword1"
    "reservedword2"))

(defvar mydsl-keywords
  '("auto" "break" "case" "char" "const" "continue" "default" "do" "double"
    "else" "enum" "extern" "float" "for" "goto" "if" "int" "long" "register"
    "return" "short" "signed" "sizeof" "static" "struct" "switch" "typedef"
    "union" "unsigned" "void" "volatile" "while")) 

;; I'd probably put in a default that you want, as opposed to nil
(defvar mydsl-tab-width nil "Width of a tab for MYDSL mode") 
(setq mydsl-tab-width 4) 

;; Two small edits.
;; First is to put an extra set of parens () around the list
;; which is the format that font-lock-defaults wants
;; Second, you used ' (quote) at the outermost level where you wanted ` (backquote)
;; you were very close
(defvar mydsl-font-lock-defaults
  `((
     ;; stuff between double quotes
     ;; ("\"\\.\\*\\?" . font-lock-string-face)
     ;; ; : , ; { } =>  @ $ = are all special elements
     ( ,(regexp-opt mydsl-keywords 'words) . font-lock-builtin-face)
     ("\\<\\([A-Z]*[a-z0-9_]+\\)\\([ \t]*\\)(" . (1. font-lock-function-name-face))
     ( ,(regexp-opt mydsl-constants 'words) . font-lock-constant-face)
     ) oladfadf))

(define-derived-mode mydsl-mode prog-mode "MYDSL script"
  "MYDSL mode is a major mode for editing MYDSL files"
  ;; you again used quote when you had '((mydsl-hilite))
  ;; I just updated the variable to have the proper nesting (as noted above)
  ;; and use the value directly here
  (setq font-lock-defaults mydsl-font-lock-defaults)
  
  ;; when there's an override, use it
  ;; otherwise it gets the default value
  (when mydsl-tab-width
    (setq tab-width mydsl-tab-width))
  
  (set-syntax-table my-mode-syntax-table)
  (setq-local comment-start "/*")
  (setq-local comment-start-skip "/\\*+[ \t]*")
  (setq-local comment-end "*/")
  (setq-local comment-end-skip "[ \t]*\\*+/")
  ;; for comments
  ;; overriding these vars gets you what (I think) you want
  ;; they're made buffer local when you set them
  ;; (setq comment-start "/*")
  ;; (font-lock-add-keywords nil '(("/\\*\\(?:[^*]\\|\\*[^/]\\)*\\*+/" . font-lock-comment-face))) 
  ;; (setq comment-end "*/")
  
  ;; for comments like / ... /

  ;; for comments like /* ...  */
  (modify-syntax-entry ?\/ ". 14" mydsl-mode-syntax-table)
  (modify-syntax-entry ?* ". 23" mydsl-mode-syntax-table)
  
  ;; Note that there's no need to manually call `mydsl-mode-hook'; `define-derived-mode'
  ;; will define `mydsl-mode' to call it properly right before it exits
  )

(provide 'mydsl-mode)
