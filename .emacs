;; .emacs

;;; add load path
(setq load-path (cons "~/.setting/share/emacs/site-lisp" load-path))

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

;;; "\"を"￥"で打つようにする
(define-key global-map [165] nil)
(define-key function-key-map [165] [?\\])

;;; バックアップファイルの保存場所を指定。
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (require 'ido nil t)
  (ido-mode t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ruby
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; ruby-mode basic-setting
(autoload 'ruby-mode "ruby-mode" "alternate mode for editing ruby programs")
(setq auto-mode-alist (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
;;; Rinari for rails
(add-to-list 'load-path "~/.setting/share/emacs/site-lisp/rinari")
(require 'rinari nil t)

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
(setq auto-mode-alist (append '(("/app/views/.+\\.php$" . html-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("php" . php-mode))
                                     interpreter-mode-alist))
; change indent
(add-hook 'php-mode-hook
          (lambda ()
            (c-set-offset 'case-label' 4)
            (c-set-offset 'arglist-intro' 4)
            (c-set-offset 'arglist-cont-nonempty' 4)
            (c-set-offset 'arglist-close' 0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; compilation-mode で自動ジャンプできるようにする
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'compilation-error-regexp-alist-alist
             '(ruby "\\([^ \n]+\\):\\([0-9]+\\):in" 1 2 nil)) ; for ruby's "    from hoge.rb:99: error message"
(add-to-list 'compilation-error-regexp-alist 'ruby)
(add-to-list 'compilation-error-regexp-alist-alist
             '(node-js "at .+ (\\([^ \n]+\\):\\([0-9]+\\):\\([0-9]+\\))" 1 2 nil)) ; for node-js's "    at Object.<hoge> (hoge.js:99:11)"
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

;; 一部のモードが邪魔をするため減らす
(setq compilation-error-regexp-alist
      '(ruby node-js bash gnu gcc-include perl))

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

;; Mac-OS-X上でchromeのリロードを行う
(defun chrome-reload ()
  "Reload chrome"
  (interactive)
  (shell-command "~/.setting/bin/chrome-reload"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired-mode colorize for windows
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "dired")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(if window-system
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
;;; ELPA( Emacs Lisp Package Archive) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customize by 'M-x customize'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

