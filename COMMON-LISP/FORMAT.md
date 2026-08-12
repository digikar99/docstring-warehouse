FORMAT
---

### FUNCTION

Provides various facilities for formatting output.
  CONTROL-STRING contains a string to be output, possibly with embedded
  directives, which are flagged with the escape character "~". Directives
  generally expand into additional text to be output, usually consuming one
  or more of the FORMAT-ARGUMENTS in the process. A few useful directives
  are:
        ~A or ~nA   Prints one argument as if by PRINC
        ~S or ~nS   Prints one argument as if by PRIN1
        ~D or ~nD   Prints one argument as a decimal integer
        ~%          Does a TERPRI
        ~&          Does a FRESH-LINE
  where n is the width of the field in which the object is printed.

  DESTINATION controls where the result will go. If DESTINATION is T, then
  the output is sent to the standard output stream. If it is NIL, then the
  output is returned in a string as the value of the call. Otherwise,
  DESTINATION must be a stream to which the output will be sent.

  Example:   (FORMAT NIL "The answer is ~D." 10) => "The answer is 10."

  FORMAT has many additional capabilities not described here. Consult the
  manual for details.
