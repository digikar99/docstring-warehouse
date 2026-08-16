*ESCAPE-MODE*
---

### VARIABLE

Controls how escapes are handled.
    :quote - replace the entire *quote-escape* sequence with the quote
             character whenever we find it. Commonly used with "" quote
             escapes

    :following - replace the escape character and the following character with
             just the following character.
             EG: (*quote-escape* #\ )
                 \ -> 
                 r -> r
                 ' -> '
   


