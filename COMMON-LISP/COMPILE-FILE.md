COMPILE-FILE
---

### FUNCTION

Compile INPUT-FILE, producing a corresponding fasl file and
returning its filename.

  :OUTPUT-FILE
     The name of the FASL to output.  The returned pathname of the
     output file may differ from the pathname of the :OUTPUT-FILE
     parameter, e.g. when the latter is a designator for a directory.

  :VERBOSE
     If true, information indicating what file is being compiled is printed
     to *STANDARD-OUTPUT*.

  :PRINT
     If true, each top level form in the file is printed to *STANDARD-OUTPUT*.

  :EXTERNAL-FORMAT
     The external format to use when opening the source file.
      The default is :DEFAULT which uses the SB-EXT:*DEFAULT-SOURCE-EXTERNAL-FORMAT*.

  :BLOCK-COMPILE {NIL | :SPECIFIED | T}
     Determines whether multiple functions are compiled together as a unit,
     resolving function references at compile time.  NIL means that global
     function names are never resolved at compilation time.  :SPECIFIED means
     that names are resolved at compile-time when convenient (as in a
     self-recursive call), but the compiler doesn't combine top-level DEFUNs.
     With :SPECIFIED, an explicit START-BLOCK declaration will enable block
     compilation.  A value of T indicates that all forms in the file(s) should
     be compiled as a unit.  The default is the value of
     SB-EXT:*BLOCK-COMPILE-DEFAULT*, which is initially NIL.

  :ENTRY-POINTS
     This specifies a list of function names for functions in the file(s) that
     must be given global definitions.  This only applies to block
     compilation, and is useful mainly when :BLOCK-COMPILE T is specified on a
     file that lacks START-BLOCK declarations.  If the value is NIL (the
     default) then all functions will be globally defined.

  :TRACE-FILE
     If given, internal data structures are dumped to the specified
     file, or if a value of T is given, to a file of *.trace type
     derived from the input file name. (non-standard)

  :EMIT-CFASL
     (Experimental). If true, outputs the toplevel compile-time effects
     of this file into a separate .cfasl file.
