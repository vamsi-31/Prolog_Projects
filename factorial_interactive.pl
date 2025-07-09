s:-
read(N),
fact(0,1).
fact(N,M):-
N>0,
N1 is N-1,
fact(N1, M1),write('N1'),nl,
write(N1),nl,
write('M1'),nl,
write(M1),nl,
M is N*M1.
