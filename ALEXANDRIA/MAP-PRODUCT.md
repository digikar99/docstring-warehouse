MAP-PRODUCT
---

### FUNCTION

Returns a list containing the results of calling FUNCTION with one argument
from LIST, and one from each of MORE-LISTS for each combination of arguments.
In other words, returns the product of LIST and MORE-LISTS using FUNCTION.

Example:

 (map-product 'list '(1 2) '(3 4) '(5 6))
  => ((1 3 5) (1 3 6) (1 4 5) (1 4 6)
      (2 3 5) (2 3 6) (2 4 5) (2 4 6))

