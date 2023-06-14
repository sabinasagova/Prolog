% z = 0
% s(z) = 1
% s(s(z)) = 2
% ...

add(z, I, I).
add(s(I), J, s(K)) :- add(I, J, K).

% what if there were no lists? could we define them?
% nil = []
% const(3, nil) = [3]
% const(3, cons(4, cons(5, nil))) = [3, 4, 5]

mem(X, const(X, _)).
mem(X, const(_, L)) :- mem(X, L).

% nil = []
% 3 : nil = [3]
% 3 : 4 : 5 : nil = [3, 4, 5]
mem(X, X : L).
mem(X, _ : L) :- mem(X, L).

% higher-order predicates

% X is a positive integer
pos(X) :- X #> 0.
% all_pos(L) is true if all elements of L are positive
% all_pos([]).
% all_pos([X | L]) :- pos(X), all_pos(L).
all_pos(L) :- maplist(pos, L).

even(X) :- X mod 2 #= 0.
% all_even([]).
% all_even([X | L]) :- even(X), all_even(L).
all_even(L) :- maplist(even, L).

% all_dif(X, L) - true if all elements of L are different from X.
all_dif(_, []).
all_dif(X, [Y | L]) :- dif(X, Y), all_dif(X, L).

% dif(X) is a partially applied predicate
all_dif(X, L) :- maplist(dif(X), L).

% true if all values in L are distinct
distinct([]).
distinct([X | L]) :- maplist(dif(X), L), distinct(L).

% containts(L, X) - true if L contains X
contains(L, X) :- member(X, L).
% subset(L, M) - true if L is a subset of M.
%   i.e. every member of L is a member of M.

subset(L, M) :- maplist(contains(M), L).

% maplist(#> 4, [5,6,7]) is false 4 #> 5/6/7

inc(I, J) :- J #= I + 1.
% maplist(inc, [3, 4, 5], [4, 5, 6]) is true

num(1, one).
num(2, two).
num(3, three).

% maplist(num, [1, 2, 3], L) --> L = [one, two, three]

% add_n(N, L, M) - true if we can produce M by adding N to every element of L.
%   ex: add_n(2, [10, 20, 30], [12, 22, 32]) is true
% add(I, J, K) :- I + J #= K.
add_n(N, L, M) :- maplist(add(N), L, M).

% scalar * vector mupltiplication, using floats

mul(X, Y, Z) :- {X * Y = Z}.
mul_sv(X, V, W) :- maplist(mul(X), V, W).

% zip([1,2, 3], [5, 6, 7], [1 / 5, 2 / 6, 3 / 7]).
pair(A, B, A / B).
zip(L, M, N) :- maplist(pair, L, M, N).

% call(add(3, 4), N). N = 7.

% maplist(P, L) - true if P(X) is true for every X in L.
map_list(P, []).
map_list(P, [X | L]) :- call(P, X), map_list(P, L).

% multiply scalar X times matrix M to produce matrix N.
mul_sm(X, M, N) :- maplist(mul_sv(X), M, N).
% add matrices M + N to make O
add(X, Y, Z) :- {X + Y = Z}.
add_vv(V, W, X) :- maplist(add, V, W, X).
add_mm(M, N, O) :- maplist(add_vv, M, N, O).

% sum(N, S) - true if S is 1 + 2 + ... + N.
% sum(0, 0).
% sum(N, S) :- N #> 0, N1 #= N - 1, sum(N1, S1), S #= S1 + N.

% accumulator
% sum(N, A, Ret).
sum(0, A, A).
sum(N, A, S) :- N #> 0, N1 #= N - 1, A1 #= A + N, sum(N1, A1, S).
sum(N, S) :- sum(N, 0, S).

digits([], A, A).
digits([D | L], A, N) :- 0 #=< D, D #=< 9, A1 #= A * 10 + D, digits(L, A1, N).
digits(L, N) :- digits(L, 0, N).

% rev([],[]).
% rev([X | L], M) :- rev(L, LR), append(LR, [X], M).
rev([], A, A).
rev([X | L], A, M) :- rev(L, [X | A], M).
rev(L, M) :- same_length(L, M), rev(L, [], M).

