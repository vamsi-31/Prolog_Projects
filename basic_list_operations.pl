% --- basic_list_operations.pl ---
% This file demonstrates some fundamental operations on lists in Prolog.

% --- 1. my_member/2 ---
% Checks if an element X is a member of a List.
% my_member(Element, List)

% Base case: X is the head of the list.
my_member(X, [X|_]).

% Recursive step: X is not the head, so check the tail of the list.
% The underscore _ indicates we don't care about the head in this rule.
my_member(X, [_|Tail]) :-
    my_member(X, Tail).

% Example Queries for my_member/2:
% ?- my_member(b, [a, b, c]).
% Output: true.
%
% ?- my_member(d, [a, b, c]).
% Output: false.
%
% ?- my_member(X, [apple, banana]).
% Output: X = apple ;
%         X = banana.

% --- 2. my_append/3 ---
% Appends List1 to List2 to produce List3.
% my_append(List1, List2, ResultList)

% Base case: Appending an empty list to List L results in L.
my_append([], L, L).

% Recursive step:
% If List1 is [H|T1] (Head H and Tail T1),
% then the ResultList will be [H|T3],
% where T3 is the result of appending T1 to List2.
my_append([H|T1], L2, [H|T3]) :-
    my_append(T1, L2, T3).

% Example Queries for my_append/3:
% ?- my_append([1, 2], [3, 4], Result).
% Output: Result = [1, 2, 3, 4].
%
% ?- my_append(L1, [c, d], [a, b, c, d]).
% Output: L1 = [a, b].
%
% ?- my_append([a,b], L2, [a, b, c, d]).
% Output: L2 = [c,d].

% --- 3. my_reverse/2 ---
% Reverses a List. This version uses an accumulator for efficiency.
% my_reverse(OriginalList, ReversedList)

% Helper predicate with an accumulator.
% my_reverse_acc(ListToReverse, Accumulator, FinalReversedList)
my_reverse_acc([], Acc, Acc). % Base case: If list is empty, accumulator is the result.

my_reverse_acc([H|T], Acc, Result) :-
    my_reverse_acc(T, [H|Acc], Result). % Prepend H to accumulator and recurse.

% Main predicate that users will call. It initializes the accumulator as an empty list.
my_reverse(List, ReversedList) :-
    my_reverse_acc(List, [], ReversedList).

% Example Queries for my_reverse/2:
% ?- my_reverse([1, 2, 3, 4], R).
% Output: R = [4, 3, 2, 1].
%
% ?- my_reverse([], R).
% Output: R = [].
%
% ?- my_reverse([a], R).
% Output: R = [a].
