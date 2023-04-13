
% male(X)
% female(X)
% parent(P,X) - true if P is the parent of X

% 1. great_grandmother(G,X)
% True if G is the great-grandmother of X

mother(M,P) :- parent(M,P), female(M).

% C is a child of P.
child(C,P) :- parent(P,C).

% G is a grandparent of P.
grandparent(G,P) :- parent(G,X), parent(X,P).

great_grandmother(G,X) :-
    female(G), parent(G,P), grandparent(P,X).

% 2. sibling(X,Y)
% Two people are siblings if they have at least one parent in common.

sibling(P,Q) :- parent(X,P), parent(X,Q), dif(P,Q).

% 3.full_sibling(X,Y)
% Full siblings share both parents.

father(F,P) :- parent(F,P), male(F).

full_sibling(P,Q) :- 
    father(F,P), father(F,Q),
    mother(M,P), mother(M,Q),
    dif(P,Q).

% 4. first_cousin(X,Y)
% First cousins have parents who are full siblings.

first_cousin(X,Y) :-
    parent(A,X), parent(B,Y), full_sibling(A,B), dif(X,Y).

% 5. secound_cousin(X,Y)
% Second cousins have parents who are first cousins.

great_grandfather(F,X) :-
    male(F), parent(F,P), grandparent(P,X).

second_cousin(X,Y) :- 
    great_grandfather(F,X), great_grandfather(F,Y),
    great_grandmother(M,X), great_grandmother(M,Y),
    dif(X,Y).

% 6. nth_cousin(X,Y)
% True if X and Y are Nth cousins for any N >= 1.

% P is an ancestor of Q (i.e parent, grandparent, ...)
nth_cousin(X,Y) :- first_cousin(X,Y).
nth_cousin(X,Y) :-
    parent(P,X), parent(Q,Y), nth_cousin(P,Q), dif(X,Y).





    







