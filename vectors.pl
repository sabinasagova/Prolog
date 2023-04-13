% vec_sum(V,W,Z) - true if the sum of the vectors V and W is Z.

vec_sum([],[],[]).
vec_sum([H1|T1],[H2|T2],[X|L3]) :- vec_sum(T1,T2,L3),{X = H1+H2}.

% vec_len(V,X) - true if the length of vector V is X.
vec_len([],0.0). % the length of an empty vector is 0
vec_len([H,Y],X) :- {X >= 0, H^2 + Y^2 = X^2}.

% mul(X,V,W) - true if the scalar X multiplied by the vector V is the vector W.

mul(_,[],[]).
%mul(X,V,W) :- {W = X * V}.
mul(V,[H1|T1],[H2|T2]) :- {H2 = V * H1}, mul(V,T1,T2).

%dot(V,W,X) - true if the dot product of vectors V and W is the scalar X.
dot([],[],0.0).
dot([H1|T1],[H2|T2],X) :- {X = (H1*H2) +X1},dot(T1,T2,X1).

% angle(V,W,A) - true if the angle between vectors V and W is A (in radians),
% where 0 <= A <= pi.
angle(V,W,A) :- vec_len(V,L1), vec_len(W,L2), {A1 = L1 * L2 * cos(A)}, dot(V,W,A1).