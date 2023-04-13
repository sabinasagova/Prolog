convert(date(D,jan), N) :-
    D in 1..31,
    N #= D.

convert(date(D,feb), N) :-
    D in 1..28,
    N #= D + 31.

convert(date(D,mar), N) :-
    D in 1..31,
    N #= D + 59.

convert(date(D,apr), N) :-
    D in 1..30,
    N #= D + 90.

convert(date(D,may), N) :-
    D in 1..31,
    N #= D + 120.

convert(date(D,jun), N) :-
    D in 1..30,
    N #= D + 151.

convert(date(D,jul), N) :-
    D in 1..31,
    N #= D + 181.

convert(date(D,aug), N) :-
    D in 1..31,
    N #= D + 212.

convert(date(D,sep), N) :-
    D in 1..30,
    N #= D + 243.

convert(date(D,oct), N) :-
    D in 1..31,
    N #= D + 273.

convert(date(D,nov), N) :-
    D in 1..30,
    N #= D + 304.

convert(date(D,dec), N) :-
    D in 1..31,
    N #= D + 334.

add_date(Date1, N, Date2) :-
    convert(Date1, N1), convert(Date2, N2), 
    N2 #= N1 + N.