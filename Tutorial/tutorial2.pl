triple([X, X, X]).

triple_dif([X, Y, Z]) :- dif(X, Y), dif(Y, Z), dif(X, Z).

last_elem(X, [X]).
last_elem(X, [_ | L]) :- last_elem(X, L).

second_last([X], [X, _]).
second_last(X, [_ | L]) :- second_last(X, L).

next_to(X, Y, [X, Y | _]).
next_to(X, Y, [_ | L]) :- next_to(X, Y, L).

even_length([]).
even_length([_, _ | L]) :- even_length(L).

same_length([], []).
same_length([_ | L], [_ | M]) :- same_length(L, M).

longer([_ | _], []). % [_] WILL FAIL means one element, [_ | _] means any no of elements
longer([_ | L1], [_ | L2]) :- longer(L1, L2).

double_length([_, _], [_]).
double_length([_, _ | L], [_ | M]) :- double_length(L, M).

is_list([]).
is_list([_ | _]).

len([], 0).
len([_ | L], N) :- N #> 0, N #= N1 + 1, len(L, N1).

all_same([]).
all_same([X]).
all_same([X, X | L]) :- all_same([X | L]).

% helper predicate
mem(X, [X | _]).
mem(X, [_ | L]) :- mem(X, L).

% True if X is not a member of L.
not_mem(X, []).
not_mem(X, [Y | L]) :- dif(X, Y), not_mem(Y, L).

all_dif([]).
all_dif([X | L]) :- not_mem(X, L), all_dif(L).

sum([], 0).
sum([X | L], N) :- N #= X + N1, sum(L, N1).