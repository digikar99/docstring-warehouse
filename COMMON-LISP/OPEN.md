OPEN
---

### FUNCTION

Return a stream which reads from or writes to Filename.
  Defined keywords:
   :direction - one of :input, :output, :io, or :probe
   :element-type - type of object to read or write, default BASE-CHAR
   :if-exists - one of :error, :new-version, :rename, :rename-and-delete,
                       :overwrite, :append, :supersede or NIL
   :if-does-not-exist - one of :error, :create or NIL
   :external-format - :default
  See the manual for details.

  The following are simple-streams-specific additions:
   :class - class of stream object to be created
   :mapped - T to open a memory-mapped file
   :input-handle - a stream or Unix file descriptor to read from
   :output-handle - a stream or Unix file descriptor to write to
