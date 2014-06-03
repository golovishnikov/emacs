(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/")

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))

(autoload 'clojure-mode "clojure-mode" "A major mode for Clojure" t)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs$" . clojurescript-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NRepl

(require 'nrepl)
(define-key nrepl-mode-map (kbd "C-M-i") 'nrepl-backward-input)
(define-key nrepl-mode-map (kbd "C-M-k") 'nrepl-forward-input)

(add-hook 'nrepl-interaction-mode-hook
	  'nrepl-turn-on-eldoc-mode)

(setq nrepl-popup-stacktraces nil)


(defun nrepl-custom-workaround ()
  (nrepl-eval "(apply require clojure.main/repl-requires)"))
(add-hook 'nrepl-connected-hook
          'nrepl-custom-workaround)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ErgoEmacs
(add-to-list 'load-path "~/.emacs.d/ergoemacs")
(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us")

;; load ErgoEmacs keybinding
(load "~/.emacs.d/ergoemacs/ergoemacs-mode")

;; turn on minor mode ergoemacs-mode
(ergoemacs-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Disable menu bar
;; (menu-bar-mode -1)

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(setq show-paren-style 'expression)

(require 'linum+)
(setq linum-format "%d ")
(global-linum-mode 1)

(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving

(setq search-highlight           t) ; Highlight search object
(setq query-replace-highlight    t) ; Highlight query object
(setq mouse-sel-retain-highlight t) ; Keep mouse high-lightening


;; ;; Autocomplete
;; ;; regular auto-complete initialization
(require 'auto-complete-config)
(ac-config-default)


(defun format-all ()
  (interactive)
  (indent-region (point-min) (point-max)))

;; Remove splash screen
(setq inhibit-splash-screen t)

(defun scroll-one-line-behind ()
  "Scroll behind one line."
  (interactive)
  (scroll-down 1))

(defun scroll-one-line-ahead ()
  "Scroll ahead one line."
  (interactive)
  (scroll-up 1))

(defun my-kill-ring-save ()
  (interactive)
  (let ((beg (region-beginning))
	(end (region-end)))
    (if (use-region-p)
	(kill-ring-save beg end))))

(setq make-backup-files nil)

(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

(require 'sr-speedbar)


(global-unset-key (kbd "M-c"))
(global-unset-key (kbd "C-<SPC>"))
(global-unset-key (kbd "M-0"))

(defun my-keybindings (my-key-map)
  (define-key my-key-map (kbd "<f3>") 'set-mark-command)
  (define-key my-key-map (kbd "M-SPC") 'set-mark-command)
  (define-key my-key-map (kbd "C-M-SPC") 'set-mark-command)
  (define-key my-key-map (kbd "C-l") 'goto-line)
  (define-key my-key-map (kbd "C-(") 'my-shrink-vert)
  (define-key my-key-map (kbd "C-)") 'my-enlarge-vert)
  (define-key my-key-map (kbd "C-9") 'my-shrink-horz)
  (define-key my-key-map (kbd "C-0") 'my-enlarge-horz)
  (define-key my-key-map (kbd "M-(") 'my-super-shrink-vert)
  (define-key my-key-map (kbd "M-)") 'my-super-enlarge-vert)
  (define-key my-key-map (kbd "M-9") 'my-super-shrink-horz)
  (define-key my-key-map (kbd "M-0") 'my-super-enlarge-horz)
  (define-key my-key-map (kbd "M-8") 'my-50%-horz)
  (define-key my-key-map (kbd "<f8>") 'my-format)
  (define-key my-key-map (kbd "M-c") 'my-kill-ring-save)
  (define-key my-key-map (kbd "C-c l") 'toggle-truncate-lines)
  (define-key my-key-map (kbd "M-a") 'mark-whole-buffer)
  (define-key my-key-map (kbd "M-n") 'reindent-then-newline-and-indent)
  (define-key my-key-map (kbd "M-m") 'reindent-then-newline-and-indent)
  (define-key my-key-map (kbd "<S-M-left>") 'windmove-left)
  (define-key my-key-map (kbd "<S-M-down>") 'windmove-down)
  (define-key my-key-map (kbd "<S-M-right>") 'windmove-right)
  (define-key my-key-map (kbd "<S-M-up>") 'windmove-up)
  (define-key my-key-map (kbd "S-M-j") 'windmove-left)
  (define-key my-key-map (kbd "S-M-k") 'windmove-down)
  (define-key my-key-map (kbd "S-M-l") 'windmove-right)
  (define-key my-key-map (kbd "S-M-i") 'windmove-up)
  (define-key my-key-map (kbd "C-b") 'bookmark-set)
  (define-key my-key-map (kbd "M-b") 'bookmark-jump)
  (define-key my-key-map (kbd "<f4>") 'bookmark-bmenu-list)
  (define-key my-key-map (kbd "C-M-.") 'pop-tag-mark)
  (define-key my-key-map (kbd "C-t") 'indent-for-tab-command)
  (define-key my-key-map (kbd "C-x C-s") 'save-buffer)
  (define-key my-key-map (kbd "M-s") 'save-buffer)
  (define-key my-key-map (kbd "C-,") 'repeat)
  (define-key my-key-map (kbd "<f2>") 'bs-show)
  (define-key my-key-map (kbd "<f12>") 'sr-speedbar-toggle)
  (define-key my-key-map (kbd "<f9>") 'eval-last-sexp)
  (define-key my-key-map (kbd "<C-tab>") 'move-cursor-next-pane)
  (define-key my-key-map (kbd "<f11>") 'show-my-help)
  (define-key my-key-map (kbd "C-d") 'duplicate-current-line-or-region)
  (define-key my-key-map (kbd "C-y") 'kill-whole-line)
  (define-key my-key-map (kbd "<C-S-up>") 'upcase-region)
  (define-key my-key-map (kbd "<C-S-down>") 'downcase-region))

(my-keybindings (current-global-map))

(defun show-my-help ()
  (interactive)
  (message "<f12> -- show/hide speedbar; <f2> -- select opened file; <f3> -- visit tags table; <f4> -- bookmarks list; <f5> -- run emacs command; <f8> -- format all; <f9> -- upcase selected text (for SQL); <M-Space> -- set mark; <M-i> -- up, <M-k> -- down, <M-j> -- left; <M-l> -- right; <M-S-i> -- page up; <M-S-k> -- page down; <M-u> -- word-left; <M-o> -- word-right; <M-h> -- end of line; <M-S-h> -- beginning of line; <M-c> -- copy; <M-x> -- cut; <M-v> -- paste; <M-s> -- save buffer; <C-b> -- set bookmark; <M-b> -- jump bookmark; <M-q> -- move cursor to next window; <C-l> -- goto line; <C-0> -- enlarge current buffer (horizontal); <C-9> -- shrink current buffer (horizontal); <M-0> -- enlarge current buffer more (horizontal); <M-9> -- shrink current buffer more (horizontal); <C-S-0> -- enlarge current buffer (vertical); <C-S-9> -- shrink current buffer (vertical); <M-S-0> -- enlarge current buffer more (vertical); <M-S-9> -- shrink current buffer more (vertical);"))

(defun reload-keybindings ()
  (interactive)
  (my-keybindings (current-global-map)))

(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))


(add-hook 'clojure-mode-hook  (lambda () (my-keybindings clojure-mode-map)))

(setq auto-mode-alist (cons '("\\.cljs$" . closure-mode) auto-mode-alist))

;; (add-to-list 'load-path "~/.emacs.d/color-theme/")
;; (require 'color-theme)
;; (color-theme-initialize)
;; (setq color-theme-is-global t)

(tool-bar-mode -1)
(show-paren-mode 2)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#708183" "#c60007" "#728a05" "#a57705" "#2075c7" "#c61b6e" "#259185" "#042028"))
 ;; '(custom-enabled-themes (quote (tango-dark)))
 ;; '(custom-safe-themes (quote ("b350a2b83904e2bc8e0978f7b48836903fa5149b6eaaad7aa3e15cf3f4adb060" "7eb9c9db72afc647b2704923458d46e33515564d84a81f0c68383f80eb045b7d" "7fe1e3de3e04afc43f9a3d3a8d38cd0a0efd9d4c" "d14db41612953d22506af16ef7a23c4d112150e5" "2c2877aa7de2d5ec7e06d1c978bd69f01ab2a15f" "1f392dc4316da3e648c6dc0f4aad1a87d4be556c" "baac41e6656dd9a5fd1f76d7d41662b8bc1dc10b" default)))
 ;; '(javahome "/opt/jdk/6")
 ;; '(semantic-java-dependency-system-include-path (quote ("/opt/jdk6")))
 '(show-paren-mode t)
 '(speedbar-directory-button-trim-method (quote trim))
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 27) (border-width . 1) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (left-fringe . 0))))
 '(speedbar-hide-button-brackets-flag nil)
 '(speedbar-mode-specific-contents-flag t)
 '(speedbar-show-unknown-files t)
 '(speedbar-use-images t)
 '(sr-speedbar-max-width 70)
 '(sr-speedbar-right-side nil)
 '(sr-speedbar-width-console 70)
 '(sr-speedbar-width-x 70)
 '(tool-bar-mode nil))


(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
(setq x-select-enable-primary nil)  ; stops killing/yanking interacting with primary X11 selection
(setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection

(setq select-active-regions t) ;  active region sets primary X11 selection
(global-set-key [mouse-2] 'mouse-yank-primary)  ; make mouse middle-click only paste from primary X11 selection, not clipboard and kill 

(setq redisplay-dont-pause t)

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "Consolas" :foundry "microsoft" :slant normal :weight normal :height 143 :width normal)))))

(defun my-enlarge-vert ()
  (interactive)
  (enlarge-window 2))

(defun my-shrink-vert ()
  (interactive)
  (enlarge-window -2))

(defun my-enlarge-horz ()
  (interactive)
  (enlarge-window-horizontally 2))

(defun my-shrink-horz ()
  (interactive)
  (enlarge-window-horizontally -2))

(defvar *larg-window-size-percent* 0.7)

(defun my-50%-horz ()
  (interactive)
  (let* ((width (round (* (frame-width) 0.5)))
	 (cur-width (window-width))
	 (delta (- width (+ cur-width 5))))
    (enlarge-window-horizontally delta)))

(defun my-super-enlarge-horz ()
  (interactive)
  (let* ((width (round (* (frame-width) *larg-window-size-percent*)))
	 (cur-width (window-width))
	 (delta (- width cur-width)))
    (enlarge-window-horizontally delta)))

(defun my-super-enlarge-vert ()
  (interactive)
  (let* ((height (round (* (frame-height) *larg-window-size-percent*)))
	 (cur-height (window-height))
	 (delta (- height cur-height)))
    (enlarge-window delta)))

(defun my-super-shrink-horz ()
  (interactive)
  (let* ((width (round (* (frame-width) (- 1 *larg-window-size-percent*))))
	 (cur-width (window-width))
	 (delta (- width cur-width)))
    (enlarge-window-horizontally delta)))

(defun my-super-shrink-vert ()
  (interactive)
  (let* ((height (round (* (frame-height) (- 1 *larg-window-size-percent*))))
	 (cur-height (window-height))
	 (delta (- height cur-height)))
    (enlarge-window delta)))

(defun my-format ()
  (interactive)
  (save-excursion
    (indent-region 1 (point-max))))


(defun my-speedbar-jump (dir)
  (interactive "DDirectory: ")
  (dframe-select-attached-frame speedbar-frame)
  (setq default-directory dir)
  (speedbar-update-contents))

(put 'dired-find-alternate-file 'disabled nil)


(defun my-test-message ()
  (interactive)
  (message "Hello, World!"))


(put 'upcase-region 'disabled nil)


(defun my-close-tag ()
  "Close the previously defined XML tag"
  (interactive)
  (let ((tag nil)
        (quote nil))
    (save-excursion
      (do ((skip 1))
          ((= 0 skip))
        (re-search-backward "</?[a-zA-Z0-9_-]+")
        (cond ((looking-at "</")
               (setq skip (+ skip 1)))
              ((not (looking-at "<[a-zA-Z0-9_-]+[^>]*?/>"))
               (setq skip (- skip 1)))))
      (when (looking-at "<\\([a-zA-Z0-9_-]+\\)")
        (setq tag (match-string 1)))
      (if (eq (get-text-property (point) 'face)
              'font-lock-string-face)
          (setq quote t)))
    (when tag
      (setq quote (and quote
                       (not (eq (get-text-property (- (point) 1) 'face)
                                'font-lock-string-face))))
      (if quote
          (insert "\""))
      (insert "</" tag ">")
      (if quote
          (insert "\"")))))


;; Company mode
(require 'company)
(global-company-mode t)


(global-unset-key (kbd "C-M-i"))
(global-unset-key (kbd "C-M-k"))

(define-key minibuffer-local-completion-map (kbd "C-M-i") 'previous-history-element)
(define-key minibuffer-local-completion-map (kbd "C-M-k") 'next-history-element)
