#lang racket/base

;; Run with racket tests/s1_tests.rkt from the repository root.
(require racket/file
         racket/runtime-path
         rackunit
         rackunit/text-ui)

(define-runtime-path solution "../code/41_q3.rkt")

(define (module-output source)
  (define output (open-output-string))
  (define errors (open-output-string))
  (parameterize ([current-output-port output]
                 [current-error-port errors])
    (dynamic-require source #f))
  (check-equal? (get-output-string errors) "")
  (get-output-string output))

;; Append calls to a temporary module so the solution needs no exports.
(define (check-tree tree inorder preorder postorder statistics)
  (define copy (make-temporary-file "s1-test-~a.rkt"))
  (dynamic-wind
    void
    (lambda ()
      (call-with-output-file copy
        (lambda (out)
          (display (file->string solution) out)
          (newline out)
          (for ([entry '(print-inorder print-all-traversals print-height-and-leaves)])
            (write (list entry (list 'quote tree)) out)
            (newline out)))
        #:exists 'truncate)
      (check-equal? (module-output copy)
                    (string-append inorder "\n"
                                   inorder "\n" preorder "\n" postorder "\n"
                                   statistics "\n")))
    (lambda () (delete-file copy))))

(define s1-tests
  (test-suite
   "S1 binary tree traversals"
   (test-case "source loads silently"
     (check-equal? (module-output solution) ""))
   (test-case "balanced example"
     (check-tree '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))
                 "(1 2 3 4 5 6 7)" "(4 2 1 3 6 5 7)" "(1 3 2 5 7 6 4)" "(3 4)"))
   (test-case "right-skewed example"
     (check-tree '(1 () (2 () (3 () ())))
                 "(1 2 3)" "(1 2 3)" "(3 2 1)" "(3 1)"))
   (test-case "symbolic example"
     (check-tree '(a (b () ()) (c () ()))
                 "(b a c)" "(a b c)" "(b c a)" "(2 2)"))
   (test-case "empty example"
     (check-tree '() "()" "()" "()" "(0 0)"))
   (test-case "single node"
     (check-tree '(9 () ()) "(9)" "(9)" "(9)" "(1 1)"))))

(module+ main
  (exit (run-tests s1-tests)))
