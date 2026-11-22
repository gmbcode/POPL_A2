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
