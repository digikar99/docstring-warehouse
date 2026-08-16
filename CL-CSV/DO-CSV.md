DO-CSV
---

### FUNCTION

row-var: a variable that is passed into body

stream-or-pathname: a stream or a pathname to read the CSV data from

read-csv-keys: keys and values passed to the read-csv function

body: body of the macro

EXAMPLES:

    ;; loop over a CSV for effect
    (let ((sum 0))
      (cl-csv:do-csv (row #P"file.csv")
        (incf sum (parse-integer (nth 0 row))))
      sum)



