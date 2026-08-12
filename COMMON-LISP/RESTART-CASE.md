RESTART-CASE
---

### FUNCTION

(RESTART-CASE form {(case-name arg-list {keyword value}* body)}*)
   The form is evaluated in a dynamic context where the clauses have
   special meanings as points to which control may be transferred (see
   INVOKE-RESTART).  When clauses contain the same case-name,
   FIND-RESTART will find the first such clause. If form is a call to
   SIGNAL, ERROR, CERROR or WARN (or macroexpands into such) then the
   signalled condition will be associated with the new restarts.
