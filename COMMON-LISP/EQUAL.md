EQUAL
---

### FUNCTION

Returns true if X and Y are structurally similar (isomorphic) objects.  Objects
are treated as follows by ‘equal’.

OVERVIEW:

    | Type         | Behavior                  |
    | number       | uses ‘eql’                |
    | character    | uses ‘eql’                |
    | cons         | descends                  |
    | bit vector   | descends                  |
    | string       | descends                  |
    | pathname     | “functionally equivalent” |
    | structure    | uses ‘eq’                 |
    | Other array  | uses ‘eq’                 |
    | hash table   | uses ‘eq’                 |
    | Other object | uses ‘eq’                 |

Any two objects that are ‘eql’ are also ‘equal’.

‘equal’ may fail to terminate if X or Y is circular.

A rough rule of thumb is that two objects are ‘equal’ if and only if their
printed representations are the same.

DETAIL:

Symbols, Numbers, and Characters

  ‘equal’ is true of two objects if they are symbols that are ‘eq’, if they are
   numbers that are ‘eql’, or if they are characters that are ‘eql’.

Conses

  For conses, ‘equal’ is defined recursively as the two cars being ‘equal’ and
  the two cdrs being ‘equal’.

Arrays

  Two arrays are ‘equal’ only if they are ‘eq’, with one exception: strings and
  bit vectors are compared element-by-element (using ‘eql’).  If either X or
  Y has a fill pointer, the fill pointer limits the number of elements
  examined by ‘equal’.  Uppercase and lowercase letters in strings are
  considered by ‘equal’ to be different.

Pathnames

  Two pathnames are ‘equal’ if and only if all the corresponding components
  (host, device, and so on) are equivalent.  Whether or not uppercase and
  lowercase letters are considered equivalent in strings appearing in
  components is implementation-dependent.  pathnames that are ‘equal’ should
  be functionally equivalent.

Other (Structures, hash-tables, instances, …)

   Two other objects are ‘equal’ only if they are ‘eq’.

   ‘equal’ does not descend any objects other than the ones explicitly specified
   above.  The next figure summarizes the information given in the previous list.
   In addition, the figure specifies the priority of the behavior of ‘equal’, with
   upper entries taking priority over lower ones.

EXAMPLES:

    (equal 'a 'b) → false
    (equal 'a 'a) → true
    (equal 3 3) → true
    (equal 3 3.0) → false
    (equal 3.0 3.0) → true
    (equal #c(3 -4) #c(3 -4)) → true
    (equal #c(3 -4.0) #c(3 -4)) → false
    (equal (cons 'a 'b) (cons 'a 'c)) → false
    (equal (cons 'a 'b) (cons 'a 'b)) → true
    (equal #\A #\A) → true
    (equal #\A #\a) → false
    (equal "Foo" "Foo") → true
    (equal "Foo" (copy-seq "Foo")) → true
    (equal "FOO" "foo") → false
    (equal "This-string" "This-string") → true
    (equal "This-string" "this-string") → false


SEE ALSO:

  eq, eql, equalp, =, string=, string-equal, char=, char-equal, tree-equal


NOTES:

  Object equality is not a concept for which there is a uniquely determined
  correct algorithm.  The appropriateness of an equality predicate can be judged
  only in the context of the needs of some particular program.  Although these
  functions take any type of argument and their names sound very generic,
  ‘equal’ and ‘equalp’ are not appropriate for every application.

