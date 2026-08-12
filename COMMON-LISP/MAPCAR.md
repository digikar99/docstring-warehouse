MAPCAR
---

### FUNCTION

Apply FUNCTION to successive tuples of elements of LIST and MORE-LISTS.
Return list of FUNCTION return values.

For example:

(mapcar #'+ '(1 2 3) '(10 20 30))  ;; => (11 22 33)

(mapcar (lambda (x)
          (format t "~a is ~R~&" x x))
        '(1 2 3))
;; =>
1 is one
2 is two
3 is three
(NIL NIL NIL)

