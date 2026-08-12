SORT
---

### FUNCTION

Destructively sort SEQUENCE. PREDICATE should return non-NIL if
   ARG1 is to precede ARG2.

Since SORT is destructive, use COPY-LIST:

(setq mylist (list 1 3 2))
(sort (copy-list mylist) #'<)

See also STABLE-SORT.
