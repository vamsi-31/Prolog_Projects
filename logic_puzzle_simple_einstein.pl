% --- logic_puzzle_simple_einstein.pl ---
% This program solves a simplified Einstein-like logic puzzle.
% The puzzle involves deducing relationships between different sets of items
% based on a list of clues.

% --- The Puzzle Setup ---
% There are three people. Each person has:
%   - A unique nationality (English, Spanish, Japanese)
%   - Drinks a unique beverage (Tea, Coffee, Milk)
%   - Owns a unique pet (Dog, Cat, Zebra)
%
% The solution will be a list of people, where each person is represented as:
%   person(Nationality, Beverage, Pet)

% Define the possible values for each attribute
nationality(english).
nationality(spanish).
nationality(japanese).

beverage(tea).
beverage(coffee).
beverage(milk).

pet(dog).
pet(cat).
pet(zebra).

% Helper predicate: member/2 (already in basic_list_operations.pl, but good to have here for standalone)
% Or rely on built-in member/2 if available and suitable.
puzzle_member(X, [X|_]).
puzzle_member(X, [_|T]) :- puzzle_member(X, T).

% Helper predicate: next_to/3 in a list
% next_to(Item1, Item2, List) means Item1 is immediately to the left or right of Item2.
% For this puzzle, we might not need positional clues, but it's a common puzzle element.
% We'll focus on direct attribute associations for this simplified version.

% --- The solve_puzzle/1 Predicate ---
% solve_puzzle(Houses) where Houses is a list of person(Nationality, Beverage, Pet) terms.
solve_puzzle(Houses) :-
    % There are three houses (people)
    Houses = [person(N1, B1, P1), person(N2, B2, P2), person(N3, B3, P3)],

    % --- Attribute Constraints (Uniqueness) ---
    % Nationalities are unique
    nationality(N1), nationality(N2), nationality(N3),
    N1 \= N2, N1 \= N3, N2 \= N3,

    % Beverages are unique
    beverage(B1), beverage(B2), beverage(B3),
    B1 \= B2, B1 \= B3, B2 \= B3,

    % Pets are unique
    pet(P1), pet(P2), pet(P3),
    P1 \= P2, P1 \= P3, P2 \= P3,

    % --- Clues ---
    % Clue 1: The Englishman drinks Tea.
    puzzle_member(person(english, tea, _), Houses),

    % Clue 2: The Spaniard owns the Dog.
    puzzle_member(person(spanish, _, dog), Houses),

    % Clue 3: The person who drinks Coffee owns the Cat.
    puzzle_member(person(_, coffee, cat), Houses),

    % Clue 4: The Japanese drinks Milk. (This might be redundant or a verifier)
    % Or, it could be a crucial clue if others are less direct.
    puzzle_member(person(japanese, milk, _), Houses),

    % Clue 5: Who owns the Zebra? (This is what we want to find out)
    % This clue is implicit. The solution will tell us.
    % We also need to find out: Who drinks Coffee? (Also implicit)
    true. % Placeholder if all constraints are applied via member.


% --- Querying the Solution ---
% ?- solve_puzzle(Solution).
% This will give one instantiation of Solution that satisfies all clues.
% If the clues are well-defined, there should be a unique solution.

% Expected output structure (order of persons in the list might vary):
% Solution = [person(english, tea, zebra), person(spanish, coffee, dog), person(japanese, milk, cat)]
% (Or some permutation of these person terms within the list)
% Wait, this assignment is a guess. Let's re-verify the clues.
% 1. Eng-Tea-_
% 2. Spa-_-Dog
% 3. _-Cof-Cat
% 4. Jap-Mil-_

% From (1) Eng drinks Tea.
% From (2) Spa owns Dog.
% From (4) Jap drinks Milk.

% Possible combinations:
% House1: person(english, tea, P_eng)
% House2: person(spanish, B_spa, dog)
% House3: person(japanese, milk, P_jap)

% Beverages left: Coffee for Spanish.
% So, B_spa = coffee.
% House2 becomes: person(spanish, coffee, dog)

% Now apply Clue 3: person who drinks Coffee owns the Cat.
% The person drinking coffee is Spanish. So, Spanish owns Cat.
% This means dog = cat. This is a CONTRADICTION with pet uniqueness.

% Let's re-evaluate the puzzle setup or clues for a solvable simple version.
% The issue is that Clue 2 (Spaniard owns Dog) and Clue 3 (Coffee drinker owns Cat)
% can clash if the Spaniard is also the coffee drinker.

% Let's simplify the puzzle with slightly different, non-contradictory clues for a 3x3.
% New Clues for a guaranteed solution:
% 1. The Englishman lives in the first house (not using house position here, but implies one of the N,B,P sets is English).
% 2. The Spaniard owns the Dog. (person(spanish, _, dog))
% 3. Coffee is drunk by the Japanese. (person(japanese, coffee, _))
% 4. The Englishman drinks Tea. (person(english, tea, _))
% (Implicit: one person owns a Zebra, one drinks Milk)

% solve_puzzle_revised(Houses)
solve_puzzle_revised(Houses) :-
    Houses = [person(N1, B1, P1), person(N2, B2, P2), person(N3, B3, P3)],

    % Nationalities
    permutation([english, spanish, japanese], [N1, N2, N3]),
    % Beverages
    permutation([tea, coffee, milk], [B1, B2, B3]),
    % Pets
    permutation([dog, cat, zebra], [P1, P2, P3]),

    % Clue 1: The Englishman drinks Tea.
    puzzle_member(person(english, tea, _), Houses),

    % Clue 2: The Spaniard owns the Dog.
    puzzle_member(person(spanish, _, dog), Houses),

    % Clue 3: Coffee is drunk by the Japanese.
    puzzle_member(person(japanese, coffee, _), Houses),

    % (Implicitly, the remaining person (Englishman) drinks the remaining beverage (Milk)
    % and owns the remaining pet (Cat), OR
    % Englishman drinks Tea (clue 1), owns Cat.
    % Spaniard drinks Milk, owns Dog (clue 2).
    % Japanese drinks Coffee (clue 3), owns Zebra.
    % Let's check this combination:
    %   Eng: tea, cat
    %   Spa: milk, dog
    %   Jap: coffee, zebra
    % Clue 1: person(english, tea, cat) - OK
    % Clue 2: person(spanish, milk, dog) - OK
    % Clue 3: person(japanese, coffee, zebra) - OK
    % This solution is consistent.

    % Clue 4 (Optional, for more constraint): The person who owns the Cat drinks Tea.
     puzzle_member(person(_, tea, cat), Houses).


% The permutation approach is more robust for "who is what" type puzzles.
% The solve_puzzle/1 above uses generate-and-test with individual variables.
% The permutation approach generates whole valid sets of assignments first.

% --- Querying the Revised Solution ---
% ?- solve_puzzle_revised(Solution).
% Expected Output:
% Solution = [person(english, tea, cat), person(spanish, milk, dog), person(japanese, coffee, zebra)]
% (or some permutation of these three person structures within the list,
%  or a permutation of the arguments within each person structure if N,B,P were permuted separately
%  and then matched up, but here N,B,P are tied to P1,P2,P3 positions).

% To make the output unique and answer "Who owns the Zebra?":
who_owns_zebra(Nationality) :-
    solve_puzzle_revised(Houses),
    puzzle_member(person(Nationality, _, zebra), Houses).

% ?- who_owns_zebra(Owner).
% Expected Output: Owner = japanese.

% --- Let's refine solve_puzzle_revised to be more explicit about the structure ---
% This structure is more like the classic Einstein puzzles.
% houses( [ house(Nationality, Beverage, Pet),
%           house(Nationality, Beverage, Pet),
%           house(Nationality, Beverage, Pet) ] ).
% For simplicity, we'll stick to the list of person/3 terms.

% Further simplified Puzzle:
% People: P1, P2, P3
% Nationalities: English, Spanish, Japanese
% Pets: Dog, Cat, Bird

% Clues:
% 1. The Englishman has a Dog.
% 2. The Spaniard has a Cat.
% Question: What pet does the Japanese have?

solve_very_simple_puzzle(Solution) :-
    Solution = [person(english, dog), person(spanish, cat), person(japanese, bird)], % This is basically the solution
    % Define available pets and nationalities
    Nationalities = [english, spanish, japanese],
    Pets = [dog, cat, bird],

    % Ensure assignments are valid
    puzzle_member(person(english, DogPet), Solution), DogPet = dog,
    puzzle_member(person(spanish, CatPet), Solution), CatPet = cat,
    puzzle_member(person(japanese, BirdPet), Solution), BirdPet = bird,

    % Check uniqueness (implicit in the solution structure above for this simple case)
    DogPet \= CatPet, DogPet \= BirdPet, CatPet \= BirdPet,
    true. % All conditions met.

% This very_simple_puzzle is too trivial as it hardcodes the solution.
% The `solve_puzzle_revised` with permutations is a better template for medium complexity.
% Let's stick to `solve_puzzle_revised` as the main example for this file.
% And ensure its clues lead to a unique, findable solution.

% Re-checking clues for `solve_puzzle_revised`:
% Nationalities: English, Spanish, Japanese
% Beverages: Tea, Coffee, Milk
% Pets: Dog, Cat, Zebra

% Clues for solve_puzzle_revised:
% 1. The Englishman drinks Tea. -> person(english, tea, _)
% 2. The Spaniard owns the Dog. -> person(spanish, _, dog)
% 3. Coffee is drunk by the Japanese. -> person(japanese, coffee, _)
% 4. (Added for more constraint) The person who owns the Cat drinks Tea. -> person(_, tea, cat)

% Let's trace with these 4 clues:
% From clue 1: person(english, tea, P_eng) is in Houses.
% From clue 4: person(N_cat_owner, tea, cat) is in Houses.
%   Since tea is unique and drunk by English, then N_cat_owner must be english.
%   So, P_eng = cat.
%   => We have: person(english, tea, cat)

% From clue 2: person(spanish, B_spa, dog) is in Houses.
% From clue 3: person(japanese, coffee, P_jap) is in Houses.

% Current assignments:
% English:  tea, cat
% Spanish:  B_spa, dog
% Japanese: coffee, P_jap

% Remaining Beverages: milk. So, B_spa = milk.
%   => person(spanish, milk, dog)

% Remaining Pets: zebra. So, P_jap = zebra.
%   => person(japanese, coffee, zebra)

% Final Solution Set:
% person(english, tea, cat)
% person(spanish, milk, dog)
% person(japanese, coffee, zebra)

% This is consistent and uniquely determined by these 4 clues.
% The `solve_puzzle_revised/1` predicate using permutations and then member checks
% for each clue is a standard way to solve these in Prolog.

% Example Query for the main puzzle:
% ?- solve_puzzle_revised(S), puzzle_member(person(Who, _, zebra), S).
% Expected:
% S = [ ... solution list ... ],
% Who = japanese.
% (The order of persons in S might vary, but the content will be the same)

% To make the output always ordered for easier checking:
solve_and_report :-
    solve_puzzle_revised(HousesUnordered),
    sort(HousesUnordered, HousesOrdered), % Sorts based on standard term order
    format('Solution:~n'),
    pretty_print_persons(HousesOrdered),
    puzzle_member(person(ZebraOwnerNationality, _, zebra), HousesOrdered),
    format('~nThe ~w owns the Zebra.~n', [ZebraOwnerNationality]).

pretty_print_persons([]).
pretty_print_persons([person(N,B,P)|T]) :-
    format('  Nationality: ~w, Beverage: ~w, Pet: ~w~n', [N,B,P]),
    pretty_print_persons(T).

% ?- solve_and_report.
/* Expected output of solve_and_report:
Solution:
  Nationality: english, Beverage: tea, Pet: cat
  Nationality: japanese, Beverage: coffee, Pet: zebra
  Nationality: spanish, Beverage: milk, Pet: dog

The japanese owns the Zebra.
true.
*/

% Note: The permutation([val1,val2,val3], [Var1,Var2,Var3]) approach is good for assigning
% a set of unique items to a set of "slots".
% Then, puzzle_member/2 is used to enforce the relationships given by the clues.
% This is a common pattern for constraint logic puzzles in Prolog.
