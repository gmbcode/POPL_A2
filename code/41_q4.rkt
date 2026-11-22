#lang racket/base

;; Count each top-level element once, including sublists.
(define (my-length lst)
  (let loop ([remaining lst] [count 0])
    (if (null? remaining)
        count
        (loop (cdr remaining) (+ count 1)))))

;; Apply f in list order and preserve that order in the result.
(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst)) (my-map f (cdr lst)))))

;; Insert at the root and in each sublist based on its original length.
(define (insert-if-short x lst n)
  (let* ([insert-here? (< (my-length lst) n)]
         [items (my-map (lambda (item)
                          (if (or (null? item) (pair? item))
                              (insert-if-short x item n)
                              item))
                        lst)])
    (if insert-here? (cons x items) items)))

(define (print-insert-result)
  (let* ([x (read)]
         [lst (read)]
         [n (read)])
    (display (insert-if-short x lst n))
    (newline)))
