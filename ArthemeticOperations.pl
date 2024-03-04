oper:-
write('Enter the First Number'),nl,
read(X),nl,
write('Enter the Second Number'),nl,
read(Y),nl,
sum(X,Y),
diff(X,Y).
mul(X,Y).
div(X,Y).


sum(X,Y):-S is X+Y,
write('sum is'),nl,
write(S).

diff(X,Y):-D is X-Y,
write('Difference is'),nl,
write(D).

mul(X,Y).
mul(X,Y):-M is X*Y,
write('Multiply is'),nl,
write(M).

div(X,Y).
write('Divison is'),nl,
write(Di).
