AR:-
write('enter a number : '),
read(X),nl,
write('enter a number : '),
read(Y),nl,
sum(X,Y).
sub(X,Y).
write('sum is : '),
sum(X,Y):- M is X+Y,
write('sub is : '),
sub(X,Y):- A is X-Y,
write(M).
write(A).