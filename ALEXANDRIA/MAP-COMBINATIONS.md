MAP-COMBINATIONS
---

### FUNCTION

Calls FUNCTION with each combination of LENGTH constructable from the
elements of the subsequence of SEQUENCE delimited by START and END. START
defaults to 0, END to length of SEQUENCE, and LENGTH to the length of the
delimited subsequence. (So unless LENGTH is specified there is only a single
combination, which has the same elements as the delimited subsequence.) If
COPY is true (the default) each combination is freshly allocated. If COPY is
false all combinations are EQ to each other, in which case consequences are
unspecified if a combination is modified by FUNCTION.
