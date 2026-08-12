GENSYM
---

### FUNCTION

Creates a new uninterned symbol whose name is a prefix string (defaults
   to "G"), followed by a decimal number. Thing, when supplied, will
   alter the prefix if it is a string, or be used for the decimal number
   if it is a number, of this symbol. The default value of the number is
   the current value of *gensym-counter* which is incremented each time
   it is used.
