WITH-STANDARD-IO-SYNTAX
---

### FUNCTION

Bind the reader and printer control variables to values that enable READ
   to reliably read the results of PRINT. These values are:

         *PACKAGE*                        the COMMON-LISP-USER package
         *PRINT-ARRAY*                    T
         *PRINT-BASE*                     10
         *PRINT-CASE*                     :UPCASE
         *PRINT-CIRCLE*                   NIL
         *PRINT-ESCAPE*                   T
         *PRINT-GENSYM*                   T
         *PRINT-LENGTH*                   NIL
         *PRINT-LEVEL*                    NIL
         *PRINT-LINES*                    NIL
         *PRINT-MISER-WIDTH*              NIL
         *PRINT-PPRINT-DISPATCH*          the standard pprint dispatch table
         *PRINT-PRETTY*                   NIL
         *PRINT-RADIX*                    NIL
         *PRINT-READABLY*                 T
         *PRINT-RIGHT-MARGIN*             NIL
         *READ-BASE*                      10
         *READ-DEFAULT-FLOAT-FORMAT*      SINGLE-FLOAT
         *READ-EVAL*                      T
         *READ-SUPPRESS*                  NIL
         *READTABLE*                      the standard readtable
  SB-EXT:*SUPPRESS-PRINT-ERRORS*          NIL
  SB-EXT:*PRINT-VECTOR-LENGTH*            NIL

