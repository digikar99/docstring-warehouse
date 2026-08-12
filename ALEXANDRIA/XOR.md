XOR
---

### FUNCTION

Evaluates its arguments one at a time, from left to right. If more than one
argument evaluates to a true value no further DATUMS are evaluated, and NIL is
returned as both primary and secondary value. If exactly one argument
evaluates to true, its value is returned as the primary value after all the
arguments have been evaluated, and T is returned as the secondary value. If no
arguments evaluate to true NIL is returned as primary, and T as secondary
value.
