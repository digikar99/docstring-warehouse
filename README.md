docstring-warehouse
---

System used by [docstring-harvester](https://codeberg.org/digikar/docstring-harvester) to locate the docstrings.

Each sub-directory in the current directory corresponds to a lisp package. They may
have sub-sub-directories corresponding to \"sub\" packages. Finally, the leaves are markdown files which map the third-level heading (eg. function, class, type, etc) to the docstring.

Huge credits for existing projects!

- [metaspec](https://metaspec.dev)
- [more-docstrings](https://github.com/ciel-lang/more-docstrings)

How to use:

1. Install ql-https if you haven't already:

```sh
curl https://raw.githubusercontent.com/rudolfochrist/ql-https/refs/tags/1.0/install.sh | bash
```

2. Install ultralisp:

```lisp
(ql-dist:install-dist "http://dist.ultralisp.org/" :prompt nil)
```

3. Install docstring-harvester and docstring-warehouse

```lisp
(ql:quickload '("docstring-harvester" "docstring-warehouse"))
```

4. Load docstrings:

```lisp
(docstring-harvester:load-docstrings :common-lisp :alexandria)
```

Currently only these two lisp packages are supported!

