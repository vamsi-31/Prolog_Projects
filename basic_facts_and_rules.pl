% This is a comment. Lines starting with % are ignored by Prolog.

% --- Facts ---
% Facts are statements that are unconditionally true.
% They define relationships between objects or properties of objects.

% Example: "apple is a fruit"
is_fruit(apple).

% Example: "banana is a fruit"
is_fruit(banana).

% Example: "apple is red"
color(apple, red).

% Example: "banana is yellow"
color(banana, yellow).

% Example: "cat is an animal"
is_animal(cat).


% --- Rules ---
% Rules are statements that are true if certain conditions are met.
% They allow Prolog to infer new information from existing facts and rules.
% A rule has a head (the part before ':-') and a body (the part after ':-').
% The head is true if all goals in the body (separated by commas) are true.

% Example: "Something is a healthy_snack if it is a fruit."
% healthy_snack(X) is the head.
% is_fruit(X) is the body.
% X is a variable (starts with an uppercase letter or underscore).
healthy_snack(X) :-
    is_fruit(X).

% Example: "Something (X) is a colorful_fruit_by_color(Y) if X is a fruit and X has color Y."
colorful_fruit_by_color(X, Y) :-
    is_fruit(X),
    color(X, Y).

% --- How to Query ---
% After consulting this file in your Prolog interpreter:

% ?- is_fruit(apple).
% Output: true.

% ?- is_fruit(orange).
% Output: false. (because we haven't defined it)

% ?- color(banana, WhatColor).
% Output: WhatColor = yellow.

% ?- healthy_snack(apple).
% Output: true. (because apple is_fruit)

% ?- healthy_snack(X).
% Output: X = apple ;
%         X = banana.

% ?- colorful_fruit_by_color(Fruit, Color).
% Output: Fruit = apple,
%         Color = red ;
%         Fruit = banana,
%         Color = yellow.

% ?- healthy_snack(cat).
% Output: false. (because cat is_animal, not is_fruit)
