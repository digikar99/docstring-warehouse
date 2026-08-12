PPRINT-TABULAR
---

### FUNCTION

Output LIST to STREAM tabbing to the next column that is an even multiple
   of TABSIZE (which defaults to 16) between each element. :FILL style
   conditional newlines are also output between each element. If COLON? is
   NIL (defaults to T), then no parens are printed around the output.
   ATSIGN? is ignored (but allowed so that PPRINT-TABULAR can be used with
   the ~/.../ format directive.
