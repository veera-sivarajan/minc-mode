;; (defvar duotone-font-lock-defaults
;;   '((
;;      ("\\<\\([A-Z]*[a-z0-9_]+\\)\\([ \t]*\\)(" . font-lock-function-name-face)))
;;      ;; ("\"\\.\\*\\?" . font-lock-variable-name-face))
;;     ) 



;; (define-derived-mode duotone-mode prog-mode "C"
;;   "major mode for editing mymath language code."
;;   (setq font-lock-defaults '(duotone-font-lock-defaults))) 

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
  (defvar mydsl-tab-width 4 "Width of a tab for MYDSL mode") 
  
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
  
  (define-derived-mode mydsl-mode c-mode "MYDSL script"
    "MYDSL mode is a major mode for editing MYDSL files"
    ;; you again used quote when you had '((mydsl-hilite))
    ;; I just updated the variable to have the proper nesting (as noted above)
    ;; and use the value directly here
    (setq font-lock-defaults mydsl-font-lock-defaults)
  
    ;; when there's an override, use it
    ;; otherwise it gets the default value
    (when mydsl-tab-width
      (setq tab-width mydsl-tab-width))
  
    ;; for comments
    ;; overriding these vars gets you what (I think) you want
    ;; they're made buffer local when you set them
    ;; (setq comment-start "//")
    (font-lock-add-keywords nil '(("/\\*\\(?:[^*]\\|\\*[^/]\\)*\\*+/" . font-lock-comment-face))) 
    ;; (setq comment-end "")
  
    (modify-syntax-entry ?# "< b" mydsl-mode-syntax-table)
    (modify-syntax-entry ?\n "> b" mydsl-mode-syntax-table)
  
    ;; Note that there's no need to manually call `mydsl-mode-hook'; `define-derived-mode'
    ;; will define `mydsl-mode' to call it properly right before it exits
    )
  
  (provide 'mydsl-mode)
