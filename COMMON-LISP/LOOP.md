LOOP
---

### FUNCTION


The basic LOOP structure is

(loop for x in (list x y z)
   do …)

"do" is for side effects.

Use "collect" to return results:

(loop for x in (list 1 2 3)
  collect (* x 10))

To iterate over arrays, use "across" instead of "in".

To iterate over hash-tables… try MAPHASH first :D

For many examples, see the CL Cookbook:
https://lispcookbook.github.io/cl-cookbook/iteration.html
