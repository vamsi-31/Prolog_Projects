add:-
write('Enter the First Number'),nl,
read(X),nl,
write('Enter the Second Number'),nl,
read(Y),nl,
sum(X,Y),
sub(X,Y).
sum(X,Y):-S is X+Y,
sub(X,Y):-A is X-Y,
write(A).
