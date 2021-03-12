(defvar xpy-mode-syntax-table nil "Syntax table for `xpy-mode'.")

(setq xpy-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; python style comment: “# …”
        (modify-syntax-entry ?\/ "<" synTable)
        (modify-syntax-entry ?\n ">" synTable)
        synTable))

(define-derived-mode xpy-mode prog-mode "xpy"
  "xpy-mode is a major mode for editing language xpy."

  (setq font-lock-defaults (list nil nil))

  (set-syntax-table xpy-mode-syntax-table)
  ;; actually no need, because our syntax table name is “xpy-mode” + “-syntax-table”, so define-derived-mode will find it and set it
  )
