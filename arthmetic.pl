calci:-
		write('enter two numbers: '),nl,
		write('enter first number: '),read(X),nl,
		write('enter second number: '),read(Y),nl,
		process(X,Y),
		condition(X,Y).
	
	process(X,Y) :-
		S is X+Y,
		T is X-Y,
		M is X*Y,
		D is X/Y,
		P is X**Y,
		C is X mod Y,
      	write('sum is : ' ),write(S),nl,
		write('diff is : ' ),write(T),nl,
		write('Mul is : ' ),write(M),nl,
		write('Div is : '),write(D),nl,
		write('Power is : ' ),write(P),nl,
		write('Modulus is : ' ),write(C),nl.
	condition(X,Y):- 
		X>Y, write('X value is greater than Y value');
		X<Y, write('X value is less than Y value');
		X=:=Y, write('X equal to Y').
            X=\=Y,write('X and Y values are not equal').
