;; for Mac OS X

(provide 'window-system-mac)

;; setting fonts
(set-fontset-font "fontset-default"
                  'japanese-jisx0208
                  '("Ricty" . "iso10646-*"))

(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 140)

(set-face-foreground 'font-lock-comment-face "red")     ; mac上でコメントが赤くならないのを修正
