s:-
write('Enter The Number of Numbers in List:'),
read(N),
length(L1, N),
maplist(read, L1),
evenNumbers(L1,L2),
oddNumbers(L1,L3).

evenNumbers(L1,L2):-
findall(X,(member(X,L1), X mod 2=:=0),L2),
format("Even Numbers: ~w~n",[L2]).
oddNumbers(L1,L3):-
findall(X,(member(X,L1), X mod 2=\=0),L3),
format("ODD Numbers: ~w~n",[L3]).