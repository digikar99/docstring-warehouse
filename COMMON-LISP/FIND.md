FIND
---

### FUNCTION


Search for ITEM in SEQUENCE, return ITEM.

Example:

  (find 20 '(10 20 30)) ;; => 20
  (find "foo" '("abc" "foo") :test #'string-equal) ;; => "foo"

See also: `find-if', `position', `search', `index', `elt'…

Read more:

- https://cl-community-spec.github.io/pages/find.html
- https://lispcookbook.github.io/cl-cookbook/data-structures.html
