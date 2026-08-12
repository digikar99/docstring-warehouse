COPY-READTABLE
---

### FUNCTION

Copies FROM-READTABLE and returns the result. Uses TO-READTABLE as a target
for the copy when provided, otherwise a new readtable is created. The
FROM-READTABLE defaults to the standard readtable when NIL and to the current
readtable when not provided.
