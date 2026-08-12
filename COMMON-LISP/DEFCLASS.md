DEFCLASS
---

### FUNCTION

The macro defclass defines a new named class. It returns the new class object as its result.

Example:

    (defclass living-being () ())

    (defclass person (living-being)
      ((name
        :initarg :name
        :initform ""
        :accessor name)
       (lisper
        :initarg :lisper
        :initform nil
        :accessor lisper
        :documentation "Set to non-nil if this person fancies Lisp.")))

Slots are unbound by default, here we prefer them to be the empty string and nil.

An :accessor creates a generic method. You can have the same accessor name in different classes.

Create an instance of that class with MAKE-INSTANCE:

    (make-instance 'person :name "Alice" :lisper t)

Define how to pretty-print an object with PRINT-OBJECT.

After we change a class definition (slots are modified, added or removed), we can control how an object is updated with UPDATE-INSTANCE-FOR-REDEFINED-CLASS.

Read more:
https://lispcookbook.github.io/cl-cookbook/clos.html
https://cl-community-spec.github.io/pages/defclass.html

