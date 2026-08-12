MAP-IOTA
---

### FUNCTION

Calls FUNCTION with N numbers, starting from START (with numeric contagion
from STEP applied), each consequtive number being the sum of the previous one
and STEP. START defaults to 0 and STEP to 1. Returns N.

Examples:

  (map-iota #'print 3 :start 1 :step 1.0) => 3
    ;;; 1.0
    ;;; 2.0
    ;;; 3.0

