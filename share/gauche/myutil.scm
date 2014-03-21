(define-module myutil
  (use pp)
  ;; (use util.list)
  ;; (use util.match)
  ;; (use text.tree)
  (export puts pp))

(select-module myutil)

(define (puts . x)
  (for-each
   (lambda (s) (display s) (display " "))
   x)
  (newline))

(define pp pretty-print)

(provide "myutil")
