;; for Darwin
(provide 'system-type-darwin)

;; Mac-OS-X上でchromeのリロードを行う
(defun chrome-reload ()
  "Reload chrome"
  (interactive)
  (shell-command "~/.setting/bin/chrome-reload"))

(global-set-key [C-return] 'chrome-reload)
