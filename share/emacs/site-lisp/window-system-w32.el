;; for Windows

(provide 'window-system-w32)

;; setting fonts
(set-face-attribute 'default nil
                    :family "ＭＳ ゴシック"
                    :height 100)

(set-fontset-font "fontset-default"
                  'japanese-jisx0208
                  '("ＭＳ ゴシック" . "jisx0208-sjis"))


