LOAD-TIME-VALUE
---

### FUNCTION

Arrange for FORM to be evaluated at load-time and use the value produced as
if it were a constant. If READ-ONLY-P is non-NIL, then the resultant object is
guaranteed to never be modified, so it can be put in read-only storage.
