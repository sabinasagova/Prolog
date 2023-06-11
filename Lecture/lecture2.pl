% is_a_parent(P) is true if P is a parent 
parent(jane, bill).
is_a_parent(P) :- parent(P, X).

% = means structural equality
% 2 + 2 = 4 false
% 2 + 2 = 2 + 2 true
% 1 + 3 = 3 + 1 false

% X is 5 - 2 results in 3

% Prolog rounds to -inf

% X is abs(-4) 
% X = 4

% +, -, *, div, mod, ^
% abs(X), max(X, Y), min (X, Y)
% <, =<, >, >=

% is will evaluate an expression on the right only!

% :- use_module(library(clpdf)).
% :- use_module(library(clpr)).

% X #= 2 + 3 results in 5
% X + 2 #= 5 results in 3

sum(X, Y, Z, A) :- X + Y + Z #= A.

max(A, B , C, M) :- M #= max(a, max(B, C)).

% inf means negative infinity ("inferior") X in inf..4
% sup means positive infinity ("superior") X in 8..sup
% #\= means not equal (integers only)

% X, Y, Z are sides of a right triangle, Z is the hypotenuse.

right_triangle(X, Y, Z) :- X #> 0, Y #> 0, Z #> 0,
                           X * X + Y * Y #= Z * Z.

% factorial (X, F) - true if F is X!
factorial(0, 1). % 0! = 1.
factorial(X, F) :- X #>0, X1 #= X - 1, factorial(X1, F1), F #= F1 * X.
% factorial(X, 24) will not terminate, quick fix
factorial(X, F) :- X #>0, X1 #= X - 1,  F #= F1 * X, factorial(X1, F1).
% prolog is happiest if the recursion is at the end

% { X * 2 = 9} will give us 4.5

% there is pi = 3.14....., also e

triangle(X, Y, Z) :- { X > 0, Y > 0, Z > 0, X^2 + Y^2 = Z^2}.

% celsius, fahrenheit
temperature(C, F) :- { F = 9 / 5 * C + 32}.

currency(Kc, Eur, USD) := { 1.13 * Eur = USD, 21.7 * USD = Kc }.

% true if L is an empty list.
is_empty([]).

% true if L is a list with a single element.
one_element([_]).

% pair_of (X, L) - true if L has 2 elements and both elements are X.
% pair_of(X, L) :- L = [X, X].
pair_of(X, [X, X]).

% [X | L] means X prepended to the list
% X = [1 | [2, 3, 4]] gives us X = [1, 2, 3, 4]

% non-empty(L) - L is not the empty list
non_empty([_| _]).

% first_elem(X, L) :- true if X is the first element of the list L.
% first_elem(X, L) :- L = [X | _].
first_elem(X, [X | _]).