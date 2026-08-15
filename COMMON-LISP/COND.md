COND
---

### FUNCTION

-- Macro: cond {↓clause}^{*} ⇒ {RESULT}^{*}

SYNTAX:

  ‘clause’ ::= (test-form {FORM}^{*})

ARGUMENTS AND VALUES:

  TEST-FORM: a form.

  FORMS: an implicit progn.

  RESULTS: the values of the FORMS in the first CLAUSE whose TEST-FORM
    yields true, or the primary value of the TEST-FORM if there are no FORMS
    in that CLAUSE, or else ‘nil’ if no TEST-FORM yields true.

DESCRIPTION:

  ‘cond’ allows the execution of FORMS to be dependent on TEST-FORM.

  TEST-FORMS are evaluated one at a time in the order in which they are
  given in the argument list until a TEST-FORM is found that evaluates to
  true.

  If there are no forms in that clause, the primary value of the
  TEST-FORM is returned by the ‘cond’ form.  Otherwise, the FORMS
  associated with this TEST-FORM are evaluated in order, left to right, as
  an implicit progn, and the values returned by the last FORM are returned
  by the ‘cond’ form.

  Once one TEST-FORM has yielded true, no additional TEST-FORMS are
  evaluated.  If no TEST-FORM yields true, ‘nil’ is returned.

EXAMPLES:

    (defun select-options ()
      (cond ((= a 1) (setq a 2))
            ((= a 2) (setq a 3))
            ((and (= a 3) (floor a 2)))
            (t (floor a 3))))  ;=> SELECT-OPTIONS
    (setq a 1)  ;=> 1
    (select-options)  ;=> 2
    a  ;=> 2
    (select-options)  ;=> 3
    a  ;=> 3
    (select-options)  ;=> 1
    (setq a 5)  ;=> 5
    (select-options)  ;=> 1, 2
