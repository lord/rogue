* string syntax, since we'll want to case over them...

(def x "unteohuneto ) #uthenot")
(bytes (quote (12 281 283 190)))

- string is a macro
- macro preprocessor gives access to tokens as strings
- it gets cat\s\sdog

bytes of rogue (has a string literal, floats, and comments)
--preprocessor--> # part of std library, can convert both ways (except comments)
bytes of rogue-raw (has no string literals or comments or floats, has ints)
--intepreter (contains lex, parse, eval)--> # written in host language
action

# stdlib
lex :: bytes -> tokens
parse :: tokens -> rogue-ast-with-macros
expand :: rogue-ast-with-macros -> rogue-ast
unraw :: rogue-ast -> string (standard ast format (lisp))

# host language
raw-lex :: bytes -> tokens
raw-parse :: tokens -> rogue-ast
raw-eval :: rogue-ast -> actions

# rogue raw (with fake comments containing conceptual results)

# "cambridge" is a word with n letters
# cambridge is a city in ma

(+ 1 2 3) # rogue
(((+ 1) 2) 3) # rogue-raw
