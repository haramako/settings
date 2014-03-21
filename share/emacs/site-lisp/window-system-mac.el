;; for Mac OS X

(provide 'window-system-mac)

;; setting fonts
(set-face-attribute 'default nil
					:family "Ricty Diminished"
					:height 140)
(set-fontset-font "fontset-default"
                  'unicode
                  '("Ricty Diminished" . "iso10646-1"))
(set-fontset-font "fontset-default"
                  'japanese-jisx0208
                  '("Ricty Diminished" . "iso10646-1"))

(setq mac-command-modifier 'meta)
