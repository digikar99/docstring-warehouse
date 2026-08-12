(defsystem "docstring-warehouse"
  :description "System used by [docstring-harvester](https://codeberg.org/digikar/docstring-harvester) to locate the docstrings.

Each sub-directory in the current directory corresponds to a lisp package. They may
have sub-sub-directories corresponding to \"sub\" packages. Finally, the leaves are markdown files which map the third-level heading (eg. function, class, type, etc) to the docstring.")
