ETYPECASE
---

### FUNCTION

ETYPECASE Keyform {(Type Form*)}*
  Evaluates the Forms in the first clause for which TYPEP of Keyform and Type
  is true. If no form is satisfied then an error is signalled.
