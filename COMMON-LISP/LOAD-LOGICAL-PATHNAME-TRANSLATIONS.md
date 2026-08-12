LOAD-LOGICAL-PATHNAME-TRANSLATIONS
---

### FUNCTION

Reads logical pathname translations from SYS:SITE;HOST.TRANSLATIONS.NEWEST,
with HOST replaced by the supplied parameter. Returns T on success.

If HOST is already defined as logical pathname host, no file is loaded and NIL
is returned.

The file should contain a single form, suitable for use with
(SETF LOGICAL-PATHNAME-TRANSLATIONS).

Note: behaviour of this function is highly implementation dependent, and
historically it used to be a no-op in SBCL -- the current approach is somewhat
experimental and subject to change.
