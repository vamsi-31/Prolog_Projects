s:-
write('Enter A nUmber'),nl,
read(N),
length(L,N),
maplist(read, L),
format("list: ~w~n",[L]),
reverse(L,Y),
format("list: ~w~n",[Y]),
evenNumbers(L,L2).
evenNumbers(L,L2):-
findall(X,(member(X,L), X mod 2=:=0),L2),
format("Even Numbers: ~w~n",[L2]),
length(L2,B),
write(B),
is_equal(L,L2),
is_equal([H1|T1],[H2|T2]):- 
H1=:=H2,is_equal(T1,T2).