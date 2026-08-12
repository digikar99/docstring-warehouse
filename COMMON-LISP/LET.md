LET
---

### FUNCTION

LET ({(var [value]) | var}*) declaration* form*

During evaluation of the FORMS, bind the VARS to the result of evaluating the
VALUE forms. The variables are bound in parallel after all of the VALUES forms
have been evaluated.
