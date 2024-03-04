cal:-
write('Enter A number to calculate factorial:'),nl,
read(X),
loop(0).
loop(N) :- N>0, write('value of N is: '), write(N), nl,N1=N1*N,nl.  
S is N-1, loop(S).  
