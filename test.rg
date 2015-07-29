(quote a) # a
(quote (a b c)) # (a b c)

(atom? (quote a)) # t
(atom? (quote ())) # t
(atom? (quote (a b c)) # ()

(eq? (quote a) (quote a)) # t
(eq? (quote a) (quote b)) # ()
(eq? (quote ()) (quote ())) # ()

(first (quote (a b c))) # a
(rest (quote (a b c))) # (b c)

(cons (quote a) (quote (b c))) # (a b c)
(cons (quote a) (quote ())) # (a)

(if (atom? (quote a)) (quote apples) (quote oranges)) # apples
(if (atom? (quote ())) (quote apples) (quote oranges)) # oranges
(if (eq? (quote a) (quote a)) (quote apples) (quote oranges)) # apples
(if (eq? (quote a) (quote b)) (quote apples) (quote oranges)) # oranges

((lambda _ (quote oranges)) (quote apples)) # oranges
((lambda a a) (quote apples)) # apples
((lambda a (lambda b  )) # apples
