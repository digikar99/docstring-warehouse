REQUIRE
---

### FUNCTION

Loads a module, unless it already has been loaded. PATHNAMES, if supplied,
   is a designator for a list of pathnames to be loaded if the module
   needs to be. If PATHNAMES is not supplied, functions from the list
   *MODULE-PROVIDER-FUNCTIONS* are called in order with MODULE-NAME
   as an argument, until one of them returns non-NIL.  User code is
   responsible for calling PROVIDE to indicate a successful load of the
   module.
