STRING=
---

### FUNCTION

string=, string/=, string<, string>, string<=, string>=,
string-equal, string-not-equal, string-lessp, string-greaterp,
string-not-greaterp, string-not-lessp

 -- Function: string= string1 string2 &key start1 end1 start2 end2 ⇒
          generalized-boolean
 -- Function: string/= string1 string2 &key start1 end1 start2 end2 ⇒
          mismatch-index
 -- Function: string< string1 string2 &key start1 end1 start2 end2 ⇒
          mismatch-index
 -- Function: string> string1 string2 &key start1 end1 start2 end2 ⇒
          mismatch-index
 -- Function: string<= string1 string2 &key start1 end1 start2 end2 ⇒
          mismatch-index
 -- Function: string>= string1 string2 &key start1 end1 start2 end2 ⇒
          mismatch-index
 -- Function: string-equal string1 string2 &key start1 end1 start2 end2
          ⇒ generalized-boolean
 -- Function: string-not-equal string1 string2 &key start1 end1 start2
          end2 ⇒ mismatch-index
 -- Function: string-lessp string1 string2 &key start1 end1 start2 end2
          ⇒ mismatch-index
 -- Function: string-greaterp string1 string2 &key start1 end1 start2
          end2 ⇒ mismatch-index
 -- Function: string-not-greaterp string1 string2 &key start1 end1
          start2 end2 ⇒ mismatch-index
 -- Function: string-not-lessp string1 string2 &key start1 end1 start2
          end2 ⇒ mismatch-index


ARGUMENTS AND VALUES:

  STRING1: a string designator.

  STRING2: a string designator.

  START1, END1: bounding index designators of STRING1.  The defaults for
START and END are ‘0’ and ‘nil’, respectively.

  START2, END2: bounding index designators of STRING2.  The defaults for
START and END are ‘0’ and ‘nil’, respectively.

  GENERALIZED-BOOLEAN: a generalized boolean.

  MISMATCH-INDEX: a bounding index of STRING1, or ‘nil’.

DESCRIPTION:

  These functions perform lexicographic comparisons on STRING1 and
  STRING2.  ‘string=’ and ‘string-equal’ are called equality functions;
  the others are called inequality functions.  The comparison operations
  these functions perform are restricted to the subsequence of STRING1
  bounded by START1 and END1 and to the subsequence of STRING2 bounded by
  START2 and END2.

  A string a is equal to a string b if it contains the same number of
  characters, and the corresponding characters are the same under ‘char=’
  or ‘char-equal’, as appropriate.

  A string a is less than a string b if in the first position in which
  they differ the character of a is less than the corresponding character
  of b according to ‘char<’ or ‘char-lessp’ as appropriate, or if string a
  is a proper prefix of string b (of shorter length and matching in all
  the characters of a).

  The equality functions return a GENERALIZED BOOLEAN that is true if
  the strings are equal, or false otherwise.

  The inequality functions return a MISMATCH-INDEX that is true if the
  strings are not equal, or false otherwise.  When the MISMATCH-INDEX is
  true, it is an integer representing the first character position at
  which the two substrings differ, as an offset from the beginning of
  STRING1.

The comparison has one of the following results:

   • ‘string=’

     ‘string=’ is true if the supplied substrings are of the same length
     and contain the same characters in corresponding positions;
     otherwise it is false.

   • ‘string/=’

     ‘string/=’ is true if the supplied substrings are different;
     otherwise it is false.

   • ‘string-equal’

     ‘string-equal’ is just like ‘string=’ except that differences in
     case are ignored; two characters are considered to be the same if
     ‘char-equal’ is true of them.

   • ‘string<’

     ‘string<’ is true if substring1 is less than substring2; otherwise
     it is false.

   • ‘string>’

     ‘string>’ is true if substring1 is greater than substring2;
     otherwise it is false.

   • ‘string-lessp’, ‘string-greaterp’

     ‘string-lessp’ and ‘string-greaterp’ are exactly like ‘string<’ and
     ‘string>’, respectively, except that distinctions between uppercase
     and lowercase letters are ignored.  It is as if ‘char-lessp’ were
     used instead of ‘char<’ for comparing characters.

   • ‘string<=’

     ‘string<=’ is true if substring1 is less than or equal to
     substring2; otherwise it is false.

   • ‘string>=’

     ‘string>=’ is true if substring1 is greater than or equal to
     substring2; otherwise it is false.

   • ‘string-not-greaterp’, ‘string-not-lessp’

     ‘string-not-greaterp’ and ‘string-not-lessp’ are exactly like
     ‘string<=’ and ‘string>=’, respectively, except that distinctions
     between uppercase and lowercase letters are ignored.  It is as if
     ‘char-lessp’ were used instead of ‘char<’ for comparing characters.

EXAMPLES:

    (string= "foo" "foo")  ;=> true
    (string= "foo" "Foo")  ;=> false
    (string= "foo" "bar")  ;=> false
    (string= "together" "frog" :start1 1 :end1 3 :start2 2)  ;=> true
    (string-equal "foo" "Foo")  ;=> true
    (string= "abcd" "01234abcd9012" :start2 5 :end2 9)  ;=> true
    (string< "aaaa" "aaab")  ;=> 3
    (string>= "aaaaa" "aaaa")  ;=> 4
    (string-not-greaterp "Abcde" "abcdE")  ;=> 5
    (string-lessp "012AAAA789" "01aaab6" :start1 3 :end1 7
                                         :start2 2 :end2 6)  ;=> 6
    (string-not-equal "AAAA" "aaaA")  ;=> false


SEE ALSO:

  char=

NOTES:

  equal calls string= if applied to two strings.

