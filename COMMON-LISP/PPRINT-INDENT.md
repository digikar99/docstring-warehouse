PPRINT-INDENT
---

### FUNCTION

Specify the indentation to use in the current logical block if
STREAM (which defaults to *STANDARD-OUTPUT*) is a pretty-printing
stream and do nothing if not. (See PPRINT-LOGICAL-BLOCK.) N is the
indentation to use (in ems, the width of an ``m'') and RELATIVE-TO can
be either:

     :BLOCK - Indent relative to the column the current logical block
        started on.

     :CURRENT - Indent relative to the current column.

The new indentation value does not take effect until the following
line break.
