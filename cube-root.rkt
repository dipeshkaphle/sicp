#lang racket

(define (cube x) (* x x x))
(define (square x) (* x x))

;; Cube root

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2.0 guess)) 3.0))

(define (good-enough? guess x)
   (< (abs (- (cube guess) x)) 0.001)
)

(define (cube-root-iter guess x)
  (if (good-enough? guess x) guess
      (cube-root-iter (improve guess x) x))
)

(define (cube-root x) (cube-root-iter 1.0 x))
(displayln (cube-root 8.0))
(displayln (cube-root 0.001) )