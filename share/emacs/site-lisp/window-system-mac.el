;; for Mac OS X

(provide 'window-system-mac)

;; setting fonts
(set-fontset-font "fontset-default"
                  'japanese-jisx0208
                  '("Ricty" . "iso10646-*"))

(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 140)

(setq mac-command-modifier 'meta)
