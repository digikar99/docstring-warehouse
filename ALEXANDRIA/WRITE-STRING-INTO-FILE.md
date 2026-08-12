WRITE-STRING-INTO-FILE
---

### FUNCTION

Write STRING to PATHNAME.

The EXTERNAL-FORMAT parameter will be passed directly to WITH-OPEN-FILE
unless it's NIL, which means the system default.
