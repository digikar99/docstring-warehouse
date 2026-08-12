DIRECTORY
---

### FUNCTION

Return a list of PATHNAMEs, each the TRUENAME of a file matching PATHSPEC.

Note that the interaction between this ANSI-specified TRUENAMEing and
the semantics of the Unix filesystem (symbolic links..) means this
function can sometimes return files which don't have the same
directory as PATHSPEC.

If :RESOLVE-SYMLINKS is NIL, don't resolve symbolic links in matching
filenames.
