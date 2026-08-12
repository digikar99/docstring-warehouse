DEFGENERIC
---

### FUNCTION



A generic function is a lisp function which is associated
with a set of methods and dispatches them when it's invoked. All
the methods with the same function name belong to the same generic
function.

The `defgeneric` form defines the generic function. If we write a
`defmethod` without a corresponding `defgeneric`, a generic function
is automatically created.

Example:

  (defgeneric greet (obj)
    (:documentation "says hi")
    (:method (obj)
      (format t "Hi")))


