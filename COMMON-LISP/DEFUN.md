DEFUN
---

### FUNCTION

Define a function at top level.

Example:

(defun hello (name)
  "Say \"hello\" to NAME."
  (format t "Hello ~a!" name))

Define named parameters with &key:

(defun hello (name &key lisper)
  ...)

and use it like so: (hello "you" :lisper t)

Key parameters are NIL by default. Give them another default value like this:

(defun hello (name &key (lisper t))
  ...)

Read more:
https://gigamonkeys.com/book/functions.html
https://lispcookbook.github.io/cl-cookbook/functions.html
