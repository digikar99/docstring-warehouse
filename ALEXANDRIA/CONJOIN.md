CONJOIN
---

### FUNCTION

Returns a function that applies each of PREDICATE and MORE-PREDICATE
functions in turn to its arguments, returning NIL if any of the predicates
returns false, without calling the remaining predicates. If none of the
predicates returns false, returns the primary value of the last predicate.
