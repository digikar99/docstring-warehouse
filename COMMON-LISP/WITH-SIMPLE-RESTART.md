WITH-SIMPLE-RESTART
---

### FUNCTION

(WITH-SIMPLE-RESTART (restart-name format-string format-arguments)
   body)
   If restart-name is not invoked, then all values returned by forms are
   returned. If control is transferred to this restart, it immediately
   returns the values NIL and T.
