EQ
---

### FUNCTION

Returns true if its arguments are the same, identical object; otherwise,
returns false.


EXAMPLES:

    (eq 'a 'b)  ;=> false
    (eq 'a 'a)  ;=> true
    (eq 3 3)
    ;=> true
    OR ;=> false

    (eq 3 3.0)  ;=> false
    (eq 3.0 3.0)
    ;=> true
    OR ;=> false

    (eq #c(3 -4) #c(3 -4))
    ;=> true
    OR ;=> false

    (eq #c(3 -4.0) #c(3 -4))  ;=> false
    (eq (cons 'a 'b) (cons 'a 'c))  ;=> false
    (eq (cons 'a 'b) (cons 'a 'b))  ;=> false
    (eq '(a . b) '(a . b))
    ;=> true
    OR ;=> false

    (progn (setq x (cons 'a 'b)) (eq x x))  ;=> true
    (progn (setq x '(a . b)) (eq x x))  ;=> true
    (eq #\A #\A)
    ;=> true
    OR ;=> false

    (let ((x "Foo")) (eq x x))  ;=> true
    (eq "Foo" "Foo")
    ;=> true
    OR ;=> false

    (eq "Foo" (copy-seq "Foo"))  ;=> false
    (eq "FOO" "foo")  ;=> false
    (eq "string-seq" (copy-seq "string-seq"))  ;=> false
    (let ((x 5)) (eq x x))
    ;=> true
    OR ;=> false


SEE ALSO:

  eql, equal, equalp, =


NOTES:

   Objects that appear the same when printed are not necessarily ‘eq’ to each
   other.  Symbols that print the same usually are ‘eq’ to each other because of
   the use of the ‘intern’ function.  However, numbers with the same value need not
   be ‘eq’, and two similar lists are usually not identical.

   An implementation is permitted to make “copies” of characters and numbers at
   any time.  The effect is that Common Lisp makes no guarantee that ‘eq’ is true
   even when both its arguments are “the same thing” if that thing is a character
   or number.

   Most Common Lisp operators use ‘eql’ rather than ‘eq’ to compare objects, or
   else they default to ‘eql’ and only use ‘eq’ if specifically requested to do so.
   However, the following operators are defined to use ‘eq’ rather than ‘eql’ in a
   way that cannot be overridden by the code which employs them:


OPERATORS THAT ALWAYS PREFER EQ OVER EQL:

  ‘catch’                  ‘getf’                   ‘throw’
  ‘get’                    ‘remf’
  ‘get-properties’         ‘remprop’


REFERENCES:

- https://metaspec.dev/chap-3.html#sec_3_2
