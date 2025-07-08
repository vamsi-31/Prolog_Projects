% --- cut_examples.pl ---
% This file demonstrates the use of the cut predicate (!/0) in Prolog.
% The cut is a special goal that always succeeds but has side effects
% on Prolog's backtracking mechanism. It "cuts away" choices.

% --- Green Cut: Pruning for Efficiency ---
% A "green cut" doesn't change the logical meaning of the program
% (i.e., it doesn't change the set of solutions found), but it makes
% the program more efficient by preventing Prolog from exploring
% useless branches of the search tree.

% Example 1: Finding the maximum of two numbers.
% Without a cut, Prolog might try the second rule even if the first succeeds.
max_no_cut(X, Y, X) :- X >= Y.
max_no_cut(X, Y, Y) :- X < Y.

% With a green cut: If X >= Y is true, we commit to X as the max.
% Prolog will not try the second rule for this specific call.
max_green_cut(X, Y, X) :- X >= Y, !.
max_green_cut(_, Y, Y). % No need for X < Y if the first rule was cut.

% Queries to compare:
% ?- max_no_cut(5, 3, Max).
% Output: Max = 5. (Prolog might do extra work to check the second rule, then fail it)
%
% ?- max_green_cut(5, 3, Max).
% Output: Max = 5. (More efficient, second rule not considered after cut)
%
% ?- max_no_cut(3, 5, Max).
% Output: Max = 5.
%
% ?- max_green_cut(3, 5, Max).
% Output: Max = 5.

% Example 2: Member check (simplified, only first occurrence)
% If we only care if an element is present, not how many times or where,
% a cut can stop searching after the first match.
is_member_first(X, [X|_]) :- !. % Found it, cut! Don't look further.
is_member_first(X, [_|T]) :- is_member_first(X, T).

% Standard member/2 (from basic_list_operations.pl or built-in) would find all occurrences.
% ?- my_member(a, [a, b, a, c]).
% Output: true ; (first 'a')
%         true ; (second 'a')
%         false.
%
% ?- is_member_first(a, [a, b, a, c]).
% Output: true. (stops after the first 'a' due to the cut)


% --- Red Cut: Changing the Logic ---
% A "red cut" changes the logical meaning of the program. It prunes away
% branches that might have led to valid solutions, effectively changing
% what the program computes. Red cuts should be used with caution as
% they can make programs harder to understand and debug.

% Example: Consider a predicate that classifies a number.
% classify_num_no_cut(N, positive) :- N > 0.
% classify_num_no_cut(N, zero) :- N =:= 0.
% classify_num_no_cut(N, negative) :- N < 0.

% ?- classify_num_no_cut(5, Type).
% Output: Type = positive.
% ?- classify_num_no_cut(0, Type).
% Output: Type = zero.
% ?- classify_num_no_cut(-5, Type).
% Output: Type = negative.

% Now, let's introduce a red cut incorrectly or to achieve a specific (but different) logic.
% This version behaves like an "if-then-else" structure.
classify_num_red_cut(N, positive) :- N > 0, !.  % If N > 0, it's positive, and stop.
classify_num_red_cut(N, zero) :- N =:= 0, !. % Else, if N = 0, it's zero, and stop.
classify_num_red_cut(_, negative).          % Else (if N was not >0 and not =0), it's negative.

% ?- classify_num_red_cut(5, Type).
% Output: Type = positive.
%
% ?- classify_num_red_cut(0, Type).
% Output: Type = zero.
%
% ?- classify_num_red_cut(-5, Type).
% Output: Type = negative.

% The behavior is similar for these inputs. But what if the conditions were overlapping
% or the cuts were placed differently?

% Consider this (potentially problematic) example:
% We want to give a discount: 10% if item is 'book', 5% if price > 20.
% What if an item is a 'book' AND price > 20? It should ideally get one discount.

discount(Item, Price, '10%') :- Item = book, !. % If it's a book, give 10% and stop.
discount(_, Price, '5%') :- Price > 20.       % Else, if price > 20, give 5%.
discount(_, _, '0%').                        % Else, no discount.

% ?- discount(book, 25, D).
% Output: D = '10%'. (Correct, cut prevents the 5% rule from being tried)

% ?- discount(pen, 25, D).
% Output: D = '5%'. (Correct)

% ?- discount(pen, 10, D).
% Output: D = '0%'. (Correct)

% If the cut was NOT there in the first rule for 'book':
% discount_no_cut_problem(Item, Price, '10%') :- Item = book.
% discount_no_cut_problem(_, Price, '5%') :- Price > 20.
% discount_no_cut_problem(_, _, '0%').
%
% ?- discount_no_cut_problem(book, 25, D).
% Output: D = '10%' ;  <-- First solution
%         D = '5%' ;   <-- Second, unintended solution because book price is > 20
%         D = '0%'.    <-- Third, also unintended.
% This shows the red cut in discount/3 is crucial for its intended "if-then-else" logic.

% --- General Advice on Cuts ---
% - Use green cuts to improve performance when you know certain choices are mutually exclusive
%   or you only need the first solution.
% - Be very careful with red cuts. They can make your program's logic dependent on the
%   order of rules and the placement of cuts, which can be confusing.
% - Often, clearer logic can be achieved using `->/2` (if-then-else) or by structuring
%   rules to be mutually exclusive without cuts.
% - When reading Prolog code, pay close attention to `!` as it significantly affects execution.

% Example of if-then-else using ->/2, often clearer than red cuts:
max_ifthenelse(X, Y, Max) :-
    ( X >= Y -> Max = X ; Max = Y ).

% ?- max_ifthenelse(5, 3, Max).
% Output: Max = 5.
% ?- max_ifthenelse(3, 5, Max).
% Output: Max = 5.

classify_ifthenelse(N, Type) :-
    ( N > 0 -> Type = positive
    ; N =:= 0 -> Type = zero
    ; Type = negative ).

% ?- classify_ifthenelse(5, Type).
% Output: Type = positive.
% ?- classify_ifthenelse(-5, Type).
% Output: Type = negative.
