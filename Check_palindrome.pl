palind([]):- write('palindrome').
palind([_]):- write('palindrome').
palind(L) :-
reverse(L,A),
(L=A->write('palindrome') ; write('Not palindrome')).