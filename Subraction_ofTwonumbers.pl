sub:-
write('Enter the First Number'),nl,
read(X),nl,
write('Enter the Second Number'),nl,
read(Y),nl,
sub(X,Y).
sub(X,Y):-S is X-Y,
write('difference is'),nl,
write(S).