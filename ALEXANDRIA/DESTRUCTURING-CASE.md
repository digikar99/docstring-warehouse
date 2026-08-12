DESTRUCTURING-CASE
---

### FUNCTION

DESTRUCTURING-CASE, -CCASE, and -ECASE are a combination of CASE and DESTRUCTURING-BIND.
KEYFORM must evaluate to a CONS.

Clauses are of the form:

  ((CASE-KEYS . DESTRUCTURING-LAMBDA-LIST) FORM*)

The clause whose CASE-KEYS matches CAR of KEY, as if by CASE, CCASE, or ECASE,
is selected, and FORMs are then executed with CDR of KEY is destructured and
bound by the DESTRUCTURING-LAMBDA-LIST.

Example:

 (defun dcase (x)
   (destructuring-case x
     ((:foo a b)
      (format nil "foo: ~S, ~S" a b))
     ((:bar &key a b)
      (format nil "bar: ~S, ~S" a b))
     (((:alt1 :alt2) a)
      (format nil "alt: ~S" a))
     ((t &rest rest)
      (format nil "unknown: ~S" rest))))

  (dcase (list :foo 1 2))        ; => "foo: 1, 2"
  (dcase (list :bar :a 1 :b 2))  ; => "bar: 1, 2"
  (dcase (list :alt1 1))         ; => "alt: 1"
  (dcase (list :alt2 2))         ; => "alt: 2"
  (dcase (list :quux 1 2 3))     ; => "unknown: 1, 2, 3"

 (defun decase (x)
   (destructuring-case x
     ((:foo a b)
      (format nil "foo: ~S, ~S" a b))
     ((:bar &key a b)
      (format nil "bar: ~S, ~S" a b))
     (((:alt1 :alt2) a)
      (format nil "alt: ~S" a))))

  (decase (list :foo 1 2))        ; => "foo: 1, 2"
  (decase (list :bar :a 1 :b 2))  ; => "bar: 1, 2"
  (decase (list :alt1 1))         ; => "alt: 1"
  (decase (list :alt2 2))         ; => "alt: 2"
  (decase (list :quux 1 2 3))     ; =| error

