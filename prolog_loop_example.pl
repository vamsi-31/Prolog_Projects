s:-
write('Enter Number'),nl,
read(X),
loop(X).
loop(X):-
X>0,
X1 is X-1,write(X1),nl,
Y is X1*loop(X1),write(Y),nl.
