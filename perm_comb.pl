perm([X|Y],Z):- perm(Y,W), delete_member(X,Z,W).
perm([],[]).
delete_member(X,[X|R],R).
delete_member(X,[F|R],[F|S]) :- delete_member(X,R,S).
solve(P) :-
     perm([1,2,3,4,5,6,7,8],P),
     combine([1,2,3,4,5,6,7,8],P,S,D),
     all_diff(S),
     all_diff(D).
combine([X1|X],[Y1|Y],[S1|S],[D1|D]) :-
     S1 is X1 +Y1,
     D1 is X1 - Y1,
     combine(X,Y,S,D).
combine([],[],[],[]).
all_diff([X|Y]) :-  \+member(X,Y), all_diff(Y).
all_diff([X]).