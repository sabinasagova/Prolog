perm([], []).
perm([X | L], N) :- same_length([X | L], N),
                    perm(L, M), select(X, N, M).

insert(X, [], [X]).
insert(X, [Y | L], [X, Y | L]) :- X #=< Y.
insert(X, [Y | L], [Y | M]) :- X #> Y, insert(X, L, M).


insertion_sort([], []).
insertion_sort([X | L], N) :- same_length([X | L], N),
                            insertion_sort(L, M), insert(X, M, N).

% convert(T, N) - N is the number of seconds from midnight to time T
convert(time(H, M, S), N) :- H in 0..23, M in 0..59, S in 0..59,
                             N #= 3600 * H + 60 * M + S.

% true if time T plus N seconds equals time U.
plus(T, N, U) :- TN + N #= UN, convert(T, TN), convert(U, UN).

my_graph(G) :- G = [ a -> [b, e], b -> []].
% too lazy to write everything :)

edge(G, V, W) :- member(V -> L, G), member(W, L).

% path(G, V, W, P) - there is a path P from V to W in graph G.
path(_, V, V, [V]).
path(G, V, W, [V | P]) :- edge(G, V, X), path(G, X, W, P).

% iterative deepening
% first search for paths of length 1
% then search for paths of length 
% ...

% edges(G, L) - L is a list of all edges of G
%   L = [a -> b, a -> e]

% expand(a -> [b, e, f], L) produces L = [a -> b, a -> e, a -> f]
expand(_ -> [], []).
expand(V -> [W | L], [V -> W | M]) :- expand(V -> L, M).

edges([], []).
edges([VN | L], E) :- expand(VN, VE), edges(L, LE), append(VE, LE, E).

