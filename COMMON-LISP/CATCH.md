CATCH
---

### FUNCTION

CATCH tag form*

Evaluate TAG and instantiate it as a catcher while the body forms are
evaluated in an implicit PROGN. If a THROW is done to TAG within the dynamic
scope of the body, then control will be transferred to the end of the body and
the thrown values will be returned.
