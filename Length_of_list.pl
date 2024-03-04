% length of empty list is 0 (base case)
list_length([], 0).
list_length([_ | L], N) :-
 list_length(L, N1),
 N is N1 + 1.
 % If length of L is N1, then length of [_ | L] will be N1 + 1 + 1.
 % If length of L is N1, then length of [_ | L] will be N1 + 1
