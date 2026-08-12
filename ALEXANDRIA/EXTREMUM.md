EXTREMUM
---

### FUNCTION

Returns the element of SEQUENCE that would appear first if the subsequence
bounded by START and END was sorted using PREDICATE and KEY.

EXTREMUM determines the relationship between two elements of SEQUENCE by using
the PREDICATE function. PREDICATE should return true if and only if the first
argument is strictly less than the second one (in some appropriate sense). Two
arguments X and Y are considered to be equal if (FUNCALL PREDICATE X Y)
and (FUNCALL PREDICATE Y X) are both false.

The arguments to the PREDICATE function are computed from elements of SEQUENCE
using the KEY function, if supplied. If KEY is not supplied or is NIL, the
sequence element itself is used.

If SEQUENCE is empty, NIL is returned.
