list_sum([],0).
list_sum([Head|Tail], Sum) :-
 list_sum(Tail,SumTemp),
 Sum is Head + SumTemp.