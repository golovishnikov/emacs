;; Ergomacs

(setenv "ERGOEMACS_KEYBOARD_LAYOUT" "us") ; US
(load-file "~/.emacs.d/ergoemacs/site-lisp/site-start.el")

;; My config
(global-unset-key (kbd "M-c"))
(global-unset-key (kbd "C-<SPC>"))
(global-unset-key (kbd "M-0"))

(defun my-keybindings (my-key-map)
  (define-key my-key-map (kbd "C-y") 'kill-whole-line)
  (define-key my-key-map (kbd "<f3>") 'set-mark-command)
  (define-key my-key-map (kbd "<f2>") 'bs-show)
  (define-key my-key-map (kbd "C-b") 'bookmark-set)
  (define-key my-key-map (kbd "M-b") 'bookmark-jump)
  (define-key my-key-map (kbd "<f4>") 'bookmark-bmenu-list)
  (define-key my-key-map (kbd "<f9>") 'eval-last-sexp)
  (define-key my-key-map (kbd "<C-tab>") 'other-window)
  (define-key my-key-map (kbd "<f11>") 'my-help)
  (define-key my-key-map (kbd "C-d") 'duplicate-current-line-or-region)
  (define-key my-key-map (kbd "<C-S-up>") 'upcase-region)
  (define-key my-key-map (kbd "<C-S-down>") 'downcase-region))

(my-keybindings (current-global-map))

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


(defun my-help ()
  (interactive)
  (message "<f3> -- set mark; <C-tab> -- next window; <F2> -- opened file list; <C-b> -- bookmark set; <M-b> -- bookmark jump; <F4> -- bookmark list; <f9> -- eval expression; <C-S-up> -- Upcase region; <C-S-down> -- Downcase region; <C-d> -- dublicate region"))

(defun reload-keybindings ()
  (interactive)
  (my-keybindings (current-global-map)))
