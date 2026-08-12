UNWIND-PROTECT
---

### FUNCTION

UNWIND-PROTECT protected cleanup*

Evaluate the form PROTECTED, returning its values. The CLEANUP forms are
evaluated whenever the dynamic scope of the PROTECTED form is exited (either
due to normal completion or a non-local exit such as THROW).
