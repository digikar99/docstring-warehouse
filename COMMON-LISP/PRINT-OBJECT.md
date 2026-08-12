PRINT-OBJECT
---

### FUNCTION

The generic function print-object writes the printed representation of object to stream. The function print-object is called by the Lisp printer; it should not be called by the user.

Example:

   (defmethod print-object ((obj person) stream)
      (print-unreadable-object (obj stream :type t :identity t)
        (with-slots (name lisper) obj
          (format stream "~a, lisper: ~a" name lisper))))

   (make-instance 'person :name "Alice")
   ;; =>
   #<PERSON Alice, lisper: NIL {1007277633}>
   (1) (2)                     (3)
   1 tells the reader that this object can't be read back in
   2 is the object type
   3 is the object identity (address).

Read more:
https://cl-community-spec.github.io/pages/print_002dobject.html
https://lispcookbook.github.io/cl-cookbook/clos.html#pretty-printing

