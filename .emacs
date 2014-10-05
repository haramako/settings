;; .emacs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ELPA( Emacs Lisp Package Archive) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq load-path (cons "~/.setting/share/emacs/site-lisp" load-path))

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;; add to paths
(setq load-path (cons "~/.setting/share/emacs/site-lisp" load-path))
(add-to-list 'exec-path "/usr/local/bin")

;;; See: http://e-arrows.sakura.ne.jp/2010/03/macros-in-emacs-el.html
(defmacro require-if-exists (lib &rest body)
  `(when (require ,lib nil t) ,@body))

;;; sh と環境変数を同期する
;;; See: http://qiita.com/catatsuy/items/3dda714f4c60c435bb25
(require 'exec-path-from-shell)
(exec-path-from-shell-copy-envs '("PATH" "GAUCHE_LOAD_PATH"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; basic setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; load setting for local
(if (file-readable-p "~/.emacs-local.el")
    (load "~/.emacs-local.el"))

;;; setting for os
(if (eq window-system 'w32) (require 'window-system-w32))
(if (eq window-system 'mac) (require 'window-system-mac))
(if (eq window-system 'ns) (require 'window-system-mac))
(if (eq system-type 'darwin) (require 'system-type-darwin))

;; customize by KON-H
(global-font-lock-mode t)                             ; turn on font-lock mode
(setq transient-mark-mode t)                            ; enable visual feedback on selections
(menu-bar-mode 0)                                       ; disable menubar
(show-paren-mode 1)                                     ; Highlight parens

(setq c-basic-offset 4)                                 ; Set indent width as 4
(setq-default indent-tabs-mode t)                       ; Use tabs for indent
(setq default-tab-width 4)                              ; Set tab width as 4

(put 'downcase-region 'disabled nil)                    ; disable downcase-region

(setq split-height-threshold 999)                       ; disable auto split

;;; "\"を"￥"で打つようにする
(define-key global-map [165] nil)
(define-key function-key-map [165] [?\\])

;;; バックアップファイルの保存場所を指定。
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))

;;; ドラッグ&ドロップでファイルを新規バッファで開くように変更
(define-key global-map [ns-drag-file] 'ns-find-file)
(setq ns-pop-up-frames nil)

;;; #ffffff などに色を付ける
;;; See: http://qiita.com/ironsand/items/cf8c582da3ec20715677
;(autoload 'rainbow-mode "rainbow-mode")
;(add-hook 'emacs-lisp-mode-hook 'rainbow-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-if-exists 'ido (ido-mode t) 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ruby
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; ruby-mode basic-setting
(autoload 'ruby-mode "ruby-mode" "alternate mode for editing ruby programs")
;; (setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
;; (setq auto-mode-alist (append '(("Gemfile$" . ruby-mode)) auto-mode-alist))
;; (setq auto-mode-alist (append '(("Capfile$" . ruby-mode)) auto-mode-alist))
;; (setq auto-mode-alist (append '(("Rakefile$" . ruby-mode)) auto-mode-alist))
;; (setq auto-mode-alist (append '(("Guardfile$" . ruby-mode)) auto-mode-alist))
;; (setq auto-mode-alist (append '(("config.ru$" . ruby-mode)) auto-mode-alist))
;; (setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
;;                                      interpreter-mode-alist))
;;; Rinari for rails
;; (add-to-list 'load-path "~/.setting/share/emacs/site-lisp/rinari")
;; (require 'rinari nil t)

;;;
(add-hook 'ruby-mode-hook
		  '(lambda ()
			 ;; (require 'cl)
			 ;; (require-if-exists 'rcodetools)
			 ;; (define-key ruby-mode-map (kbd "C-c o") 'xmp)
			 
			 ;; (require-if-exists 'auto-complete-config
			 ;; 					(ac-config-default)
			 ;; 					(define-key ruby-mode-map (kbd "C-u") 'ac-start))
			 
			 ;; highlight for RSpec
			 (let ((a-rspec-keywords '("should" "should_not" "describe" "it" "context")))
			   (add-to-list 'font-lock-keywords
							(cons (list (concat "" (regexp-opt a-rspec-keywords t) "")
										1 'font-lock-keyword-face)
								  (cadr font-lock-keywords))
							t))
			 ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mode special setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'compile)

;; shell-script mode
(setq auto-mode-alist
      (cons ' ( "\\.conf\\'" . shell-script-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons ' ( "\\.cnf\\'" . shell-script-mode) auto-mode-alist))

;;; haml-mode
(autoload 'haml-mode "haml-mode" "alternate mode for editing haml")
(setq auto-mode-alist (append '(("\\.haml$" . haml-mode)) auto-mode-alist))

;;; javascript-mode
(autoload 'js2-mode "js2" "mode for javascript programs")
(setq auto-mode-alist (append '(("\\.js$" . js2-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("javascript" . js2-mode))
                                     interpreter-mode-alist))
(setq js2-mirror-mode nil)
(add-hook 'js2-mode-hook
          '(lambda ()
             (require 'espresso)
             (setq espresso-indent-level 4
                   espresso-expr-indent-offset 4
                   indent-tabs-mode t)
             (set (make-local-variable 'indent-line-function) 'espresso-indent-line)
             (local-set-key "\r" 'newline-and-indent)))

;;; lua-mode
(autoload 'lua-mode "lua-mode" "alternate mode for editing lua programs")
(setq auto-mode-alist (append '(("\\.lua$" . lua-mode)) auto-mode-alist))

;;; coffee-mode
(autoload 'coffee-mode "coffee-mode" "alternate mode for editing coffee-script programs")
(setq auto-mode-alist (append '(("\\.coffee$" . coffee-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("coffee" . coffee-mode))
                                     interpreter-mode-alist))
(setq auto-mode-alist (append '(("Cakefile$" . coffee-mode)) auto-mode-alist))
(add-hook 'coffee-mode-hook
		  '(lambda()
			 (set (make-local-variable 'tab-width) 2)
			 (setq coffee-tab-width 2)))
;;(add-to-list 'compilation-error-regexp-alist
;;			 '("at \\(.+\\.coffee\\):\\([0-9]+\\):\\([0-9]+\\)" 1 2 3) nil) ; for test/unit assertion

;;; fc as c-mode
(setq auto-mode-alist (append '(("\\.fc$" . c-mode)) auto-mode-alist))

;;; markdown-mode
(autoload 'markdown-mode "markdown-mode" "alternate mode for editing markdown")
(setq auto-mode-alist (append '(("\\.md$" . markdown-mode)) auto-mode-alist))

;;; php-mode
(autoload 'php-mode "php-mode" "alternate mode for editing php programs")
(setq auto-mode-alist (append '(("\\.php$" . php-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("/app/views/.+\\.php$" . web-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("php" . php-mode))
                                     interpreter-mode-alist))

; change indent
(add-hook 'php-mode-hook
          (lambda ()
            (c-set-offset 'case-label' 4)
            (c-set-offset 'arglist-intro' 4)
            (c-set-offset 'arglist-cont-nonempty' 4)
            (c-set-offset 'arglist-close' 0)))

;;; web-mode
(autoload 'web-mode "web-mode" "Majar mode for html")
(setq auto-mode-alist (append '(("\\.html$" . web-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.erb$" . web-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.ejs$" . web-mode)) auto-mode-alist))

;;; py-mode
(autoload 'python-mode "python-mode" "Majar mode for python")
(setq auto-mode-alist (append '(("SConstruct$" . python-mode)) auto-mode-alist))

;;; scheme-mode
(require 'cl)
(autoload 'gauche-mode "gauche-mode" "Majar mode for scheme")
(setq auto-mode-alist (append '(("\\.scm$" . gauche-mode)) auto-mode-alist))
(add-hook 'gauche-mode-hook
		  '(lambda ()
			 (local-set-key (kbd "M-*") 'pop-tag-mark)
			 (local-set-key (kbd "M-.") 'find-tag)
			 (local-set-key (kbd "M-C-d") 'down-list)
			 (local-set-key (kbd "C-c C-c") 'comment-region)
			 (add-to-list 'scheme-font-lock-keywords-2 '("\\?[^ ()]+" . font-lock-variable-name-face))
			 ;; カッコに色を付ける
			 (require 'rainbow-delimiters)
			 (rainbow-delimiters-mode)
			 (dolist (x '((3 "#66ff66") (4 "#888888") (5 "#6666ff") (6 "#ff6666")
						  (7 "#dddd66") (8 "#66bbbb") (9 "#66bb66") (10 "#bb6666")))
					 (custom-set-faces
					  `(,(intern (format "rainbow-delimiters-depth-%d-face" (car x)))
						((t (:foreground ,(cadr x)))))))

			 ;; 括弧の表示をよくする
			 (require 'mic-paren)
			 (setq paren-highlight-offscreen t)
			 (check-parens)
			 (setq paren-ding-unmatched t)

			 ))

;;; asm mode
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))

;;; go-mode
(autoload 'go-mode "go-mode" "Majar mode for go")
(setq auto-mode-alist (append '(("\\.go$" . go-mode)) auto-mode-alist))

;;; haskell-mode
(add-hook 'haskell-mode-hook
		  (lambda ()
			(turn-on-haskell-indentation)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; compilation-mode で自動ジャンプできるようにする
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'compilation-error-regexp-alist-alist
             '(ruby "\\([^ \t\n]+\\):\\([0-9]+\\):in" 1 2 nil)) ; for ruby's "    from hoge.rb:99: error message"
(add-to-list 'compilation-error-regexp-alist 'ruby)
(add-to-list 'compilation-error-regexp-alist-alist
             '(node-js "at .+ (\\([^ \n]+\\):\\([0-9]+\\):\\([0-9]+\\))" 1 2 nil)) ; for node-js's
(add-to-list 'compilation-error-regexp-alist-alist
             '(gauche "At line \\([0-9]+\\) of \"\\([^\"]+\\)\"" 2 1 nil)) ; for ruby's " At line 999 of "file.scm"
;(add-to-list 'compilation-error-regexp-alist
;			 '("\\[\\(.+\\):\\([0-9]+\\)" 1 2 nil) t) ; for test/unit assertion
;(add-to-list 'compilation-error-regexp-alist
;			 '("\\([^ ]+\\):\\([0-9]+\\):in" 1 2 nil) t) ; for test/unit error

;; compilation-modeで
;; ruby の "from hoge.rb:99: error message"のようなメッセージを間違ってエラーとして解釈してしまうのを修正
(setcdr (assoc 'gnu compilation-error-regexp-alist-alist)
'( "^\\(?:[[:alpha:]][-[:alnum:].]+: ?\\)?\
\\([0-9]*[^0-9\n]\\(?:[^\n ]\\)*?\\): ?\
\\([0-9]+\\)\\(?:\\([.:]\\)\\([0-9]+\\)\\)?\
\\(?:-\\([0-9]+\\)?\\(?:\\.\\([0-9]+\\)\\)?\\)?:\
\\(?: *\\(\\(?:Future\\|Runtime\\)?[Ww]arning\\|W:\\)\\|\
 *\\([Ii]nfo\\(?:\\>\\|rmationa?l?\\)\\|I:\\|instantiated from\\|[Nn]ote\\)\\|\
\[0-9]?\\(?:[^0-9\n]\\|$\\)\\|[0-9][0-9][0-9]\\)"
 1 (2 . 5) (4 . 6) (7 . 8)))

;; complation for python
(add-to-list 'compilation-error-regexp-alist-alist
			 '(python "^ *File \"\\([^,\" \n\t]+\\)\", line \\([0-9]+\\)" 1 2))

;; complation for go
(add-to-list 'compilation-error-regexp-alist-alist
			 '(golang "^\t\\([^,\" \n\t:]+\\):\\([0-9]+\\) \\+" 1 2))

;; complation for gcc assert
(add-to-list 'compilation-error-regexp-alist-alist
			 '(gcc-assert " file \\([^,\" \n\t]+\\), line \\([0-9]+\\)" 1 2))

;; complation for ca65
(add-to-list 'compilation-error-regexp-alist-alist
			 '(ca65 "^\\([^,\" \n\t]+\\)(\\([0-9]+\\)): Error:" 1 2))

;; 一部のモードが邪魔をするため減らす
(setq compilation-error-regexp-alist
      '(node-js bash gnu gcc-include perl python ruby golang gcc-assert ca65 gauche))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For SKK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(autoload 'skk-mode "skk" nil t)
;;(global-set-key "\C-x\C-j" 'skk-mode)
;;(require 'skk-setup)
;;(setq skk-large-jisyo "~/SKK-JISYO.L")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; buffer moving
(setq windomove-wrap-around t)
(global-set-key "\M-f" 'windmove-right)
(global-set-key "\M-b" 'windmove-left)
(global-set-key "\M-p" 'windmove-up)
(global-set-key "\M-n" 'windmove-down)

;;; shortcut 
(global-set-key "\C-\\"    'undo)
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
(global-set-key "\C-xr"    'revert-buffer)

;; Mac-OS-X上でchromeのリロードを行う
(defun chrome-reload ()
  "Reload chrome"
  (interactive)
  (shell-command "~/.setting/bin/chrome-reload"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if window-system
    (progn
       (tool-bar-mode 0) ;; ツールバーを隠す
	   ))

(set-background-color "#102418")
(set-foreground-color "#d0d0d0")
(set-cursor-color "#ff4040")
;; (set-face-foreground 'modeline "Black")
;; (set-face-background 'modeline "DarkKhaki")
(set-face-background 'region "#142A4A") ;; リージョン指定の際の色
;; (set-face-bold-p     'modeline nil)
(set-face-background 'highlight "black")
(set-face-foreground 'font-lock-comment-face "#309040")
(set-face-foreground 'font-lock-string-face "#b06040")
(set-face-foreground 'font-lock-variable-name-face "#c0a040")
(set-face-foreground 'font-lock-keyword-face "#6060b0")
(set-face-foreground 'font-lock-doc-face "#40b040")
(set-face-background 'show-paren-mismatch "#ff0000")

(if (not window-system)
	(progn
	  (set-background-color "#000000")
      (set-foreground-color "#d0d0d0")
	  ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; For Dired-modeで色をつける
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'dired)

(set-face-foreground 'dired-ignored "#606060") ;; バックアップファイルなど

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

;; (dired-highlight-by-extensions
;;   '(("txt" font-lock-variable-name-face)
;;     ("lisp" "el" "pl" "c" "h" "cc" font-lock-constant-face)))


;
; auto-complete-mode
;
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/share/emacs/site-lisp/ac-dict")

;(require 'auto-complete-clang)
;(ac-config-default)

;(add-hook 'objc-mode-hook
;          (lambda()
;            (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs-keybind
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-if-exists 'emacs-keybind
				   (setq emacs-keybind-program-file "~/.setting/share/emacs/site-lisp/emacs_keybind.rb")
				   (setq emacs-keybind-keyboard-kind "japanese")
				   (setq emacs-keybind-work-dir "~/.emacs.d"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gtags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require-if-exists 'gtags
				   (global-set-key (kbd "M-.") 'gtags-find-tag)
				   (global-set-key (kbd "M-*") 'gtags-pop-stack))

(global-auto-revert-mode 1)
(setq auto-revert-verbose nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customize by 'M-x customize'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables)
