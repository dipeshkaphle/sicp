;; Church numerals
(define zero (lambda (f) (lambda (x) x)))
;; zero = λf.λx.x

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
;; add-1 n = λf.λx. (f ((n f) x))

;; (define one (add-1 zero))
;; add-1 zero = λf.λx. (f (((λf.λx.x) f) x))
;; add-1 zero = λf.λx. (f ((λx.x) x))
;; add-1 zero = λf.λx. (f x)
(define one
  (lambda (f) (lambda (x) (f x))))

;; (define two (add-1 one))
;; add-1 one =λf.λx. (f ((one f) x))
;; add-1 one =λf.λx. (f (((λf.λx. (f x)) f) x))
;; add-1 one =λf.λx. (f ((λx. (f x))) x))
;; add-1 one =λf.λx. (f (f x))
;; add-1 one =λf.λx. (f (f x))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (add a b)
  (lambda (f) (lambda (x) ((b f) ((a f) x))))
  )

;; add n b =λf.λx. (b f) ((n f) x)
;; add n one =λf.λx. (one f) ((n f) x)
;; add n one =λf.λx. (λx.f x) ((n f) x)
;; add n one =λf.λx. (λx.f x) ((n f) x)
;; add n one =λf.λx. f ((n f) x) ;; which is the definition of add-1 // holds for 1
;;
;; add n two =λf.λx. (two f) ((n f) x)
;; add n two =λf.λx. (λx. f (f x)) ((n f) x)
;; add n two =λf.λx. (λx. f (f x)) ((n f) x) ;; if we put n = zero, we get the definition of two

;; add n k =λf.λx. (k f) ((n f) x) ;; Assume correct for k
;;
;; add n (add k one) = λf.λx. ((add-1 k) f) ((n f) x)
;; add n (add k one) = λf.λx. ( (λf.λx. f ((k f) x)) f) ((n f) x)
;; add n (add k one) = λf.λx. (λx. f ((k f) x)) ((n f) x)
;; add n (add k one) = λf.λx. (f ((k f) ((n f) x)))
;; add n (add k one) = λf.λx.f (λf.λx. (k f) ((n f) x))
;; add n (add k one) = λf.λx.f (add n k) ;; Not sure if i proved it lol(i don't think i did)
