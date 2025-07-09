cal:-
write('Enter A number to calculate factorial:'),nl,
read(N),
loop(0).
loop(N) :- N>0, write('value of N is: '), nl,
N1=N1*N,nl,write(N),nl,  
S is N-1, loop(S).  
