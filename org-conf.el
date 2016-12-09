;; ==================================
;; === Configuration for Org-Mode === 
;; ==================================

(setq org-startup-align-all-tables t)
;; Add "CLOSED: [timestamp]" when TODO state is DONE
(setq org-log-done 'time)

;; Enable org-indent-mode
(setq org-startup-indented t)

(require 'ox-twbs) ;; Activate ox-twbs
(require 'org-bullets) ;; Activate Org-Bullet
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; Activate org-ac
(require 'org-ac)

;; Set To-Do List
(setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "|" "DONE")
			  (sequence "FOOD-OUT" "FOOD-FRIDGE" "|" "WASTED" "COOKED")
			  (sequence "TO-READ" "READING" "|" "DONE")
			  )
      )


;; If you would like a TODO entry to automatically change to DONE when all children are done, you can use the following setup:
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "org-ac")

(org-ac/config-default)

;; Load Org Color Them
;; (load-theme 'tangotango t)

(setq org-src-preserve-indentation nil 
      org-edit-src-content-indentation 0)
