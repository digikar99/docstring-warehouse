ROTATE
---

### FUNCTION

Returns a sequence of the same type as SEQUENCE, with the elements of
SEQUENCE rotated by N: N elements are moved from the end of the sequence to
the front if N is positive, and -N elements moved from the front to the end if
N is negative. SEQUENCE must be a proper sequence. N must be an integer,
defaulting to 1.

If absolute value of N is greater then the length of the sequence, the results
are identical to calling ROTATE with

  (* (signum n) (mod n (length sequence))).

Note: the original sequence may be destructively altered, and result sequence may
share structure with it.
