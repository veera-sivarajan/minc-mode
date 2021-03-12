(setq mymath-highlights
      '(("\\<\\([A-Z]*[a-z0-9_]+\\)\\([ \t]*\\)(" . (1 font-lock-function-name-face)) t))

(define-derived-mode mymath-mode text-mode "mymath"
  "major mode for editing mymath language code."
  (setq font-lock-defaults '(mymath-highlights)))
