LOOP
---

### FUNCTION

`loop` is Common Lisp's built-in iteration macro. It functions as a small
language of its own, embedded within Lisp.

#### THE `LOOP` MACRO

  `loop` is the standard iteration facility in Common Lisp. It is a macro that
  expands into a combination of `let`/`let*` bindings, a `block`, and a
  `tagbody`, and it can express nearly every common iteration pattern —
  counting, walking lists, walking vectors, walking hash tables, accumulating
  results, and terminating early — inside a single, self-contained form.

  There are two distinct ways to write a `loop` form: the **simple loop** and
  the **extended loop**. Which one is in effect is decided purely by what the
  body looks like, so it is worth understanding the distinction before anything
  else.

SIMPLE LOOP

  A simple loop is a `loop` form whose body consists only of ordinary compound
  forms — no loop keywords appear anywhere. In that case, `loop` behaves as an
  infinite loop: each form in the body is evaluated in order, and once the last
  one has been evaluated, execution returns to the first form and the cycle
  repeats forever.

    (let ((i 0))
      (loop
        (incf i)
        (when (= i 3)
          (return i))))
    ;=> 3
    
  A simple loop establishes an implicit block named `nil` around itself, so
  `(return value)` — or `return-from nil`, `throw`, or `go` to an outer tag — is
  the way to stop it. Without an explicit exit, a simple loop never terminates
  on its own.

EXTENDED LOOP

  An extended loop is a `loop` form whose body contains atomic expressions
  rather than only compound forms — that is, it contains loop keywords such as
  `for`, `collect`, `when`, and so on. This is the form of `loop` most code
  actually uses, and it is what the rest of this document covers.

    (loop for i from 1 to 3
          do (print i))
    
  The body of an extended loop is divided into **clauses**. Each clause begins
  with a loop keyword and is followed by some number of forms, the exact number
  and shape being dictated by that keyword (and by any auxiliary keywords — also
  called *prepositions* — that appear within the clause). For example:

    (loop for i from 1 to (compute-top-value)   ; clause 1
          while (not (unacceptable i))          ; clause 2
          collect (square i)                    ; clause 3
          do (format t "Working on ~D now" i)   ; clause 4
          when (evenp i)                        ; clause 5
            do (format t "~D is a non-odd number" i)
          finally (format t "About to exit!"))  ; clause 6
    
  Here `from` and `to` are prepositions belonging to the `for` clause; they mark
  where stepping begins and ends.

LOOP KEYWORDS ARE NOT REAL KEYWORDS

  Symbols like `for`, `collect`, `when`, and `do` are **not** keywords in the
  Lisp sense (they are not interned in the `keyword` package, and they do not
  begin with `:`). They are ordinary symbols that `loop` recognizes *by name*,
  regardless of which package they come from. This is why `loop` code can be
  written without importing anything special, and why writing `cl:for` or
  `my-package::for` works exactly the same as writing `for` — `loop` only looks
  at the symbol's name string.

  Because recognition is by name and not by package or identity, shadowing or
  locally rebinding a symbol like `collect` as a variable does not stop `loop`
  from treating it as a keyword inside a `loop` form. Loop keywords occupy their
  own namespace, separate from ordinary Lisp symbols.

#### COUNTING

    (loop for i from 1 to 3
          do (print i))
    ; 1
    ; 2
    ; 3

    (loop for i from 10 downto 1 by 3
          do (print i))
    ; 10
    ; 7
    ; 4
    ; 1

    (loop for i below 3
          do (print i))
    ; 0
    ; 1
    ; 2

The prepositions are grouped into three families, and at most one from each
family may appear in a single clause:

- starting point: `from`, `upfrom`, `downfrom` (default `0`)
- ending point: `to`, `upto`, `downto`, `below`, `above`
- step size: `by` (default `1`, and it must be positive — use
  `downto`/`downfrom`/`above` to count down rather than supplying a negative
  `by`)

`to`/`upto`/`downto` are inclusive limits; `below` and `above` are exclusive
limits. Mixing an ascending preposition (`upto`, `below`) with a descending
direction, or vice versa, is a common source of an off-by-one loop that silently
runs zero times — pick the family that matches the direction you intend.

#### WALKING A LIST: `IN` AND `ON`

    (loop for item in '(1 2 3)
          do (print item))
    ; 1
    ; 2
    ; 3

    (loop for item in '(1 2 3 4 5) by #'cddr
          do (print item))
    ; 1
    ; 3
    ; 5

    (loop for sublist on '(a b c d)
          collect sublist)
    ;=> ((A B C D) (B C D) (C D) (D))

`in` binds the variable to successive *elements* of a list, stepping with `cdr`
by default (a different stepping function can be supplied with `by`). `on` binds
the variable to successive *tails* (conses) of the list rather than to the
elements themselves — a distinction that matters if the body needs to see or
modify the rest of the list, not just the current element.

#### REPEATED COMPUTATION: `=` / `THEN`

    (loop for item = 1 then (+ item 10)
          for iteration from 1 to 5
          collect item)
    ;=> (1 11 21 31 41)

`for var = form1 then form2` sets `var` to `form1` on the first iteration and
re-evaluates `form2` on every iteration after that. If `then form2` is omitted,
`form1` itself is re-evaluated on every subsequent iteration. This subclause
provides no termination test of its own — some other clause (`for`, `while`,
`repeat`, and so on) must end the loop, or it runs forever.

#### SEQUENTIAL VS. PARALLEL STEPPING: `AND`

By default, multiple `for`/`as` clauses step **sequentially** — each one sees
the *already-updated* value of the variables before it in the same iteration:

    (loop for x from 1 to 5
          for y = nil then x
          collect (list x y))
    ;=> ((1 NIL) (2 2) (3 3) (4 4) (5 5))

Joining clauses with `and` instead makes stepping **parallel** — every
right-hand side is evaluated using the *previous* iteration's values, as if by
`do*` versus `do`:

    (loop for x from 1 to 5
          and y = nil then x
          collect (list x y))
    ;=> ((1 NIL) (2 1) (3 2) (4 3) (5 4))

This sequential-by-default, parallel-with-`and` behavior applies uniformly to
`for`/`as` and to `with`, described next.

##### LOCAL VARIABLES: `WITH`

`with` introduces a variable that is local to the loop but is initialized only
once, rather than being stepped on each iteration — it behaves much like a
single `let` clause.

    (loop with a = 1
          with b = (+ a 2)
          with c = (+ b 3)
          return (list a b c))
    ;=> (1 3 6)

Successive `with` clauses see each other's values, because initialization is
sequential by default (as if by `let*`). Joining them with `and` forces parallel
initialization instead (as if by `let`), so later clauses cannot see earlier
ones:

    (loop with a = 1
          and b = 2
          and c = 3
          return (list a b c))
    ;=> (1 2 3)

##### ACCUMULATING RESULTS

Six constructs accumulate a value across iterations and, unless told otherwise,
return that value when the loop finishes. Each also has an `-ing` spelling
(`collecting`, `summing`, and so on) that behaves identically — use whichever
reads better.

| Clause     | Accumulates                                   | Default result |
|------------|-----------------------------------------------|----------------|
| `collect`  | one value per iteration                       | a list         |
| `append`   | list-valued forms, concatenated               | a list         |
| `nconc`    | list-valued forms, destructively concatenated | a list         |
| `count`    | number of times *form* is true                | a number       |
| `sum`      | running total                                 | a number       |
| `maximize` | largest value seen                            | a number       |
| `minimize` | smallest value seen                           | a number       |


    (loop for i in '(bird 3 4 turtle (1 . 4) horse cat)
          when (symbolp i) collect i)
    ;=> (BIRD TURTLE HORSE CAT)

    (loop for x in '((a) (b) ((c)))
          append x)
    ;=> (A B (C))

    (loop for i in '(a b nil c nil d e)
          count i)
    ;=> 5

    (loop for i in '(2 1 5 3 4)
          maximize i)
    ;=> 5

    (loop for i in '(1 2 3 4 5)
          sum i)
    ;=> 15

By default, every accumulation clause in a loop feeds the same implicit
result. Clauses can be combined freely as long as they accumulate compatible
kinds of values — `collect`/`append`/`nconc` may be mixed with each other, and
`sum`/`count` may be mixed with each other, but mixing a list accumulation with
a numeric one requires directing at least one of them elsewhere.

That "elsewhere" is the `into` preposition, which names a local variable to
accumulate into instead of the loop's implicit result. A variable introduced
with `into` behaves like a `with` variable and is available in a `finally`
clause:

    (loop for name in '(fred sue alice joe june)
          as age in '(22 26 19 20 10)
          append (list name age) into pairs
          count name into how-many
          sum age into total-age
          finally (return (values (round total-age how-many) pairs)))
    ;=> 19, (FRED 22 SUE 26 ALICE 19 JOE 20 JUNE 10)

#### TERMINATING A LOOP

REPEAT

    (loop repeat 3
          do (format t "hi~%"))

Runs the body a fixed number of times, evaluating the count expression once, up
front. A count of zero or less means the body never runs.

WHILE and UNTIL

    (loop while (hungry-p) do (eat))
    (loop until (not (hungry-p)) do (eat))

`while` continues iteration as long as its form is true; `until` is the
complement and continues as long as its form is false. Either may appear
anywhere in the clause list, not only at the start, and — unlike
`always`/`never`/`thereis` below — reaching either one runs any `finally` clause
afterward.

ALWAYS, NEVER, THEREIS

    (loop for i from 0 to 10
          always (< i 11))
    ;=> T

    (loop for i from 0 to 10
          never (> i 11))
    ;=> T

    (loop for i from 0
          thereis (when (> i 10) i))
    ;=> 11

`always` stops the loop and returns `nil` the first time its form is false,
otherwise defaults to returning `t`. `never` stops and returns `nil` the first
time its form is true, otherwise defaults to `t`. `thereis` stops and returns
the form's value the first time it is non-`nil`, otherwise defaults to
`nil`. Because all three exit via `return-from` directly, they **skip any
`finally` clause** — a detail that differs from `while`/`until` and is easy to
overlook.

LOOP-FINISH

  Within a nested conditional or nested Lisp form, calling `(loop-finish)` ends
  the loop the same way a normal termination clause would: the epilogue runs,
  `finally` clauses execute, and any accumulated result is returned. It is the
  tool of choice when a natural loop clause does not fit the control flow you
  need but you still want a normal (not an early/bypassing) exit.

#### UNCONDITIONAL EXECUTION: `DO` AND `RETURN`

    (loop for i from 1 to 3
          do (print i)
             (print (* i i)))

`do` (or `doing`) evaluates every form given to it, in order, on each iteration;
it is the escape hatch for arbitrary side-effecting code, and unlike most other
clauses it accepts any number of forms.

`return` immediately returns its one form's value(s) from the loop, equivalent
to `do (return-from nil form)` (or the name given by `named`, see below). Unlike
`always`/`never`/`thereis`, a `return` also skips `finally`.

#### CONDITIONAL EXECUTION: `WHEN`, `UNLESS`, `IF`

    (loop for i in '(1 2 3 a 4 5)
          when (not (numberp item))
            return (error "non-numeric value: ~s" item))

`when` and `if` are synonyms; `unless` is their complement. The clause that
follows the test is executed only when the test passes (or, for `unless`, only
when it fails). An optional `else` supplies an alternative clause, and `end`
optionally marks where the conditional clause stops — useful mainly when clauses
are nested and the default "next keyword ends it" rule would attach an `and` to
the wrong level.

Clauses under a test can be chained with `and` to execute several actions
conditionally:

    (loop for i from 1 to 10
          when (> i 5)
            collect i into number-list
            and count i into number-count
          finally (return (values number-count number-list)))
    ;=> 5, (6 7 8 9 10)

The pseudo-variable `it` refers to the value of the test itself, letting you
avoid recomputing it:

    (loop for i in '(1 2 3 4 5 6)
          when (and (> i 3) i)
          collect it)
    ;=> (4 5 6)

#### NAMING THE LOOP AND BRACKETING EXECUTION

`named` gives the loop's implicit block a name, in place of the default `nil`,
so `return-from that-name` can be used — indispensable once a `loop` sits inside
another `loop`, since plain `return` only exits the innermost one:

    (loop named outer
          for i from 1 to 10
          do (print i)
          do (return-from outer 'done))

`initially` and `finally` schedule code to run once, before the first iteration
and after the last one respectively, regardless of where in the clause list they
are written:

    (loop for i from 1 to 10
          when (> i 5)
            collect i
          finally (format t "done collecting~%"))

A caveat: an explicit `return`/`return-from`/`throw`/`go` from inside the loop
body exits immediately and skips the epilogue — `finally` will not run in that
case. This is the same behavior noted above for `return`, `always`, `never`, and
`thereis`.

#### ITERATING A VECTOR OR OTHER 1-D SEQUENCE: `ACROSS`

`for var across vector-form` walks the elements of any vector — a simple vector,
a string, a bit-vector, or an array with a fill pointer — stopping at the end of
the *active* elements (respecting the fill pointer, if any).

    (loop for char across "hello"
          do (write-char char))
    ; hello

The important restriction: `across` only works on one-dimensional arrays. It
cannot walk a general multidimensional array directly, and it has no built-in
facility for non-vector sequences — a plain list is walked with `in`/`on`, not
`across`. There is also no built-in `for`-clause form for a general sequence
that might be a list or a vector; code that needs to accept either typically
dispatches with `etypecase` or normalizes to a vector first, since `loop` itself
does not provide a sequence-generic clause.

#### ITERATING A HASH TABLE: `BEING EACH HASH-KEY` / `HASH-VALUE`

    (loop for k being each hash-key of table
          using (hash-value v)
          do (format t "~a -> ~a~%" k v))

`being` introduces this subclause, and `each`/`the` are purely cosmetic filler
words that can be included or dropped freely. The variable can walk either the
keys (`hash-key`/`hash-keys`) or the values (`hash-value`/`hash-values`); the
matching one is then obtained with `using (hash-value var)` or `using (hash-key
var)`. `in` and `of` are interchangeable prepositions here — both simply
introduce the hash table.

Three points deserve special attention:

- The order in which entries are visited is unspecified. Do not depend on
  insertion order, key order, or any other ordering unless the hash table
  implementation you are targeting documents one.
- Modifying the hash table's set of keys during iteration (adding or removing
  entries) has undefined consequences for the traversal, in the same way that
  mutating a list you are `cdr`-ing down can misbehave. Changing the *value*
  associated with an existing key while iterating is safe; changing the key set
  is not.
- Empty slots are simply skipped, so the count of iterations always matches the
  table's entry count at the time iteration begins.

#### ITERATING A PACKAGE'S SYMBOLS: `BEING EACH SYMBOL`

    (loop for s being each symbol in package
          do (print s))

This subclause also uses `being`/`each`/`the` as connective words. Three
variants control which symbols are visited:

- `symbol`/`symbols` — every symbol accessible in the package (inherited symbols
  included)
- `present-symbol`/`present-symbols` — symbols actually present in the package,
  excluding purely inherited ones
- `external-symbol`/`external-symbols` — only the package's external symbols

The package argument is optional; when omitted, the current value of `*package*`
is used, which is easy to get wrong in code loaded from a file, where
`*package*` may not be the package the author had in mind — passing the package
explicitly is the safer habit. Supplying a package designator that does not name
an existing package signals a `package-error`. As with hash tables, the order in
which symbols are produced is unspecified, and mutating the package's symbol
table (interning or uninterning symbols) while the loop is in progress is not
something the traversal is guaranteed to handle gracefully.

#### DESTRUCTURING PITFALLS

A `for`/`as`/`with` variable may be a destructuring pattern instead of a plain
symbol:

    (loop for (a b c) in '((1 2 4.0) (5 6 8.3))
          collect (list c b a))
    ;=> ((4.0 2 1) (8.3 6 5))

If a pattern has more variables than the value being destructured supplies, the
extra variables are simply bound to `nil` — no error is signaled, which can hide
a bug where you expected a fixed-length list but occasionally received a shorter
one. Conversely, extra values beyond what the pattern needs are silently
discarded. `nil` may be used inside the pattern as a placeholder for a position
whose value should be ignored entirely.

Binding the same variable name twice within one loop's variable clauses —
whether directly or via destructuring — is an error signaled at macro-expansion
time, so this particular mistake is at least caught early rather than silently
shadowing.

#### `FINALLY` IS NOT ALWAYS REACHED

As mentioned above, `always`, `never`, `thereis`, and explicit
`return`/`return-from`/`throw`/`go` all leave the loop without running
`finally`. If cleanup code must run no matter how the loop ends, do not rely on
`finally` alone for it — an explicit `unwind-protect` around the whole `loop`
form is the reliable option when that guarantee is required.

#### SIDE EFFECTS AND EVALUATION ORDER

Prepositions inside a `for` clause are evaluated strictly left to right, and
forms controlled by different prepositions are genuinely independent expressions
— so writing side effects inside them can change behavior in surprising ways
depending on clause order:

    (let ((x 1)) (loop for i from x by (incf x) to 10 collect i))
    ;=> (1 3 5 7 9)

    (let ((x 1)) (loop for i by (incf x) from x to 10 collect i))
    ;=> (2 4 6 8 10)

Both loops look nearly identical, but reordering `from` and `by` changes which
value of `x` is captured first. This is rarely intentional; as a rule, keep the
expressions inside `loop` prepositions free of side effects unless the
evaluation order has been checked carefully.

#### FOR MORE INFORMATION, SEE THE FOLLOWING REFERENCES

- https://gigamonkeys.com/book/loop-for-black-belts
- https://novaspec.org/cl/6_1_The_LOOP_Facility
- https://lispcookbook.github.io/cl-cookbook/iteration.html
- http://clhs.lisp.se/Body/m_loop.htm#loop


