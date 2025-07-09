s:-
write('Enter The Number of Numbers in List:'),
read(N),
length(L1, N),
maplist(read, L1),
format("List Items: ~w~n",[L1]).
