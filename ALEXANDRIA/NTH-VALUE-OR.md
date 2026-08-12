NTH-VALUE-OR
---

### FUNCTION

Evaluates FORM arguments one at a time, until the NTH-VALUE returned by one
of the forms is true. It then returns all the values returned by evaluating
that form. If none of the forms return a true nth value, this form returns
NIL.
