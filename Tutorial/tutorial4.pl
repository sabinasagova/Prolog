clique(_, 0, []).
clique(G, N, [V | C]) :- N #>0, append(_, [V -> NV | W], G),
                         N1 #= N - 1, clique(W, N1, C),
                         subset(C, NV).

% Add all elements of a list.
add(X, A, A1) :- X + A #= A1.
add_all(L, R) :- foldl(add, L, 0, R).

% convert(L, N) - convert a list of digits to an integer
%   convert([3, 5, 6], 356) is true.

add_digit(D, A, A1) :- D in 0..9, A1 #= 10 * A + D.

convert(L, N) :- foldl(add_digit, L, 0, N).

all_same([]).
all_same([X | L]) :- maplist(=(X), L).

% has_length(N, L) is true if L has length N.
has_length(N, L) :- length(L, N).
% true if M is a square matrix of dimensions N x N.
is_square(M, N) :- length(M, N), maplist(has_length(N), M).

% true if V is a vector of N zeroes
is_zero_vec(V, N) :- length(V, N), maplist(=(0), V).

% true if M is a zero matrix of size N x N.
is_zero_mat(M, N) :- length(M, N), maplist(is_zero_vec(N), M).

first_elem([V | _], X).

% first_col(M, V) - true if V is the first column of M.
first_col(M, V) :- maplist(first_elem, M, V).

% H H T Three Coins
% start state = [h, h, t]
% goal state = either [h, h, h] or [t, t, t]
flip(h, t).
flip(t, h).
% move(S, T) - true if we can move from state S to state T
move(S, T) :- select(X, S, Y, T), flip(X, Y).
% path(S, T, P) - true if P is a path of states from S to T
path(S, S, [S]).
path(S, T, [S | P]) :- move(S, S1), path(S1,T, P).
% 3 coin flips + start state -> 4
solve(P) :- length(P, 4), path([h, h, t], (X, X, X), P).

% Monkey and Bananas
% state = Monk / Bank / Box
% Monk = a, b, c, on_box
% Box = a, b, c
% Ban = a, b, c, monkey

% start state = a / b / c
%   go(a)
% goal state = _ / _ / monkey

pos(P) :- member(P, [a, b, c]).
% move(A, S, T) - action A leads from state S to state T
move(go(P), Monk / Box / Ban, P / Box / Ban) :-
    pos(P), dif(Monk, on_box), dif(Monk, b).

move(push(P), Monk / Box / Ban, P / P / Ban) :-
    pos(P), Monk = Box, dif(Box, P).

move(climb_on, Monk / Box / Ban, on_box / Box / Ban) :- 
    Monk = Box.

move(climb_off, on_box / Box / Ban, Box / Box / Ban).

move(grab, on_box / Box / Ban, on_box / Box / monkey) :-
    Box = Ban.

% path(S, T, P) - true if P is a list of actions that lead from S to T
path(S, S, []).
path(S, T, [A | L]) :- move(A, S, S1), path(S1, T, L).

% iterative deepening
solve(P) :- length(P, _), path(a / b / c, _ / _ / monkey, P).

