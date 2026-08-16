GET-DATA-TABLE-FROM-CSV
---

### FUNCTION

Gets a data-table object representing the CSV.

  has-column-names: if non-NIL, assumes headers are on the first row

  munge-types: guess the column types

  sample: undocumented

This function is roughly as if you read the CSV file with cl-csv:read-csv,
checked that the first row contains column names, created the data-table object
with (make-instance 'data-table:data-table :column-names (first rows) :rows
(rest rows), and coerced the columns' types with
(data-table:coerce-data-table-of-strings-to-types dt) and
(data-table::ensure-column-data-types dt)(unexported function).


EXAMPLES:

    (csv:get-data-table-from-csv #p"file.csv")
    ;; #<DATA-TABLE:DATA-TABLE {10018A9F63}>

    (describe *)
    ;; =>
      COLUMN-NAMES                   = ("Date" "Type" "Quantity" "Total")
      COLUMN-TYPES                   = (STRING STRING INTEGER DOUBLE-FLOAT)
      ROWS                           = (("9 jan. 1975" "Sell" 1 9.90) …)


