DEFMACRO
---

### FUNCTION

Macros operate on code, which they see as lists of lists of symbols.

Macros, unlike functions, do not evaluate their arguments.  They
expand (at compile time) into another piece of code, that will
eventually be evaluated.

First rule for macros: don't write a macro when a function can do.

Example macros: DEFUN LOOP SETF WITH-OPEN-FILE

See also: QUOTE BACKQUOTE GENSYM MACROEXPAND

Read more:
https://lispcookbook.github.io/cl-cookbook/macros.html
https://gigamonkeys.com/book/macros-standard-control-constructs.html
https://www.youtube.com/watch?v=ygKXeLKhiTI Little bits of Lisp video

