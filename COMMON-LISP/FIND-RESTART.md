FIND-RESTART
---

### FUNCTION

Return the first restart identified by IDENTIFIER. If IDENTIFIER is a symbol,
then the innermost applicable restart with that name is returned. If IDENTIFIER
is a restart, it is returned if it is currently active. Otherwise NIL is
returned. If CONDITION is specified and not NIL, then only restarts associated
with that condition (or with no condition) will be returned.
