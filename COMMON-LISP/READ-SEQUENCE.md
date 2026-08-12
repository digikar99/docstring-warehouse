READ-SEQUENCE
---

### FUNCTION

Destructively modify SEQ by reading elements from STREAM.
  SEQ is bounded by START and END. SEQ is destructively modified by
  copying successive elements into it from STREAM. If the end of file
  for STREAM is reached before copying all elements of the subsequence,
  then the extra elements near the end of sequence are not updated, and
  the index of the next element is returned.
