multiply:-
write('Enter the First Number'),nl,
read(X),nl,
write('Enter the Second Number'),nl,
read(Y),nl,
mul(X,Y).
mul(X,Y):-S is X*Y,
write('Product is'),nl,
write(S).