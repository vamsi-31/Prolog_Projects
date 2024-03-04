palindrome([]).
palindrome([_]).
palindrome([X|Xs]):-append(Xs1,[X],Xs), palindrome(Xs1)
