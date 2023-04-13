neprazdny([_|_]).

vyhodnot(LH, PH, H, LV, PV, V) :-
    H is LH * PH, V = LV * PV.
vyhodnot(LH, PH, H, LV, PV, V) :-
    H is LH + PH, V = LV + PV.
vyhodnot(LH, PH, H, LV, PV, V) :-
    H is LH - PH, V = LV - PV.
vyhodnot(LH, PH, H, LV, PV, V) :-
    PH =\= 0, % nesmieme delit nulou
    H is LH // PH, V = LV / PV. % potrebujeme napisat /, ale delit //

vlozOperatory([N], N, N). % base case
vlozOperatory(S, H, V) :- % recursive case
    append(L, P, S), % rozdelime Seznam na 2 casti: Lavu a Pravu
    neprazdny(L), neprazdny(P),
    vlozOperatory(L, LH, LV), % rekurzivne sa zavolame na Lavu cast
    vlozOperatory(P, PH, PV), % rekurzivne sa zavolame na Pravu cast 
    vyhodnot(LH, PH, H, LV, PV, V).

