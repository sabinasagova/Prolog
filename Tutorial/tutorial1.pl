man(socrates).
man(plato).
mortal(X) :- man(X).

parent(charles, Y) :- Y = margaret; Y = elizabeth.
% , (AND) has a higher precedence than ; (OR)
% higher precedence = binds more tightly

path(V, V). % empty path, base case
path(V, W) :- edge(V, X), path(X, W).

% red, green, blue
% G, P, C, S, A, H, U
% color(C) is true if C is a color.
color(red).
color(green).
color(blue).
solve(G, P, C, S, A, H, U) :-
    color(G), color(P), color(C),
    color(S), color(A), color(U),
    color(H), % dif borders, lazy to do that
    dif(G,P).    

% Crosswords
% A B C
% D E F
% G H I

% word(X, Y, Z) is true if XYZ is a word.
word(a, g, e).
word(a, g, o).
word(c, a, n).
word(c, a, r).
word(n, e, w).
word(r, a, n).
word(r, o, w).
word(w, o, n).

solve(A, B, C, D, E, F, G, H, I) :-
    word(A, B, C), word(D, E, F), word(G, H, I),
    word(A, D, G), word(B, E, H), word(C, F, I).

person(kate).
person(maria).
person(roman).

% variables: Doctor, Lawyer, Teacher, Piano, Flute, Violin
% values: kate, maria, roman
all_dif(A, B, C) :- person(A), person(B), person(C),
                    dif(A, B), dif(B, C), dif(A, C).

solve(Doctor, Lawyer, Teacher, Piano, Flute, Violin) :-
    all_dif(Doctor, Lawyer, Teacher),
    all_dif(Piano, Flute, Violin),
    dif(Doctor, maria),
    Lawyer = Piano,
    dif(Teacher, maria),
    Doctor = Violin,
    dif(Kate, Doctor).