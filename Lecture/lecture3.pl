% append(L, M, N) means that L appended to M makes N.
% append([a, b], [c, d], [a, b, c, d]) is true.
append([], L, L).
append([X | L], M, [X | N] ) :- append(L, M , N).

% mem(X, L) - true if X is a member of L.
mem(X, [X | _]).
mem(X, [_ | L]) :- mem(X, L).

member(X, L) :- append(_, [X | _], L). % more declarative implementation

% select(X, L, M) - true if we can remove X (once) from L to make M
%                 - equivalently, true if we can insert X into M to make L
select(X, [X | L], L).
select(X, [Y | L], [Y | M]) :- select(X, L, M).

% L must be 1 element longer than M.
% same_length trick
% select(X, L, M) :- same_length(L, [_| M]),
%                    append(A, [X | B], L), append(A, B, M).

% select(X, L, Y, M)  - true if we can replace X with Y in L to make M
% select(e, [b, e, d], f, [b, f, d]) is true.
select(X, L, Y, M) :- same_length(L, M),
                      append(A, [X | B], L), append(A, [Y | B], M).

% reverse(L, M) - true if L reversed is M
% reverse ([a, b, c, d], M).
% X = a, L = [b, c, d] ---> LR = [d, c, b]
% goal: produce M = [d, c, b, a]
reverse([],[]).
reverse([X | L], M) :-  same_length([X | L], M),
                        reverse(L, LR), append(LR, [X], M). % O(N^2)

% flip(P, Q) - flip the elements of a pair
flip(pair(X, Y), pair(Y, X)).

% structures
%   point(X, Y) is a point in 2-space
%   line(P, Q) is a line that goes through P and Q

% vertical(L) - true if L is a vertical line.
vertical(line(point(X, Y1), point(X, Y2))).

% horizontal(L) - true if L is a horizontal line.
horizontal(line(point(X1, Y), point(X2, Y))).

% association list = list of key/value pairs
my_map(M) :- M = [ red : 4, blue : 5, green : 6, yellow : 7].

% lookup(M, K, V) - lookup key K in map M to produce V.
%   example: my_map(M), lookup(M, blue, X) --> X = 5
lookup(M, K, V) :- member(K : V, M).

% replace(M, K, V1, V2, M1) -
%   replace(K, V1) with (K, V2) in M to make M1
replace(M, K, V1, V2, M1) :- select(K : V1, M, K : V2, M1).
