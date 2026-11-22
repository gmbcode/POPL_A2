#lang racket/base

;; Run with racket tests/s2_tests.rkt from the repository root.
(require racket/file
         racket/runtime-path
         rackunit
         rackunit/text-ui)

(define-runtime-path solution "../code/41_q4.rkt")

(define (module-output source input)
  (define output (open-output-string))
  (define errors (open-output-string))
  (parameterize ([current-input-port input]
                 [current-output-port output]
                 [current-error-port errors])
    (dynamic-require source #f))
  (check-equal? (get-output-string errors) "")
  (get-output-string output))

;; Append expressions to a temporary module, just as the grader appends calls.
(define (run-calls calls input)
  (define copy (make-temporary-file "s2-test-~a.rkt"))
  (dynamic-wind
    void
    (lambda ()
      (call-with-output-file copy
        (lambda (out)
          (display (file->string solution) out)
          (newline out)
          (for ([call calls])
            (write call out)
            (newline out)))
        #:exists 'truncate)
      (module-output copy (open-input-string input)))
    (lambda () (delete-file copy))))

(define (check-stdin input expected)
  (check-equal? (run-calls '((print-insert-result)) input) expected))

(define (check-value call expected)
  (check-equal? (run-calls (list (list 'display call) '(newline)) "")
                (format "~a\n" expected)))

(define s2-tests
  (test-suite
   "S2 nested list insertion"
   (test-case "loading leaves stdin and stdout untouched"
     (define input (open-input-string "sentinel"))
     (check-equal? (module-output solution input) "")
     (check-eq? (read input) 'sentinel))
   (test-case "mixed sublists example"
     (check-stdin "42 ((1 2) (3 4 5) (6) ()) 3"
                  "((42 1 2) (3 4 5) (42 6) (42))\n"))
   (test-case "multi-level example"
     (check-stdin "0 (((1) 2) (3) ((4 5 6) ())) 3"
                  "((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))\n"))
   (test-case "empty root below the threshold"
     (check-stdin "7 () 3" "(7)\n"))
   (test-case "empty root at the threshold"
     (check-stdin "7 () 0" "()\n"))
   (test-case "only original lengths equal to two"
     (check-value '((make-inserter 'x (lambda (size) (= size 2))) '((1 2) ()))
                  '(x (x 1 2) ())))
   (test-case "nested empty lists"
     (check-stdin "x (() (())) 1" "((x) ((x)))\n"))
   (test-case "threshold equality for the root and a child"
     (check-stdin "x ((a) (b c)) 2" "((x a) (b c))\n"))
   (test-case "100 levels of nesting"
     (define nested
       (for/fold ([tree '()]) ([level (in-range 100)])
         (list tree)))
     (define expected
       (for/fold ([tree '(x)]) ([level (in-range 100)])
         (list 'x tree)))
     (check-value (list 'insert-if-short ''x (list 'quote nested) 2)
                  expected))
   (test-case "10,000 elements"
     (define flat (build-list 10000 add1))
     (check-value (list 'insert-if-short ''x (list 'quote flat) 10001)
                  (cons 'x flat)))))

(module+ main
  (exit (run-tests s2-tests)))
