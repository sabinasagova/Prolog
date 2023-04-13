% numerals(L,M) - true if L is a list of integers in the range 1 =< i =< 5 
% and M is a corresponding list of atoms from the set [one,two,three,four,five].

% base cases
integers(1, one).
integers(2, two).
integers(3, three).
integers(4, four).
integers(5, five).

% recursive case
numerals([],[]).
numerals([H1|T1],[H2|T2]) :- integers(H1,H2), numerals(T1,T2).

% pref(L,M) - ture if L is a prefix of M.

% base case
pref([],_). % an empty list a prefix of anything.
pref([L|P1],[L|P2]) :- pref(P1, P2).

% nth(N,L,X) - true if the nth element of list L is X,
% where the first element has index 0.
nth(0, [X|_], X). % base case
nth(N, [_|T], X) :- N#> 0, N1 #= N-1, nth(N1, T, X).

% concat(L,M,N) - true if the concatenation of the lists L and M is N.
concat([],X,X). 
concat([X|Y],Z,[X|W]) :- concat(Y,Z,W).

% sel(X,L,M) - true if X can be removed from L (exactly once) to make M.
% Equivalently, sel(X,L,M) is true if X can be inserted anywhere in M
% (excatly once) to make L.
sel(X,[X|T],T).
sel(X,[L|T],[L|M]) :- sel(X,T,M).

% sel4(X,L,Y,M) - true if L and M are indentical except for a single
% element which is X in L and Y in M
sel4(X,[X|T],Y,[Y|T]).
sel4(X,[L|T],Y,[L|M]) :- sel4(X,T,Y,M).

% dup(L,M) - true if M is obtained by repeating each element in L.
dup([],[]).
dup([H|T],[H,H|Y]) :- dup(T,Y).

% nums(I,J,L) - true if L is the list containing integers I through J, inclusive.
% if J < I, then L should be an empty list.

nums(I,J,[]) :- J #< I.
nums(I,J,[I|T]) :- J #>= I,K #= I + 1, nums(K,J,T).


