;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

(if (featurep 'meadow)
    (progn 
      ;; Settings for meadow. ( on Windows )
      ;; ;;; TrueType フォント設定
      (w32-add-font
       "private-fontset" 
      '((spec
          ((:char-spec ascii :height 120)
           strict
           (w32-logfont "ＭＳ ゴシック" 0 -15 400 0 nil nil nil 0 1 3 49))
          ((:char-spec ascii :height 120 :weight bold)
           strict
           (w32-logfont "ＭＳ ゴシック" 0 -15 700 0 nil nil nil 0 1 3 49))
          ((:char-spec ascii :height 120 :slant italic)
           strict
           (w32-logfont "ＭＳ ゴシック" 0 -15 400 0   t nil nil 0 1 3 49))
          ((:char-spec ascii :height 120 :weight bold :slant italic)
           strict
           (w32-logfont "ＭＳ ゴシック" 0 -15 700 0   t nil nil 0 1 3 49))
          ((:char-spec japanese-jisx0208 :height 120)
           strict
           (w32-logfont "ＭＳ ゴシック" 0 -13 400 0 nil nil nil 128 1 3 49))
          ((:char-spec japanese-jisx0208 :height 120 :weight bold)
           strict
           (w32-logfont "ＭＳ ゴシック" 0 -13 700 0 nil nil nil 128 1 3 49)
           ((spacing . -1)))
          ((:char-spec japanese-jisx0208 :height 120 :slant italic)
           strict
           (w32-logfont "ＭＳ ゴシック" 0 -13 400 0   t nil nil 128 1 3 49))
          ((:char-spec japanese-jisx0208 :height 120 :weight bold :slant italic)
           strict
           (w32-logfont "ＭＳ ゴシック" 0 -13 700 0   t nil nil 128 1 3 49)
           ((spacing . -1))))))
      (setq default-frame-alist
            (cons '(font . "private-fontset") ; フォントセットの指定
                  default-frame-alist))
      (set-language-environment 'Japanese)
      (prefer-coding-system 'utf-8)
      )
  (progn
    ;; Settings for Emacs. ( on linux )
    ;; Language setting.
    ;; (require 'un-define)
    (set-language-environment 'Japanese)
    (set-terminal-coding-system 'utf-8)
    (set-keyboard-coding-system 'utf-8)
    (set-buffer-file-coding-system 'utf-8-unix)
    (setq default-buffer-file-coding-system 'utf-8)
    (prefer-coding-system 'utf-8)
    (set-default-coding-systems 'utf-8)
    (setq file-name-coding-system 'utf-8)
    (set-clipboard-coding-system 'utf-8)

    (if (eq window-system 'w32)
        (progn
          ;; (setq default-frame-alist
          ;;       (cons '(font . "ＭＳ ゴシック") ; フォントセットの指定
          ;;             default-frame-alist))
          (set-face-attribute 'default nil
                              :family "ＭＳ ゴシック"
                              :height 100)
          (set-fontset-font "fontset-default"
                            'japanese-jisx0208
                            '("ＭＳ ゴシック" . "jisx0208-sjis"))
          ))
	(if (eq window-system 'mac)
		(progn
		  (set-fontset-font "fontset-default"
							'japanese-jisx0208
							'("Ricty" . "iso10646-*"))

		  (set-face-attribute 'default nil
							  :family "Ricty"
							  :height 140)))
	))

;;; add load path
(setq load-path (cons "~/share/emacs/site-lisp" load-path))

;; turn on font-lock mode
(global-font-lock-mode 1 t)

;; enable visual feedback on selections
(setq transient-mark-mode t)

;; customize by KON-H
(setq c-basic-offset 4)                                 ;; Set indent width as 2
(setq-default indent-tabs-mode t)                     ;; Use spaces for indent
(setq default-tab-width 4)                              ;; Set tab width as 4

(let ((host (intern (or (getenv "HOSTNAME") ""))))
  (cond 
   ((eq host 'harada-linux)
    (c-set-style "stroustrup")
    (setq c-basic-offset 4)
    (setq-default indent-tabs-mode t)                         ;; Use spaces for indent
    (setq tab-always-indent t)                                ;; ?
    )))

(show-paren-mode 1)                                       ;; Highlight parens
(put 'downcase-region 'disabled nil)

;; shell-script mode
(setq auto-mode-alist
      (cons ' ( "\\.conf\\'" . shell-script-mode) auto-mode-alist))

;;; ruby-mode
(autoload 'ruby-mode "ruby-mode" "alternate mode for editing ruby programs")
(setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))

; compilation-mode で自動ジャンプできるようにする
(require 'compile)
(add-to-list 'compilation-error-regexp-alist
			 '("\\[\\(.+\\):\\([0-9]+\\)" 1 2 nil) t) ; for test/unit assertion
(add-to-list 'compilation-error-regexp-alist
			 '("\\([^ ]+\\):\\([0-9]+\\):in" 1 2 nil) t) ; for test/unit error

;;; javascript-mode
(autoload 'js2-mode "js2" "mode for javascript programs")
(setq auto-mode-alist (append '(("\\.js$" . js2-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("javascript" . js2-mode))
                                     interpreter-mode-alist))
(add-hook 'js2-mode-hook
          '(lambda ()
             (local-set-key "\r" 'newline-and-indent)))

(load "js2" t)
(setq js2-mirror-mode nil)

(require 'compile)
;(add-to-list 'compilation-error-regexp-alist
;             '("\\([^(:]+\\):\\([0-9]+\\):.+\n" 1 2 nil) t) ; for test/unit error
;(add-to-list 'compilation-error-regexp-alist
;             '("at \\([^(:]+\\):\\([0-9]+\\):.+\n" 1 2 nil) t) ; for test/unit error

;;; lisp-mode
(setq auto-mode-alist (append '(("\\.fc$" . lisp-mode)) auto-mode-alist))

;;; disable menubar
(menu-bar-mode 0)

;;; flash instead of beep.
;;(setq visible-bell nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For SKK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(autoload 'skk-mode "skk" nil t)
;;(global-set-key "\C-x\C-j" 'skk-mode)
;;(require 'skk-setup)
;;(setq skk-large-jisyo "~/SKK-JISYO.L")

;; buffer moving
(setq windomove-wrap-around t)
(global-set-key "\M-f" 'windmove-right)
(global-set-key "\M-b" 'windmove-left)
(global-set-key "\M-p" 'windmove-up)
(set-face-foreground 'font-lock-comment-face "red") (set-face-foreground 'font-lock-comment-face "red") (global-set-key "\M-n" 'windmove-down)

;;; shortcut 
(global-set-key "\r"       'newline-and-indent)
(global-set-key "\C-t"     'switch-to-buffer)
(global-set-key "\C-cc"    'compile)
(global-set-key "\C-cg"    'grep)
(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-c\C-y" 'uncomment-region)
(global-set-key "\C-x\C-k" 'kill-this-buffer)
(global-set-key "\C-c\C-j" 'goto-line)
(global-set-key "\C-u"     'dabbrev-expand)
(global-set-key "\C-c\t"   'indent-region)
(global-set-key [C-return] 'chrome-reload)

(defun chrome-reload (start end &optional column)
  "Reload chrome"
  (interactive)
  (shell-command "~/bin/chrome-reload"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For Migemo( ro-ma ji incremental search )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq load-path (cons "~/share/migemo" load-path))
;; (autoload 'migemo "migemo.el" nil t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For yahtml( yet another html-mode )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (load-library "yahtml.el")
;; (setq auto-mode-alist (append '(("\\.html$" . yahtml-mode)) auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired-mode colorize for windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "dired")

(if (or (string-equal window-system "x") (string-equal window-system "w32") (string-equal window-system "mac"))
    (progn
      (tool-bar-mode 0) ;; ツールバーを隠す
      (set-background-color "#102418")
      (set-foreground-color "#b0b0b0")
      (set-cursor-color "#ff4040")
      (set-face-foreground 'modeline "Black")
      (set-face-background 'modeline "DarkKhaki")
      (set-face-background 'region "#142A4A") ;; リージョン指定の際の色
      (set-face-bold-p     'modeline nil)
      (set-face-background 'highlight "black")
      (set-face-foreground 'font-lock-comment-face "#309040")
      (set-face-foreground 'font-lock-string-face "#b06040")
      (set-face-foreground 'font-lock-variable-name-face "#c0a040")
      (set-face-foreground 'font-lock-keyword-face "#6060b0")
      (set-face-foreground 'dired-ignored "#606060") ;; バックアップファイルなど
      ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For Dired-modeで色をつける
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar *original-dired-font-lock-keywords* dired-font-lock-keywords)
(defun dired-highlight-by-extensions (highlight-list)
  "highlight-list accept list of (regexp [regexp] ... face)."
  (let ((lst nil))
    (dolist (highlight highlight-list)
      (push `(,(concat "\\.\\(" (regexp-opt (butlast highlight)) "\\)$")
              (".+" (dired-move-to-filename)
               nil (0 ,(car (last highlight)))))
            lst))
    (setq dired-font-lock-keywords
          (append *original-dired-font-lock-keywords* lst))))

(defvar *original-dired-font-lock-keywords* dired-font-lock-keywords)
(defun dired-highlight-by-extensions (highlight-list)
  "highlight-list accept list of (regexp [regexp] ... face)."
  (let ((lst nil))
    (dolist (highlight highlight-list)
      (push `(,(concat "\\(" (regexp-opt (butlast highlight)) "\\)$")
              (".+" (dired-move-to-filename)
               nil (0 ,(car (last highlight)))))
            lst))
    (setq dired-font-lock-keywords
          (append *original-dired-font-lock-keywords* lst))))

;(dired-highlight-by-extensions
;  '(("txt" font-lock-variable-name-face)
;    ("lisp" "el" "pl" "c" "h" "cc" font-lock-constant-face)))

(set-face-foreground 'font-lock-comment-face "red") ;; mac上でコメントが赤くならないのを修正

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customize by 'M-x customize'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

