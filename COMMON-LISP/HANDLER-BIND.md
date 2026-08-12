HANDLER-BIND
---

### FUNCTION

(HANDLER-BIND ( {(type handler)}* ) body)

Executes body in a dynamic context where the given handler bindings are in
effect. Each handler must take the condition being signalled as an argument.
The bindings are searched first to last in the event of a signalled
condition.
