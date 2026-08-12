MAKE-RANDOM-STATE
---

### FUNCTION

Make a random state object. The optional STATE argument specifies a seed
for deterministic pseudo-random number generation.

As per the Common Lisp standard,
- If STATE is NIL or not supplied, return a copy of the default
  *RANDOM-STATE*.
- If STATE is a random state, return a copy of it.
- If STATE is T, return a randomly initialized state (using operating-system
  provided randomness where available, otherwise a poor substitute based on
  internal time and PID).

See SB-EXT:SEED-RANDOM-STATE for a SBCL extension to this functionality.
