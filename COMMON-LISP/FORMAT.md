FORMAT
---

### FUNCTION

FORMAT is the standard means of producing formatted text output in Common
Lisp. It takes a destination, a control string, and a set of arguments, and it
produces text by interpreting the control string as a small formatting language:
ordinary characters are copied to the output as they are, while a tilde (~)
introduces a directive that consumes zero or more arguments and writes something
in their place.

A call has the shape:

    (format destination control-string argument*)

The destination determines where the text goes. If destination is nil, FORMAT
builds a string and returns it rather than writing anywhere. If destination is
t, the output goes to standard output, and the return value is nil. If
destination is a stream, the output is written to that stream, again returning
nil. If destination is a string with a fill pointer, the output is appended to
that string.

The control string is composed of ordinary text and embedded directives. A
directive begins with a tilde, is optionally followed by prefix parameters
separated by commas, is optionally followed by a colon modifier, an at sign
modifier, or both in either order, and ends with a single letter or symbol
naming the directive. The case of that letter is not significant. A prefix
parameter is usually a signed decimal integer; a single quote followed by a
character may be used instead to supply that character as the parameter. The
letter V (or v) may appear in place of a numeric parameter, in which case the
corresponding value is taken from the argument list at run time rather than
written literally in the control string. The character # may appear in place of
a parameter to mean the number of arguments not yet processed.

The letter V and the character # deserve a brief illustration, since they appear
throughout the directives below. Where a directive ordinarily takes a numeric
parameter written directly in the control string, V may be written instead to
draw that number from the argument list at the point the directive runs, and #
may be written to mean the count of arguments not yet consumed.

    (format nil "~VD" 5 42)  =>  "   42"
    (format nil "~#A and ~A" "first" "second")  =>  "2 and second"


QUICK REFERENCE

  The directives introduced above are summarized here for ease of lookup,
  grouped in the order in which they were presented. Each entry names the
  directive and, briefly, its purpose. See the discussion above for parameters,
  modifiers, and examples.

  New readers are encouraged to begin with Part One, since ~A, ~S, ~D, ~%, and
  ~& already cover most everyday needs, and to treat Part Two as a reference
  (besides the references themselves!) to consult only once a particular
  formatting problem calls for it. Once these directives become familiar, the
  shorthand notation used throughout this document, with its tildes, prefix
  parameters, and modifiers, reads almost as naturally as an ordinary sentence
  describing the intended output, and a moderately complex control string can
  often replace what would otherwise be several lines of explicit string
  concatenation.

Everyday directives.

    ~A       aesthetic output of the next argument, unquoted
    ~S       standard, readable output of the next argument, quoted
    ~D       decimal integer
    ~B       binary integer
    ~O       octal integer
    ~X       hexadecimal integer
    ~F       fixed format floating point
    ~E       exponential floating point
    ~$       monetary floating point, fixed digits after the point
    ~%       newline
    ~&       fresh line, only if not already at the start of a line
    ~~       a literal tilde
    ~C       a single character
    (tilde followed by an actual newline)   an ignored newline in the source

Advanced directives.

    ~R       English cardinal, ordinal, or Roman numeral, or radix n
    ~P       pluralizing letter s, or ies with the at sign modifier
    ~*       skip, back up, or jump among arguments
    ~[ ~;~]  conditional selection among clauses
    ~@[ ~]   conditional processing based on a single non nil test
    ~{ ~}    iteration over a list of arguments
    ~?       recursive processing of a nested control string
    ~( ~)    case conversion of enclosed output
    ~T       tabulation to a column
    ~< ~>    field justification, or a pretty printer logical block
    ~_       conditional newline, within a logical block
    ~I       relative indentation, within a logical block
    ~/ /     a call to a user defined formatting function
    ~;       clause separator, within an enclosing construct
    ~^       early escape from an enclosing construct
    ~|       page separator
    ~G       fixed or exponential floating point, chosen automatically


PART ONE: EVERYDAY FORMAT

This part covers the handful of directives that account for the great majority
of FORMAT usage: inserting values into text, printing numbers, and controlling
line breaks.

Tilde A. Aesthetic output.

  ~A prints the next argument as though by PRINC: without quotation marks around
  strings and without escape characters. This is generally the right directive
  for inserting a piece of text or a symbol into a sentence.

    (format nil "Hello, ~A!" "world")  =>  "Hello, world!"
    (format nil "The winner is ~A." 'alice)  =>  "The winner is ALICE."

  If the argument is nil, ~A prints NIL. With the colon modifier, ~:A prints an
  argument of nil as () instead, though nil occurring inside a larger structure
  such as a list is still printed as NIL.

  A numeric parameter after the tilde requests padding: ~mincolA pads the output
  on the right with spaces so that it occupies at least mincol columns, which is
  useful for aligning columns of text. The at sign modifier moves the padding to
  the left instead: ~mincol@A right justifies within the field.

      (format nil "~10A|" "cat")  =>  "cat       |"
      (format nil "~10@A|" "cat")  =>  "       cat|"

Tilde S. Standard, or readable, output.

  ~S is like ~A, except that the argument is printed as though by PRIN1, meaning
  that strings are printed with quotation marks and escape characters are
  included where needed. The result is intended to be suitable as input to
  READ. ~S accepts the same padding parameters as ~A.

      (format nil "~S" "cat")  =>  "\"cat\""
      (format nil "~S" 'cat)  =>  "CAT"

Tilde D, Tilde B, Tilde O, and Tilde X. Printing integers.

  ~D prints the next argument, which should be an integer, in decimal. ~B prints
  in binary, ~O prints in octal, and ~X prints in hexadecimal; apart from the
  radix, all four behave identically. If the argument is not an integer, it is
  printed as though by ~A instead.

      (format nil "~D" 42)  =>  "42"
      (format nil "~X" 255)  =>  "FF"
      (format nil "~B" 5)  =>  "101"

  A first parameter gives a minimum column width, padding with spaces on the
  left: ~mincolD. A second parameter, following a comma, names the padding
  character to use instead of a space.

      (format nil "~5D" 42)  =>  "   42"
      (format nil "~5,'0D" 42)  =>  "00042"

  The at sign modifier forces a sign to be printed even for positive numbers,
  and the colon modifier inserts a comma between every group of three digits.

      (format nil "~:D" 1000000)  =>  "1,000,000"
      (format nil "~@D" 42)  =>  "+42"

  Negative arguments are handled without any special instruction: a minus sign
  is printed before the digits, and it counts toward the requested field width
  along with them.

      (format nil "~5D" -42)  =>  "  -42"

  A third parameter, following a second comma, replaces the comma used for digit
  grouping with a different character, and a fourth parameter changes how many
  digits fall in each group.

      (format nil "~,,' ,4:D" 1000000)  =>  "100 0000"

Tilde F, Tilde E, and Tilde Dollarsign. Printing floating point numbers.

  ~F prints the next argument as a floating point number in fixed format,
  meaning ordinary decimal notation without an exponent.

      (format nil "~F" 3.14159)  =>  "3.14159"

  Two parameters are typically the most useful: ~w,dF requests a total field
  width of w columns with exactly d digits after the decimal point.

      (format nil "~6,2F" 3.14159)  =>  "  3.14"

  ~E prints a floating point number in exponential, or scientific, notation
  instead, again taking width and digit count parameters of the same kind.

      (format nil "~E" 12345.6)  =>  "1.23456e+4"

  ~$ is specialized for monetary amounts. It prints a fixed number of digits
  after the decimal point, two by default, and at least one digit before it.

      (format nil "~$" 5)  =>  "5.00"
      (format nil "~2,4$" 3.5)  =>  "0003.50"

  A third directive, ~G, chooses automatically between fixed and exponential
  notation depending on the magnitude of the argument, printing very large or
  very small numbers in exponential form and printing ordinary sized numbers in
  fixed form, much as the Lisp printer itself does for floating point values. It
  is less commonly needed than ~F, since a program usually knows in advance
  which form is appropriate, but it is available for cases where the magnitude
  of the argument cannot be predicted in advance.

Tilde Percent, Tilde Ampersand, and Tilde Tilde. Newlines and literal
characters.

  ~% outputs a newline character. A numeric parameter requests that many
  newlines: ~3% outputs three.

  ~& is a courteous alternative: it outputs a newline only if the destination is
  not already at the start of a line, so it avoids introducing unwanted blank
  lines when used repeatedly.

  ~~ outputs a literal tilde, since a bare tilde in the control string would
  otherwise be read as the start of a directive. A parameter requests that many
  tildes.

      (format nil "100~~")  =>  "100~"

Tilde C. Printing a single character.

  ~C prints the next argument, which should be a character, largely as though by
  WRITE-CHAR.

      (format nil "~C" #\A)  =>  "A"

  With the colon modifier, ~:C spells out the name of the character when it is
  not an ordinary printing character, which is often more pleasant to read in a
  message shown to a person.

      (format nil "~:C" #\Space)  =>  "Space"

Tilde Newline. Suppressing an unwanted line break in the source.

  When a tilde is immediately followed by an actual newline in the control
  string, that newline, along with any following spaces or tabs, is simply
  omitted from the output. This is useful for wrapping a long control string
  across several lines of source code without inserting unwanted whitespace into
  the result.

Putting these together, a typical everyday use of FORMAT looks like this:

    (format nil "~A has ~D item~:P worth ~$ dollars.~%" "Alice" 3 19.5)
    => "Alice has 3 items worth 19.50 dollars.\n"

(The ~:P directive used above prints a pluralizing letter s and is introduced in
the next part.)

A reader who only ever uses ~A, ~S, ~D, ~F, ~%, ~&, and ~~ will already be able
to produce the great majority of ordinary formatted output. The remainder of
this document describes more specialized facilities for readers who need them.


PART TWO: ADVANCED FORMAT

This part covers directives for radix control beyond the common cases, argument
selection, conditional and repeated output, case conversion, column alignment,
and interaction with the Lisp pretty printer. These facilities are powerful but
are needed far less often than the directives already described.

Tilde R. Radix control and English numerals.

  With a numeric parameter, ~nR prints the next argument in radix n, behaving
  otherwise like ~D. Without any parameter, ~R takes on a different meaning
  entirely: it prints the argument spelled out as an English cardinal number.

    (format nil "~R" 4)  =>  "four"

  The colon modifier requests an ordinal instead, and the at sign modifier
  requests a Roman numeral.

    (format nil "~:R" 4)  =>  "fourth"
    (format nil "~@R" 4)  =>  "IV"

Tilde P. Pluralization.

  ~P prints a lowercase s unless the next argument is the integer 1, in which
  case it prints nothing. This directive does not itself insert the preceding
  argument into the output; it merely inspects one argument and decides whether
  to add the letter. It is generally combined with a preceding numeric directive
  and the colon modifier, which tells ~P to reuse the previous argument rather
  than consuming a new one.

    (format nil "~D item~:P" 1)  =>  "1 item"
    (format nil "~D item~:P" 5)  =>  "5 items"

  The at sign modifier prints ies instead of s, which is convenient for words
  such as "party" that pluralize irregularly.

    (format nil "~D part~:@P" 3)  =>  "3 parties"

Tilde Asterisk. Skipping and revisiting arguments.

  ~* ignores the next argument without printing anything, and a parameter n
  causes n arguments to be ignored. The colon modifier reverses direction,
  backing up to reprocess an earlier argument: ~:* backs up by one, and ~n:*
  backs up by n. The at sign modifier jumps to an absolute position in the
  argument list: ~n@* moves to the nth argument, counting from zero, so that
  subsequent directives continue from there.

Tilde Left Bracket. Conditional expressions.

  ~[clause0~;clause1~;...~;clausen~] chooses one of several control string
  clauses, separated by ~;, based on the value of the next argument, which
  should be a non negative integer used as a zero based index into the
  clauses. Once a clause has been selected and processed, control resumes after
  the closing ~].

    (format nil "~[cat~;dog~;bird~]" 1)  =>  "dog"

  If the last separator before the closing bracket is ~:; rather than ~;, the
  final clause becomes a default that is used whenever no other clause matches.

  A useful special case arises when the construct contains exactly two clauses
  separated by ~:; with no argument consumed as an index; instead,
  ~[false-clause~:;true-clause~] tests the argument as a boolean and selects the
  second clause whenever the argument is not nil.

  The at sign modifier gives a further variant, ~@[clause~], which tests the
  next argument for being non nil. If the argument is non nil, the enclosed
  clause is processed, and the argument itself remains available to be consumed
  by directives within that clause; if the argument is nil, the clause is
  skipped and the argument is discarded.

Tilde Left Brace. Iteration.

  ~{control-string~} treats the next argument as a list and repeatedly
  reprocesses the enclosed control string, consuming as many elements from that
  list as the control string requires, until the list is exhausted.

    (format nil "Names:~{ ~A~}." '("Alice" "Bob"))
    => "Names: Alice Bob."

  A prefix parameter n limits the number of repetitions to at most n. The colon
  modifier, ~:{...~}, treats the argument as a list of sublists, processing one
  sublist per repetition; this is convenient for printing a list of pairs or
  records.

    (format nil "~:{<~A,~A> ~}" '((a 1) (b 2) (c 3)))
    => "<A,1> <B,2> <C,3> "

  The at sign modifier, ~@{...~}, dispenses with the enclosing list entirely and
  instead consumes the remaining top level arguments directly as the material to
  iterate over. The two modifiers may be combined.

  Within any of these forms, the ~^ directive, described later in this part, may
  be used to end the repetition early once some condition on the remaining
  arguments becomes true, rather than waiting for the argument list to be fully
  exhausted.

Tilde Question Mark. Recursive processing.

  ~? treats the next argument as a control string and the one after it as a list
  of arguments, processing them exactly as a nested call to FORMAT would, then
  resumes the outer control string once the nested processing finishes. With the
  at sign modifier, ~@? instead consumes a single string argument and splices
  its own directives into the surrounding argument stream, so that any arguments
  it needs are drawn from the remaining arguments of the enclosing call rather
  than from a separate list.

Tilde Left Paren and Tilde Right Paren. Case conversion.

  ~(control-string~) processes the enclosed control string and converts the
  resulting text to lowercase. The colon modifier capitalizes every word, the at
  sign modifier capitalizes only the first word and lowercases the rest, and
  both modifiers together convert the text to uppercase.

    (format nil "~(HELLO~)")  =>  "hello"
    (format nil "~:(hello there~)")  =>  "Hello There"
    (format nil "~@(hello there~)")  =>  "Hello there"

  When one case conversion is nested inside another, the outer conversion takes
  precedence over the inner one.

Tilde T. Tabulation.

  ~colnum,colincT moves to a particular output column, inserting spaces as
  needed. If the cursor has already passed colnum, it advances instead to the
  next multiple of colinc beyond colnum. Both parameters default to 1. The at
  sign modifier, ~colrel,colinc@T, is relative rather than absolute: it always
  outputs at least colrel spaces and then continues to the next multiple of
  colinc.

Tilde Less Than Sign and Tilde Greater Than Sign. Column justification.

  ~mincol,colinc,minpad,padchar<segment0~;segment1~;...~>, terminated by ~>,
  justifies its contents within a field at least mincol columns wide. The
  segments, separated by ~;, are spaced apart so that the first is aligned to
  the left and the last to the right; with only one segment, it is right
  justified. The colon modifier adds spacing before the first segment as well,
  and the at sign modifier adds spacing after the last.

    (format nil "~20<~A~;~A~>" "left" "right")
    => "left           right"

  The minpad parameter, which defaults to zero, sets a minimum number of padding
  characters to place between segments, and the padchar parameter, which
  defaults to a space, sets which character is used for that padding. If the
  combined width of the segments and the required padding exceeds mincol, the
  field simply grows to accommodate them, widening in steps of colinc, which
  defaults to one.

Tilde Underscore, Tilde I, Tilde Slash, and the Tilde Less Than Sign logical
block form. Interaction with the pretty printer.

  These directives give FORMAT direct access to the dynamic line breaking
  facilities of the Lisp pretty printer, and they matter chiefly when producing
  output whose layout should adapt to the available line width, such as printed
  representations of Lisp code.

  ~_ requests a conditional newline, corresponding to PPRINT-NEWLINE, at a point
  where a line break may be inserted if the surrounding material does not fit on
  one line. The colon and at sign modifiers select among the different styles of
  conditional newline described for PPRINT-NEWLINE, namely linear, fill, miser,
  and mandatory breaking.

  ~n I requests a relative indentation of n columns for the enclosing block,
  corresponding to PPRINT-INDENT.

  ~/name/ calls a user defined function to perform formatting not covered by any
  built in directive; name identifies the function, optionally qualified by a
  package name.

  ~<...~:> without a plain semicolon inside behaves as a logical block,
  corresponding to PPRINT-LOGICAL-BLOCK, establishing a region within which the
  conditional newline directives above may insert breaks as the pretty printer
  sees fit. The portion of the control string within the block may be divided by
  ~; into a prefix, a body, and a suffix, which then play the same roles that
  the prefix and suffix arguments play in a direct call to PPRINT-LOGICAL-BLOCK.

  These four facilities are ordinarily used together rather than in isolation,
  since a logical block establishes the region in which conditional newlines and
  indentation become meaningful. A reader who needs to print Lisp forms, deeply
  nested data, or any other structure whose layout should reflow to fit the
  available width will find these directives considerably more convenient than
  computing line breaks by hand, but a reader whose formatting needs are
  simpler, such as printing a report or a table, will rarely need them at all.

Tilde Semicolon and Tilde Circumflex. Structural punctuation.

  ~; separates clauses within constructs such as ~[...~] and ~<...~> and does
  not by itself produce any output.

  ~^ is an escape mechanism. Within a ~{...~} iteration or a ~<...~>
  justification, it terminates the enclosing construct early once the relevant
  list of arguments has been exhausted. Used at the top level of a control
  string with no enclosing construct, it terminates the entire FORMAT operation
  early under the same condition. A parameter or comparison may be supplied to
  control precisely when the escape triggers.

Tilde Vertical Bar. Page separators.

  ~| outputs a page separator character where the underlying stream supports
  one; a parameter requests that many page separators.

On the ordering and nesting of directives.

  Several of the directives described in this part enclose a portion of the
  control string between an opening directive and a matching closing directive,
  among them ~[...~], ~{...~}, and ~<...~>. These constructs may be nested
  inside one another freely, and a directive such as ~; or ~^ that has meaning
  only within an enclosing construct always refers to the innermost construct
  that contains it. A control string that opens one of these constructs without
  a matching close, or that closes one that was never opened, is in error.

  When an argument is required by a directive but none remains, an error is
  signaled, except that the directives introduced in this part for skipping and
  revisiting arguments are, naturally, exempt from consuming an argument at
  all. When arguments remain unconsumed at the end of processing the control
  string, this is not by itself an error; the extra arguments are simply left
  unused.

A closing note on style.

  FORMAT directives do not, by themselves, bind any of the ordinary printer
  control variables, such as the variable controlling whether escape characters
  are produced, except where a specific directive is documented as doing so; ~S,
  for instance, is documented as printing as though escape characters were
  enabled, and ~D is documented as printing in decimal regardless of any ambient
  radix setting.


REFERENCES

- https://metaspec.dev/chap-22.html#sec_22_3
- https://metaspec.dev/f_format.html
- https://gigamonkeys.com/book/a-few-format-recipes
