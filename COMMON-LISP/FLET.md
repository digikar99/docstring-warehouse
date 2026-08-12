FLET
---

### FUNCTION

FLET ({(name lambda-list declaration* form*)}*) declaration* body-form*

Evaluate the BODY-FORMS with local function definitions. The bindings do
not enclose the definitions; any use of NAME in the FORMS will refer to the
lexically apparent function definition in the enclosing environment.
