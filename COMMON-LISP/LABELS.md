LABELS
---

### FUNCTION

LABELS ({(name lambda-list declaration* form*)}*) declaration* body-form*

Evaluate the BODY-FORMS with local function definitions. The bindings enclose
the new definitions, so the defined functions can call themselves or each
other.
