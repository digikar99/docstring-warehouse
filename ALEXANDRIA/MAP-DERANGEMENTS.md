MAP-DERANGEMENTS
---

### FUNCTION

Calls FUNCTION with each derangement of the subsequence of SEQUENCE denoted
by the bounding index designators START and END. Derangement is a permutation
of the sequence where no element remains in place. SEQUENCE is not modified,
but individual derangements are EQ to each other. Consequences are unspecified
if calling FUNCTION modifies either the derangement or SEQUENCE.
