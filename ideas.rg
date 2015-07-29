


* string syntax, since we'll want to case over them...

(def x (string cat\s\sdog meow))
(println x) # => "cat  dog meow"

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

(quote a) # -> a
(quote (a b c)) # -> (a b c)

(atom? (quote a)) # -> t
(atom? (quote ())) # -> t
(atom? (quote (a b c)) # -> () # which is false..

(eq? (quote a) (quote a)) # -> t
(eq? (quote a) (quote b)) # -> ()
(eq? (quote ()) (quote ())) # -> ()

(first (quote (a b c))) # -> a
(rest (quote (a b c))) # -> (b c)

(cons (quote a) (quote (b c))) # -> (a b c)
(cons (quote a) (quote ())) # -> (a)

(if (atom? (quote a)) (quote apples) (quote oranges)) # -> apples
(if (atom? (quote ())) (quote apples) (quote oranges)) # -> oranges
(if (eq? (quote a) (quote a)) (quote apples) (quote oranges)) # -> apples
(if (eq? (quote a) (quote b)) (quote apples) (quote oranges)) # -> oranges

((lambda _ (quote oranges)) (quote apples)) # => oranges
((lambda a a) (quote apples)) # => apples
((lambda a (lambda b  )) # => apples

(+ 1 2 3) # rogue
(((+ 1) 2) 3) # rogue-raw
