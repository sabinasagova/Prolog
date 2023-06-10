% variables: Dumplings, Pasta, Soup, Trout
% values: david, emma, stella, thomas

person(emma).
person(stella).
person(david).
person(thomas).

across(emma, stella).
across(stella, emma).
across(thomas, david).
across(david, thomas).


all_dif(A, B, C, D) :-
    person(A), person(B), person(C), person(D),
    dif(A, B), dif(A, C), dif(A, D),
    dif(B, C), dif(B, D),
    dif(C, D).

solve(Dumplings, Pasta, Soup, Trout) :-

    all_dif(Dumplings, Pasta, Soup, Trout),
    all_dif(Beer, Cider, IcedTea, Wine),

    % person = food = beverage,
    
    dif(Cider, Trout), % 1
    across(Cider, Trout),

    Dumplings = Beer, % 2

    Soup = Cider, % 3

    dif(Pasta, Beer), % 4
    across(Pasta, Beer),

    dif(david, IcedTea), % 5

    emma = Wine, % 6

    dif(stella, Dumplings). % Stella does not like dumplings.
    
