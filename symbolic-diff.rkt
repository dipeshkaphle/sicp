#lang racket

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))
(define (make-exp y n)
  (cond ((=number? n 0) 1)
        ((=number? n 1) y)
        ((and (number? y) (number? n)) (expt y n))
        (else (list '** y n))))
(define (exp? x)
  (and (pair? x) (eq? (car x) '**)))
(define (base p) (cadr p))

(define (exponent p) (caddr p))


(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exp? exp)
         (make-product
          (make-product
           (exponent exp) (make-exp
                           (base exp) (make-sum (exponent exp) -1)))
          (deriv (base exp) var)
          ))
        (else
         (error "unknown expression type -- DERIV" exp))))



(displayln (deriv '(+ x 3) 'x))
(displayln (deriv '(* x y) 'x))
(displayln (deriv '(* (* x y) (+ x 3)) 'x))

;; d(u^n)/dx = n*u^(n-1)*du/dx
;; Ex 2.56
(displayln (deriv '(** (** x 2) n) 'x))
