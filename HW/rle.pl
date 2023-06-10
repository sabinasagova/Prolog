rle([], []) :- !.
rle([X], [1-X]) :- !.

rle([X,X|Xs], [N-V|R]) :-
    rle([X|Xs], [N1-V|R]),
    N is N1 + 1.

rle([X,Y|Ys], [1-X|R]) :-
    X \= Y, 
    rle([Y|Ys], R).

