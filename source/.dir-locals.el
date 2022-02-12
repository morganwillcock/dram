((org-mode . ((org-confirm-babel-evaluate
               . (lambda (lang body)
                   (not (member lang '("emacs-lisp" "sh"))))))))
