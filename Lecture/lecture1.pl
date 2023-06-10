% atom = unique name, written in lowercase
% variables = begin with an UPPERCASE letter
% semicolon (;) means or

% this is a comment
% facts
green(frog).
animal(dog).
blue(water). 
plant(tree).

alive(X) :- animal(X). % all animals X are alive
alive(X) :- plant(X).

% facts about two atoms
capital(prague, czech_rep).
capital(berlin, germany).
capital(bratislava, slovakia).

% a :- b means "b implies a", i.e. "if b then a"

% socrates
man(socrates).
mortal(X) :- man(X).

female(jane).
parent(anne, jane).
% M is the mother of P.
% for all M and P,
%   parent(M, P), female(M) --> mother(M, P).
mother(M, P) :- parent(M, P), female(M).

% C is a child of P.
child(C, P) :- parent(P, C).

% G is a grandparent of P.
grandparent(G, P) :- parent(G, X), parent(X, P).

% P and Q are siblings (brother and sister).
% i.e. they have at least one parent in common.
sibling(P, Q) :- parent(X, P), parent(X, Q), dif(P, Q).

% P is an ancestor of Q (i.e. parent, grandparent, ...)
ancestor(P, Q) :- parent(P, Q).
ancestor(P, Q) :- parent(P, X), ancestor(X, Q).