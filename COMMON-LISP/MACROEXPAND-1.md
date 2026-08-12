MACROEXPAND-1
---

### FUNCTION

If form is a macro (or symbol macro), expand it once. Return two values,
   the expanded form and a T-or-NIL flag indicating whether the form was, in
   fact, a macro. ENV is the lexical environment to expand in, which defaults
   to the null environment.
