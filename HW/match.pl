match([],[]).

match([opt(E) | Rest], S) :- append(E, A, S), match(Rest, A).
match([opt(_) | Rest], S) :- match(Rest, S).

match([one(E) | Rest], S) :- append(E, A, S), match(Rest, A).

match([star(E) | Rest], S) :- append(E, A, S), match([star(E) | Rest], A).
match([star(_) | Rest], S) :- match(Rest, S).

match([plus(E) | Rest], S) :- append(E, A, S), match([star(E) | Rest], A).

