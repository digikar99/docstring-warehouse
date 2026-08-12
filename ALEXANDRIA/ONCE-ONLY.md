ONCE-ONLY
---

### FUNCTION

Constructs code whose primary goal is to help automate the handling of
multiple evaluation within macros. Multiple evaluation is handled by introducing
intermediate variables, in order to reuse the result of an expression.

The returned value is a list of the form

  (let ((<gensym-1> <expr-1>)
        ...
        (<gensym-n> <expr-n>))
    <res>)

where GENSYM-1, ..., GENSYM-N are the intermediate variables introduced in order
to evaluate EXPR-1, ..., EXPR-N once, only. RES is code that is the result of
evaluating the implicit progn FORMS within a special context determined by
SPECS. RES should make use of (reference) the intermediate variables.

Each element within SPECS is either a symbol SYMBOL or a pair (SYMBOL INITFORM).
Bare symbols are equivalent to the pair (SYMBOL SYMBOL).

Each pair (SYMBOL INITFORM) specifies a single intermediate variable:

- INITFORM is an expression evaluated to produce EXPR-i

- SYMBOL is the name of the variable that will be bound around FORMS to the
  corresponding gensym GENSYM-i, in order for FORMS to generate RES that
  references the intermediate variable

The evaluation of INITFORMs and binding of SYMBOLs resembles LET. INITFORMs of
all the pairs are evaluated before binding SYMBOLs and evaluating FORMS.

Example:

  The following expression

  (let ((x '(incf y)))
    (once-only (x)
      `(cons ,x ,x)))

  ;;; =>
  ;;; (let ((#1=#:X123 (incf y)))
  ;;;   (cons #1# #1#))

  could be used within a macro to avoid multiple evaluation like so

  (defmacro cons1 (x)
    (once-only (x)
      `(cons ,x ,x)))

  (let ((y 0))
    (cons1 (incf y)))

  ;;; => (1 . 1)

Example:

  The following expression demonstrates the usage of the INITFORM field

  (let ((expr '(incf y)))
    (once-only ((var `(1+ ,expr)))
      `(list ',expr ,var ,var)))

  ;;; =>
  ;;; (let ((#1=#:VAR123 (1+ (incf y))))
  ;;;   (list '(incf y) #1# #1))

  which could be used like so

  (defmacro print-succ-twice (expr)
    (once-only ((var `(1+ ,expr)))
      `(format t "Expr: ~s, Once: ~s, Twice: ~s~%" ',expr ,var ,var)))

  (let ((y 10))
    (print-succ-twice (incf y)))

  ;;; >>
  ;;; Expr: (INCF Y), Once: 12, Twice: 12
