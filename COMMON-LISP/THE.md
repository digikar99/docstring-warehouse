THE
---

### FUNCTION

Specifies that the values returned by FORM conform to the VALUE-TYPE.

CLHS specifies that the consequences are undefined if any result is
not of the declared type, but SBCL treats declarations as assertions
as long as SAFETY is at least 2, in which case incorrect type
information will result in a runtime type-error instead of leading to
eg. heap corruption. This is however expressly non-portable: use
CHECK-TYPE instead of THE to catch type-errors at runtime. THE is best
considered an optimization tool to inform the compiler about types it
is unable to derive from other declared types.
