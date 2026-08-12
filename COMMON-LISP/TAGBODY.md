TAGBODY
---

### FUNCTION

TAGBODY {tag | statement}*

Define tags for use with GO. The STATEMENTS are evaluated in order, skipping
TAGS, and NIL is returned. If a statement contains a GO to a defined TAG
within the lexical scope of the form, then control is transferred to the next
statement following that tag. A TAG must be an integer or a symbol. A
STATEMENT must be a list. Other objects are illegal within the body.
