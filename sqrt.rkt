#lang racket
(define (square x) (* x x))

;; Newton's method for sqrt
(define (average x y ) (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
   (< (abs (- (square guess) x)) 0.001)
)

(define (sqrt-iter guess x)
  (if (good-enough? guess x) guess
      (sqrt-iter (improve guess x) x))
)

(define (sqrt x) (sqrt-iter 1.0 x))
(displayln (sqrt 0.0004))

(define (good-enough?? prev-guess cur-guess x)
   (and (< (/ (- prev-guess cur-guess) cur-guess) 0.001)
        (< (abs (- (square x) cur-guess)) 0.001)
        )
)

(define (sqrt-iter2 prev-guess guess x)
  (if (good-enough?? prev-guess guess x) x
      (sqrt-iter2 guess (improve guess x) x))
)

(define (sqrt2 x) (sqrt-iter2 2.0 1.0 x))

(displayln (sqrt' 0.0004))
