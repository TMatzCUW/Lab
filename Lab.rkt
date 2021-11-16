;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Lab) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define block-exp '(1 a (2 b (3 c (4 d (5 e (6 f (7 g (8 h)))))))))
(define block-num 1)
(define block-symbol 'a)
(define block-symbol-block '(a (2 b 3) (4 c 5)))

(define count-block-exp
  (lambda (block-exp)
    (cond
      ((null? block-exp) 0)
      ((symbol? block-exp) 0)
      ((number? block-exp) block-exp)
      ((number? (car block-exp)) (+ (car block-exp)
                                    (if (null? (cddr block-exp)) 0
                                   (count-block-exp (caddr block-exp)))))
      (else (+ (count-block-exp (cadr block-exp)) (count-block-exp (caddr block-exp)))))))

(count-block-exp block-exp)

(define collect-symbols
  (lambda (block-exp)
    (cond
      ((null? block-exp)'())
      ((number? block-exp) '())
      ((symbol? block-exp) block-exp)
      ((number? (car block-exp)) (cons (cadr block-exp)
                                       (if (null? (cddr block-exp)) '()
                                       (collect-symbols (caddr block-exp)))))
      (else (cons (car block-exp) (append (collect-symbols (cadr block-exp))
                                        (collect-symbols (caddr block-exp))))))))

(collect-symbols block-exp)
                                           