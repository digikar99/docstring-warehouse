DISJOIN
---

### FUNCTION

Returns a function that applies each of PREDICATE and MORE-PREDICATE
functions in turn to its arguments, returning the primary value of the first
predicate that returns true, without calling the remaining predicates.
If none of the predicates returns true, NIL is returned.
