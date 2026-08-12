PPRINT-TAB
---

### FUNCTION

If STREAM (which defaults to *STANDARD-OUTPUT*) is a pretty-printing
   stream, perform tabbing based on KIND, otherwise do nothing. KIND can
   be one of:
     :LINE - Tab to column COLNUM. If already past COLNUM tab to the next
       multiple of COLINC.
     :SECTION - Same as :LINE, but count from the start of the current
       section, not the start of the line.
     :LINE-RELATIVE - Output COLNUM spaces, then tab to the next multiple of
       COLINC.
     :SECTION-RELATIVE - Same as :LINE-RELATIVE, but count from the start
       of the current section, not the start of the line.
