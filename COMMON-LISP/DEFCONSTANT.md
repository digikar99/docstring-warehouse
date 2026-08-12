DEFCONSTANT
---

### FUNCTION

Define a global constant, saying that the value is constant and may be
  compiled into code. If the variable already has a value, and this is not
  EQL to the new value, the code is not portable (undefined behavior). The
  third argument is an optional documentation string for the variable.
