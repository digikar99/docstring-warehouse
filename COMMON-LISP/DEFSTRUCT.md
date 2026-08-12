DEFSTRUCT
---

### FUNCTION

DEFSTRUCT {Name | (Name Option*)} [Documentation] {Slot | (Slot [Default] {Key Value}*)}
   Define the structure type Name. Instances are created by MAKE-<name>,
   which takes &KEY arguments allowing initial slot values to the specified.
   A SETF'able function <name>-<slot> is defined for each slot to read and
   write slot values. <name>-p is a type predicate.

   Popular DEFSTRUCT options (see manual for others):

   (:CONSTRUCTOR Name)
   (:PREDICATE Name)
       Specify the name for the constructor or predicate.

   (:CONSTRUCTOR Name Lambda-List)
       Specify the name and arguments for a BOA constructor
       (which is more efficient when keyword syntax isn't necessary.)

   (:INCLUDE Supertype Slot-Spec*)
       Make this type a subtype of the structure type Supertype. The optional
       Slot-Specs override inherited slot options.

   Slot options:

   :TYPE Type-Spec
       Asserts that the value of this slot is always of the specified type.

   :READ-ONLY {T | NIL}
       If true, no setter function is defined for this slot.

Example:

  (defstruct person
    name age)

Creates the `make-person' constructor function, the `person-p' predicate as well as the `person-name' and `person-age' setf-able functions:

   (person-name (make-person :name "lisper"))
   ;; => "lisper"

Read more:

- https://lispcookbook.github.io/cl-cookbook/data-structures.html#structures
- https://cl-community-spec.github.io/pages/defstruct.html
