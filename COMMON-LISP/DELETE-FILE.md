DELETE-FILE
---

### FUNCTION

Delete the specified FILE.

If FILE is a stream, on Windows the stream is closed immediately. On Unix
platforms the stream remains open, allowing IO to continue: the OS resources
associated with the deleted file remain available till the stream is closed as
per standard Unix unlink() behaviour.
