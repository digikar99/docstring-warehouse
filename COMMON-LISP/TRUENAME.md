TRUENAME
---

### FUNCTION

If PATHSPEC is a pathname that names an existing file, return
a pathname that denotes a canonicalized name for the file.  If
pathspec is a stream associated with a file, return a pathname
that denotes a canonicalized name for the file associated with
the stream.

An error of type FILE-ERROR is signalled if no such file exists
or if the file system is such that a canonicalized file name
cannot be determined or if the pathname is wild.

Under Unix, the TRUENAME of a symlink that links to itself or to
a file that doesn't exist is considered to be the name of the
broken symlink itself.
