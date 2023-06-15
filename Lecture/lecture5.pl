empty_stack([]).

% push X, onto stack S to make stack T
push(X, S, T) :- T = [X | S].
pop([X | S], X, S).

% queue - FIFO data structure = first in, first out
% enqueue, dequeue
% naive implementation: list

empty_queue([]).
enqueue(X, Q, Q1) :- append(Q, [X], Q1).
dequeue(X, [X | Q], Q).

% make_queue(L, Q, Q1) - enqueue all values in L onto Q to make Q1
make_queue(L, Q, Q1) :- foldl(enqueue, L, Q, Q1). 

% functional queue using two lists
empty_queue([] / []).
enqueue(X, F / B, F / [X | B]).

dequeue(X, [X | F] / B, F / B).
dequeue(X, [] / B, B1 / []) :- reverse(B, [X | B1]).

make_queue(L, Q, Q1) :- foldl(enqueue, L, Q, Q1).

my_tree(T) :- T = t(
    t(nil, 2, nil),
    5,
    t(t(nil, 8, nil), 10, t(nil, 12, nil))
).

% count(T, N) - N is the number of nodes in the tree T
count(nil, 0).
count(t(L, _, R), N) :- N #> 0, LN #> 0, RN #> 0,
                        N #= 1 + LN + RN, count(L, LN), count(R, RN).

% maptree(P, T) - true if P is true for every value X in T
maptree(_, nil).
maptree(P, t(L, X, R)) :- call(P, X), maptree(P, L), maptree(P, R).

% flatten(T, L) - flatten a tree into a list
flatten(nil, []).
flatten(t(L, X, R), M) :- flatten(L, FL), flatten(R, LR),
                          append([FL, [X], FR], M).

% if I flatten a tree with N nodes, worst-case time is O(N^2)
% if I flatten a complete binary tree with N nodes, time is O(N log N)
% let T(n) be the time to flatten a complete tree with N nodes.
%   T(N) = T(N / 2) + T(N / 2) + O(N)

% mem_tree(X, T) - X is an element of the binary search tree T

mem_tree(X, t(_, X, _)).
mem_tree(X, t(L, Y, _)) :- X #< Y, mem_tree(X, L).
mem_tree(X, t(_, Y, R)) :- X #> Y, mem_tree(X, R).

% insert(X, T, U) - insert X into T to make U.
insert(X, nil, t(nil, X, nil)).
insert(X, t(L, X, R), t(L, X, R)).
insert(X, t(L, Y, R), t(L1, Y, R)) :- X #< Y, insert(X, L, L1).
insert(X, t(L, Y, R), t(L, Y, R1)) :- X #> Y, insert(X, R, R1).

% state = Monk / Box / Ban
% Monk = a, b, c, on box
% Box = a, b, c
% Ban = c, monkey

pos(P) :- member(P, [a, b, c]).

% move(A, S, T) - action A leads from state S to state T
move(go(P), Monk / Box / Ban, P / Box / Ban) :- 
    pos(P), dif(Monk, on_box), dif(Monk, P).

move(push(P), Monk / Box / Ban, P / P / Ban) :-
    pos(P), Monk = Box, dif(Box, P).

move(climb_on, Monk / Box / Ban, on_box / Box / Ban) :- Monk = Box.

move(climb_off, on_box / Box / Ban, Box / Box / Ban).

move(grab, on_box / Box / Ban, on_box / Box / monkey) :- Box = Ban.

% path(S, T, P) - true if p is a list of actions that lead from S to T.
path(S, S, []).
path(S, T, [A | L]) :- move(A, S, S1), path(S1, T, L).

% iterative deepening
solve(P) :- length(P, _), path(a / b / c, _ / _ / monkey, P).

not_member(X, L) :- member(X, L), !, false; true.

% built into prolog: \+
not(P) :- call(P), !, false; true.

good_food(u_kohouta).
good_food(u_krocana).
expensive(u_krocana).
cheap(R) :- \+ expensive(R).

% max (X, Y, Z) - Z is the maximum of X and Y
% max(X, Y, Z) :- X #> Y, !, Z = X; Z = Y.
% if then else
max(X, Y, Z) :- X #> Y -> Z = X ; Z = Y.

% \= operator defined as X \= Y :- \+ (X=Y)

flip(h, t).
flip(t, h).

% move(S, T) - true if we can move from state S to state T
move(S, T) :- select(X, S, Y, T), flip(X, Y).

% path(S, T, P) - true if P is a path of states from S to T
path(S, S, [S]).
path(S, T, [S | P]) :- move(S, S1), path(S1, T, P).

% solve(P) :- length(P, 4), path([h, h, t], [X, X, X])
solve(N, P) :- length(Start, N), maplist(=(h), Start),
               length(Goal, N), maplist(=(t), Goal),
               length(P, _), path(Start, Goal, P).
% it takes a lot of time, improvement in tutorial