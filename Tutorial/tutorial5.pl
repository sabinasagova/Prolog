empty_queue([] / []).

enqueue(X, F / B, F / [X | B]).

dequeue(X, [X | F] / B, F / B).
dequeue(X, [] / B, B1 / []) :- reverse(B, [X | B1]).

enqueue_all(L, Q, R) :- foldl(enqueue, L, Q, R).

dequeue_n(0, Q, [], Q).
dequeue_n(N, Q, [X | L], R) :- N #> 0, N1 #= N - 1,
    dequeue(X, Q, Q1), dequeue_n(N1, Q1, L, R).

% dequeue_all(L, Q, R) - dequeue a
dequeue_all(L, Q, R) :- foldl(dequeue, L, Q, R).
dequeue_all(N, Q, L, R) :- length(L, N), dequeue_all(L, Q, R).

% left fold
fold(G, [], A, A).
fold(G, [X | L], A, R) :- call(G, X, A, A2), fold(G, L, A2, R).

% flatten all values in the tree T and prepend them to A to produce B
% flatten(T, A, B)
flatten(nil, A, A).
flatten(t(L, X, R), A, B) :- flatten(R, A, A2), flatten(L, [X | A2], B).
flatten(T, B) :- flatten(T, [], B).

% foldltree
foldltree(_, nil, A, A).
foldltree(G, t(L, X, R), A, B) :- foldltree(G, L, A, A1), call(G, X, A1, A2),
                                  foldltree(G, R, A2, B).

% generalization of 3 coins problem
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
               length(P, _), path(Start, Goal, P), !.
% L is a list of all neighbors of V in G
neighbors(G, V, L) :- member(V -> L, G).

% BFS
% plan
% queue, each element of the queue is a path from start to some vertex V in reverse order
%               [V, ..., Start]
% visited set = a list of vertices that we have visited
% naive queue = a list

% prepend a value X to list L to make [X | L]
prepend_to(L, X, [X | L]).
% Suceeds if we can find a path P from start to End,
% without going through any visited vertices.
% no proste extrem
bfs(_, [[End | P1] | _], _, End, P) :- reverse([End | P1], P).
bfs(G, [[V | P1] | Q], Vis, End, P) :-
    neighbors(G, V, N), subtract(N, Vis, N1), append(N1, Vis, Vis2),
    maplist(prepend_to([V | P1]), N1, N2), append(Q, N2, Q2),
    bfs(G, Q2, Vis2, End, P).
bfs(G, Start, End, P) :- bfs(G, [[Start]], [Start], End, P).

bfs2([[V | P1] | Q], Vis, End, P) :-
    findall(X, move(V, X), N), subtract(N, Vis, N1), append(N1, Vis, Vis2),
    maplist(prepend_to([V | P1]), N1, N2), append(Q, N2, Q2),
    bfs2(Q2, Vis2, End, P).
bfs2(Start, End, P) :- bfs([[Start]], [Start], End, P).

solve2(N, P) :- length(Start, N), maplist(=(h), Start),
               length(Goal, N), maplist(=(t), Goal),
               bfs2(Start, Goal, P), !.