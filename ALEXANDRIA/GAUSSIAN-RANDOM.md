GAUSSIAN-RANDOM
---

### FUNCTION

Returns two gaussian random double floats as the primary and secondary value,
optionally constrained by MIN and MAX. Gaussian random numbers form a standard
normal distribution around 0.0d0.

Sufficiently positive MIN or negative MAX will cause the algorithm used to
take a very long time. If MIN is positive it should be close to zero, and
similarly if MAX is negative it should be close to zero.
