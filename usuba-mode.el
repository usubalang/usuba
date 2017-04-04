(defvar usuba-mode-hook nil)


(defvar usuba-mode-map
  (make-keymap)
  "Keymap for usuba major mode")

(add-to-list 'auto-mode-alist '("\\.ua\\'" . usuba-mode))

(defconst usuba-font-lock-keywords
  (list
   '("\\<\\(forall\\|in\\|let\\|node\\|perm\\|returns\\|t\\(?:able\\|el\\)\\|vars\\)\\>"
     . font-lock-keyword-face)
   '("\\<\\(u[0-9]+\\|bool\\|nat\\)\\>" . font-lock-type-face)
   '("\\<[a-z_][A-Za-z0-9_]*\\>" . font-lock-variable-name-face)
   '("\\<[0-9]+\\>" . font-lock-constant-face)
   '("\\<\\([&|^]=\\|[!&|~^]\\)\\>" . font-lock-builtin-face)))

(defvar usuba-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?_ "w" st)
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    st)
  "Syntax table for usuba-mode")

(defun usuba-mode ()
  "Major mode for editing Usuba programs"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table usuba-mode-syntax-table)
  (use-local-map usuba-mode-map)
  (set (make-local-variable 'font-lock-defaults) '(usuba-font-lock-keywords))
  (setq major-mode 'usuba-mode)
  (setq mode-name "usuba")
  (run-hooks 'usuba-mode-hook))

(provide 'usuba-mode)
