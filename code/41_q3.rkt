#lang racket/base

;; Reverse a list by moving each item onto the front of the result.
(define (my-reverse values)
  (let loop ([remaining values] [result '()])
    (if (null? remaining)
        result
        (loop (cdr remaining) (cons (car remaining) result)))))

;; Prepend values to acc as the nodes are visited in inorder.
(define (inorder-into tree acc)
  (if (null? tree)
      acc
      (let ([after-left (inorder-into (cadr tree) acc)])
        (inorder-into (caddr tree) (cons (car tree) after-left)))))

(define (print-inorder tree)
  (display (my-reverse (inorder-into tree '())))
  (newline))

;; Prepend values to acc as the nodes are visited in preorder.
(define (preorder-into tree acc)
  (if (null? tree)
      acc
      (let ([after-left (preorder-into (cadr tree) (cons (car tree) acc))])
        (preorder-into (caddr tree) after-left))))
