complement([], L, L).
complement([H1|T1], L2, L3):-
member(H1, L2),
!,
delete(L2, H1, L2New),
complement(T1, L2New, L3).
complement([H1|T1], L2, [H1|T2]):-
\+member(H1, L2),
complement(T1, L2, T2).