LOAD
---

### FUNCTION

Load the file given by FILESPEC into the Lisp environment, returning T on
   success. The file type (a.k.a extension) is defaulted if missing. These
   options are defined:

   :IF-DOES-NOT-EXIST
       If :ERROR (the default), signal an error if the file can't be located.
       If NIL, simply return NIL (LOAD normally returns T.)

   :VERBOSE
       If true, print a line describing each file loaded.

   :PRINT
       If true, print information about loaded values.  When loading the
       source, the result of evaluating each top-level form is printed.

   :EXTERNAL-FORMAT
       The external-format to use when opening the FILENAME. The default is
       :DEFAULT which uses the SB-EXT:*DEFAULT-SOURCE-EXTERNAL-FORMAT*.
