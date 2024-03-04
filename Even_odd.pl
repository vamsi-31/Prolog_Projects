evenNumbers([],[]).
 evenNumbers([H|T],L1):-
        integer(H),
        (H mod 2 =:=0 -> L1=[H|T1],evenNumbers(T,T1);
        evenNumbers(T,L1) ).
oddNumbers([],[]).
oddNumbers([H|T],L1):-
        integer(H),
        (H mod 2 =:=1 -> L1=[H|T1],oddNumbers(T,T1);
        oddNumbers(T,L1)).
