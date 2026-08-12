RATIONALIZE
---

### FUNCTION

Converts any REAL to a RATIONAL.  Floats are converted to a simple rational
  representation exploiting the assumption that floats are only accurate to
  their precision.  RATIONALIZE (and also RATIONAL) preserve the invariant:
      (= x (float (rationalize x) x))
