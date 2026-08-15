DEFSTRUCT
---

### FUNCTION

  DEFSTRUCT is a macro used to define a new structure type in Common Lisp. It
  provides a concise way to introduce a named collection of slots, together with
  a full set of supporting functions that allow one to construct instances of
  the type, read and modify their contents, copy them, and test whether a given
  object belongs to the type. A new user need only remember that a single
  DEFSTRUCT form does a considerable amount of work on their behalf.

BASIC USAGE:

  In its simplest form, DEFSTRUCT takes the name of the structure followed by a
  list of slot names.

    (defstruct ship
      x-position y-position
      x-velocity y-velocity
      mass)

  This defines SHIP as a new type with five named components. It defines an
  accessor for every slot, such as SHIP-X-POSITION, which retrieves the value of
  that slot from a given ship. It defines a constructor called MAKE-SHIP, which
  creates new instances of the type. It defines a predicate called SHIP-P, true
  when given an object of type ship and false otherwise, which cooperates with
  TYPEP. It also defines a copier called COPY-SHIP, which produces a fresh
  instance whose slots hold the same values as the original.

    (setq ship2 (make-ship :mass 1000 :x-position 0 :y-position 0))
    (setf (ship-x-position ship2) 100)

  Slot values are read using the generated accessors, and updated using SETF
  together with those same accessors, as shown above.

SLOT DESCRIPTIONS AND SLOT OPTIONS:

  Rather than a bare symbol, a slot may instead be described using a list
  containing the slot name, an optional initial value form, and optional slot
  options. The initial value form is evaluated whenever the constructor needs a
  value for that slot and none was supplied by the caller. The TYPE option
  declares the type of value a slot is expected to hold. The READ ONLY option,
  when true, prevents the slot from being altered once the structure has been
  created, so SETF will not accept the accessor for that slot.

    (defstruct town
      area 
      watertowers
      (firetrucks 1 :type fixnum)
      population
      (elevation 5128 :read-only t))

    (setq town1 (make-town :area 0 :watertowers 0))
    (town-p town1)
    (town-elevation town1)
    (setf (town-population town1) 99)

  The copier function creates an independent instance whose slots hold the same
  values as those of the original.

    (setq town2 (copy-town town1))
    (= (town-population town1) 
       (town-population town2))

  Because elevation is a read only slot, its value can only be established when
  the town is constructed, not afterward.

    (setq town3 (make-town :area 0 
                           :watertowers 3 
                           :elevation 1200))

STRUCTURE OPTIONS:

  The name portion of a DEFSTRUCT form need not be a bare symbol. It may instead
  be a list whose first element is the structure name and whose remaining
  elements are options that adjust the definition.

  The CONC NAME option changes the prefix ordinarily attached to accessor names,
  by default the structure name followed by a hyphen.  Supplying an alternate
  prefix, or NIL for no prefix at all, changes how the accessors are named.

    (defstruct (clown (:conc-name bozo-))
      (nose-color 'red) 
      frizzy-hair-p 
      polkadots)

    (bozo-nose-color (make-clown))

  The CONSTRUCTOR, COPIER, and PREDICATE options allow the corresponding
  generated function to be renamed, or suppressed by supplying NIL in place of a
  name.

    (defstruct (klown (:constructor make-up-klown)
                      (:copier clone-klown)
                      (:predicate is-a-bozo-p))
      nose-color 
      frizzy-hair-p 
      polkadots)

  The INCLUDE option builds a new structure type as an extension of an already
  defined one. The new type inherits every slot of the included type, and the
  accessors of the included type continue to operate correctly on instances of
  the new type. Inclusion may be chained to any depth, and defaults established
  further up the chain continue to apply.

    (defstruct vehicle
      name 
      year 
      (diesel t :read-only t))

    (defstruct (truck (:include vehicle (year 79)))
      load-limit 
      (axles 6))

    (defstruct (pickup (:include truck))
      camper
      long-bed
      four-wheel-drive)

    (setq x (make-truck :name 'mac :diesel t :load-limit 17))
    (vehicle-name x)
    (vehicle-year x)

    (setq x (make-pickup :name 'king :long-bed t))
    (pickup-year x)

CONSTRUCTOR ARGUMENT LISTS:

  By default, the generated constructor accepts keyword arguments only, one for
  every slot. It is also possible to define a positional constructor, sometimes
  called a BOA constructor because its arguments are assigned by order of
  appearance, by supplying an argument list together with the constructor
  name. More than one CONSTRUCTOR option may appear within a single DEFSTRUCT
  form.

    (defstruct (dfs-boa
                 (:constructor make-dfs-boa (a b c))
                 (:constructor create-dfs-boa
                   (a &optional b (c 'cc) &rest d &aux e (f 'ff))))
      a b c d e f)

    (setq x (make-dfs-boa 1 2 3))
    (dfs-boa-a x)

    (setq x (create-dfs-boa 1 2))
    (eq (dfs-boa-c x) 'cc)

REPRESENTATION, AND THE `NAMED` AND `TYPE` OPTIONS:

  By default, an instance created by DEFSTRUCT is treated as a genuine member of
  the Common Lisp type system, recognizable by both TYPEP and TYPE OF. The TYPE
  option overrides this and allows a structure to instead be represented as a
  LIST or as a VECTOR, useful when interoperability with ordinary list or vector
  processing code is desired, though it removes the structure name from the type
  system unless the NAMED option is also supplied. When NAMED is used together
  with TYPE, the first element of the resulting list or vector holds the
  structure name, which allows a predicate to be generated and allows the name
  to be recovered from any instance.

DOCUMENTATION STRINGS:

  If a documentation string is supplied immediately after the name and options,
  it is attached to the structure name in the usual way, and can later be
  retrieved with the DOCUMENTATION function.

ADDITIONAL INFORMATION:

- https://metaspec.dev/m_defstruct.html
- https://lispcookbook.github.io/cl-cookbook/data-structures.html#structures
