;;;; Dired shortcuts
;; [+] create a new subdirectory in the current working directory
;; [m] mark the current for later commands
;; [u] unmark the current
;; [U] unmark all
;; [t] invert marking
;; [C] copy file(s)
;; [R] rename a file or move files to another directory
;; [D] delete marked file(s)
;; [j] goto file

;;;; Add the Melpa repo
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;; (package-initialize)

;;;; Auto refresh dired on file change
(add-hook 'dired-mode-hook 'auto-revert-mode)

;;;; Don't warn when running shells on exit
(add-hook 'comint-exec-hook
          (lambda ()
            (set-process-query-on-exit-flag
             (get-buffer-process (current-buffer))
             nil)))

;;;; Do not create backup files
(setq make-backup-files nil)

;;;; Disable startup screen
(setq inhibit-startup-message t)

;;;; Disable tool bar, menu bar, scroll bar
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;;;; Show line numbers
(global-display-line-numbers-mode 1)

;;;; Disable line wrap
;; (setq-default truncate-lines 1)

;;;; Highlight current line
(global-hl-line-mode 1)

;;;; Highlight matching parensthesis
(show-paren-mode 1)

;;;; Add new line at end of buffer on save
(setq-default require-final-newline t)

;;;; Column number mode
(setq-default column-number-mode t)

;;;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default indent-level 4)
(setq lua-indent-level 4)
(setq sgml-basic-offset 4)
(setq css-indent-level 4)
(setq ruby-indent-level 2)
(setq typescript-indent-level 2)
(setq c-indent-level 4)
(setq c-basic-offset 4)

;;;; Maximize Window on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;;;; Modeline custom
(setq display-time-format "%H:%M:%S")
(setq display-time-interval 1)
(setq display-time-default-load-average nil)
(display-time)
;; (require 'powerline)

;;;; Smooth scrolling (scroll by one line at a time when scrolling past the end of the file)
(setq scroll-conservatively 101)

;;;; Neotree
(require 'neotree)
(global-set-key (kbd "C-x C-j") 'neotree-toggle)
(setq neo-window-width 30)
(setq neo-window-fixed-size nil)
(setq neo-smart-open t)

;;;; My custom keybindings (utilizing the 'bind-key' package)
(bind-key* "C-d" 'delete-backward-char)
(bind-key* "M-d" 'backward-kill-word)
(bind-key* "C-M-b" 'windmove-swap-states-left)
(bind-key* "C-M-f" 'windmove-swap-states-right)
;; (bind-key* "C-x C-f" 'fzf)
;; (bind-key* "C-x C-b" 'fzf-switch-buffer)

(defun my-build-project ()
  "Build the project based on the current file's extension."
  (interactive)
  (let ((file (buffer-file-name)))
    (cond
     ;; Love
     ((string-match "\\.lua$" file)
      (async-shell-command "~/Applications/love.AppImage ."))

     ;; Default: Ask for a command
     (t (async-shell-command
         (read-string "Build command: " ""))))))

(bind-key* "<f5>" 'my-build-project)

;;;; Multiple cursors (utilizing the 'multiple-cursors' package)
(require 'multiple-cursors)
(bind-key* "C-M-j" 'mc/mark-all-dwim) ;; Do what I mean
(bind-key* "C-M-c" 'mc/edit-lines) ;; Mark lines, then create cursors.
(bind-key* "C-M-/" 'mc/mark-all-like-this) ;; Select region first, then create cursors at all occurences like this
(bind-key* "C-M-," 'mc/mark-previous-like-this) ;; Select region first, then create cursors at all previous like this
(bind-key* "C-M-." 'mc/mark-next-like-this) ;; Select region first, then create cursors at all the next like this
(bind-key* "C-M-<" 'mc/skip-to-previous-like-this) ;; Skip this match and move the previous one
(bind-key* "C-M->" 'mc/skip-to-next-like-this) ;; Skip this match and move to the next one

;;;; IDO mode
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)

;;;; fzf config
;; (require 'fzf)
;; (setq fzf/args "-x --color bw --print-query --margin=0,0 --no-hscroll"
;;         fzf/executable "fzf"
;;         fzf/position-bottom 't
;;         fzf/window-height 8)

;;;; Whitespace mode
(global-whitespace-mode 1)
(setq-default whitespace-style
              '(face spaces empty tabs newline trailing space-mark tab-mark))
(setq-default whitespace-global-modes
              '(not shell-mode
                    help-mode
                    magit-mode
                    magit-diff-mode
                    ibuffer-mode
                    dired-mode
                    occur-mode))
(require 'color)
(let* ((ws-lighten 30)
       (ws-color (color-lighten-name "#444444" ws-lighten)))
  (custom-set-faces
   `(whitespace-newline                ((t (:foreground ,ws-color))))
   `(whitespace-missing-newline-at-eof ((t (:foreground ,ws-color))))
   `(whitespace-space                  ((t (:foreground ,ws-color))))
   `(whitespace-space-after-tab        ((t (:foreground ,ws-color))))
   `(whitespace-space-before-tab       ((t (:foreground ,ws-color))))
   `(whitespace-tab                    ((t (:foreground ,ws-color))))
   `(whitespace-trailing               ((t (:foreground ,ws-color))))))
(setq-default whitespace-display-mappings
      '(
        ;; space -> · else .
        (space-mark 32 [183] [46])
        ;; new line -> ¬ else $
        (newline-mark ?\n [172 ?\n] [36 ?\n])
        ;; tabs -> » else >
        (tab-mark ?\t [187 ?\t] [62 ?\t])))

;;;; Highlight todo and similar keywords
(setq global-hl-todo-mode 1)
(setq hl-todo-keyword-faces
      '(("TODO"  . "#FFFF00")
        ("NOTE"  . "#FF00FF")
        ("FIXME" . "#0000FF")
        ("DONE"  . "#00FF00")
        ("BUG"   . "#FF0000")))

;;;; Odin major mode
;;;; (needs a lot of tweaking and the indentaion of some directives does not work)
(load-file "~/.emacs.d/elpa/odin-mode/odin-mode.el")

;;;; Lorem Ipsum filler text
(require 'lorem-ipsum)

;;;; Package signature failure
;;;; For more info refer to the following link:
;;;; "https://emacs.stackexchange.com/questions/233/how-to-proceed-on-package-el-signature-check-failure"
(setq package-check-signature nil)

;;;; Scratch buffer default message
(setq initial-scratch-message ";; Welcome to Emacs!\n")

;;;; DANGER ZONE (DO NOT TOUCH)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(gruber-darker))
 '(custom-safe-themes
   '("01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd"
     default))
 '(ispell-dictionary nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(bind-key fzf gruber-darker-theme hl-todo lorem-ipsum lua-mode magit
              multiple-cursors neotree powerline typescript-mode))
 '(tool-bar-mode nil))

(put 'dired-find-alternate-file 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "TX02" :foundry "USGC" :slant normal :weight normal :height 98 :width normal))))
 '(whitespace-missing-newline-at-eof ((t (:foreground "#58be58be58be"))))
 '(whitespace-newline ((t (:foreground "#58be58be58be"))))
 '(whitespace-space ((t (:foreground "#58be58be58be"))))
 '(whitespace-space-after-tab ((t (:foreground "#58be58be58be"))))
 '(whitespace-space-before-tab ((t (:foreground "#58be58be58be"))))
 '(whitespace-tab ((t (:foreground "#58be58be58be"))))
 '(whitespace-trailing ((t (:foreground "#58be58be58be")))))
