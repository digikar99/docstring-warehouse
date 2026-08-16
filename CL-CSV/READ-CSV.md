READ-CSV
---

### FUNCTION

Read in a CSV by data-row (which due to quoted newlines may be more
than one line from the stream)

row-fn: passing this parameter will cause this read to be streaming
and results will be discarded after the row-fn is called with data

map-fn: used for manipulating the data by row during collection if
specified; (funcall map-fn data) is collected instead of data

sample: when a positive integer, only take that many samples from
the input file

skip-first-p: when true, skips the first line in the csv

separator: character separating between data cells. Defaults to
`*separator*`

quote: quoting character for text strings. Defaults to `*quote*`

escape: escape character. Defaults to `*quote-escape*`

EXAMPLES:

    ;; read a file into a list of lists
    (cl-csv:read-csv #P"file.csv")
    ;=> (("1" "2" "3") ("4" "5" "6"))

    ;; read a file that's tab delimited
    (cl-csv:read-csv #P"file.tab" :separator #\Tab)
    
    ;; read a file and return a list of objects created from each row
    (cl-csv:read-csv #P"file.csv"
                     :map-fn #'(lambda (row)
                                 (make-instance 'object
                                                :foo (nth 0 row)
                                                :baz (nth 2 row))))
    ;; read csv from a string (streams also supported)
    (cl-csv:read-csv "1,2,3
    4,5,6")
    ;=> (("1" "2" "3") ("4" "5" "6"))



