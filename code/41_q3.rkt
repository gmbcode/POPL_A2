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

;; Prepend values to acc as the nodes are visited in postorder.
(define (postorder-into tree acc)
  (if (null? tree)
      acc
      (let* ([after-left (postorder-into (cadr tree) acc)]
             [after-right (postorder-into (caddr tree) after-left)])
        (cons (car tree) after-right))))

(define (print-all-traversals tree)
  (print-inorder tree)
  (display (my-reverse (preorder-into tree '())))
  (newline)
  (display (my-reverse (postorder-into tree '())))
  (newline))

;; Return the height and leaf count together in one pass.
(define (tree-statistics tree)
  (cond
    [(null? tree) '(0 0)]
    [(and (null? (cadr tree)) (null? (caddr tree))) '(1 1)]
    [else
     (let* ([left-stats (tree-statistics (cadr tree))]
            [right-stats (tree-statistics (caddr tree))])
       (list (+ 1 (max (car left-stats) (car right-stats)))
             (+ (cadr left-stats) (cadr right-stats))))]))

(define (print-height-and-leaves tree)
  (display (tree-statistics tree))
  (newline))
