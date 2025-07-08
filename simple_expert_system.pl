% --- simple_expert_system.pl ---
% This program implements a very simple rule-based expert system
% for identifying animals based on their characteristics.

% --- Knowledge Base (Facts and Rules) ---

% Characteristics of animals (can be asserted as facts or asked to the user)
% For this example, we'll define some known animals and their properties.
% animal_is(AnimalName, Property).
% Property could be a characteristic like 'has_feathers' or a classification like 'is_bird'.

% Direct facts about specific animals
animal_property(sparrow, has_feathers).
animal_property(sparrow, can_fly).
animal_property(sparrow, lays_eggs).

animal_property(eagle, has_feathers).
animal_property(eagle, can_fly).
animal_property(eagle, lays_eggs).
animal_property(eagle, is_carnivore).
animal_property(eagle, has_talons).

animal_property(penguin, has_feathers).
animal_property(penguin, cannot_fly). % Penguins are birds but don't fly
animal_property(penguin, can_swim).
animal_property(penguin, lays_eggs).

animal_property(dog, has_fur).
animal_property(dog, has_four_legs).
animal_property(dog, barks).
animal_property(dog, is_mammal_property). % Using a different name to avoid conflict with 'is_mammal' rule

animal_property(cat, has_fur).
animal_property(cat, has_four_legs).
animal_property(cat, meows).
animal_property(cat, is_mammal_property).

animal_property(lion, has_fur).
animal_property(lion, has_four_legs).
animal_property(lion, roars).
animal_property(lion, is_carnivore).
animal_property(lion, is_mammal_property).

animal_property(dolphin, is_mammal_property).
animal_property(dolphin, lives_in_water).
animal_property(dolphin, can_swim).
animal_property(dolphin, is_intelligent).

animal_property(salmon, is_fish_property).
animal_property(salmon, lives_in_water).
animal_property(salmon, can_swim).
animal_property(salmon, has_gills).
animal_property(salmon, has_fins).


% Rules for classification
% is_bird(Animal) :- ...
is_bird(Animal) :-
    animal_property(Animal, has_feathers),
    animal_property(Animal, lays_eggs).

is_mammal(Animal) :-
    animal_property(Animal, has_fur),
    animal_property(Animal, is_mammal_property). % Check the specific property for mammals
is_mammal(Animal) :- % Whales, dolphins are mammals but no fur (or very little)
    animal_property(Animal, lives_in_water),
    animal_property(Animal, is_mammal_property), % e.g. gives live birth, breathes air
    \+ animal_property(Animal, has_gills). % Not a fish

is_fish(Animal) :-
    animal_property(Animal, has_gills),
    animal_property(Animal, can_swim),
    animal_property(Animal, lives_in_water),
    animal_property(Animal, is_fish_property).

% --- Expert System Shell (Identification Logic) ---
% identify(AnimalGuess) :- based on a set of observed characteristics.

% For this simple system, we'll try to identify an animal by its known name
% and then list its properties or classifications.
% A more interactive system would ask the user questions.

identify(Animal) :-
    ( is_bird(Animal) ->
        format('~w is identified as a BIRD.~n', [Animal]),
        ( animal_property(Animal, can_fly) ->
            format('  - It can fly.~n', [])
        ; animal_property(Animal, cannot_fly) ->
            format('  - It cannot fly.~n', [])
        ; true
        ),
        ( animal_property(Animal, can_swim) ->
            format('  - It can swim.~n', [])
        ; true
        )
    ; is_mammal(Animal) ->
        format('~w is identified as a MAMMAL.~n', [Animal]),
        ( animal_property(Animal, is_carnivore) ->
            format('  - It is a carnivore.~n', [])
        ; true
        ),
        ( animal_property(Animal, lives_in_water) ->
            format('  - It lives in water.~n', [])
        ; animal_property(Animal, has_four_legs) ->
            format('  - It has four legs.~n', [])
        ; true
        )
    ; is_fish(Animal) ->
        format('~w is identified as a FISH.~n', [Animal]),
        ( animal_property(Animal, has_fins) ->
            format('  - It has fins.~n', [])
        ; true
        )
    ; format('Cannot classify ~w with current rules.~n', [Animal])
    ),
    list_other_properties(Animal).

list_other_properties(Animal) :-
    format('  Other known properties for ~w:~n', [Animal]),
    forall(animal_property(Animal, Prop), format('    - ~w~n', [Prop])).


% --- Example Queries ---
% ?- identify(sparrow).
% Expected:
% sparrow is identified as a BIRD.
%   - It can fly.
%   Other known properties for sparrow:
%     - has_feathers
%     - can_fly
%     - lays_eggs
% true.

% ?- identify(penguin).
% Expected:
% penguin is identified as a BIRD.
%   - It cannot fly.
%   - It can swim.
%   Other known properties for penguin:
%     - has_feathers
%     - cannot_fly
%     - can_swim
%     - lays_eggs
% true.

% ?- identify(lion).
% Expected:
% lion is identified as a MAMMAL.
%   - It is a carnivore.
%   - It has four legs.
%   Other known properties for lion:
%     - has_fur
%     - has_four_legs
%     - roars
%     - is_carnivore
%     - is_mammal_property
% true.

% ?- identify(dolphin).
% Expected:
% dolphin is identified as a MAMMAL.
%   - It lives in water.
%   Other known properties for dolphin:
%     - is_mammal_property
%     - lives_in_water
%     - can_swim
%     - is_intelligent
% true.

% ?- identify(salmon).
% Expected:
% salmon is identified as a FISH.
%   - It has fins.
%   Other known properties for salmon:
%     - is_fish_property
%     - lives_in_water
%     - can_swim
%     - has_gills
%     - has_fins
% true.

% ?- identify(lizard). % Not in our knowledge base
% Expected:
% Cannot classify lizard with current rules.
%   Other known properties for lizard:
% (No properties will be listed as it's unknown)
% true.


% --- Towards a more interactive expert system ---
% A more advanced system would:
% 1. Ask questions: e.g., "Does the animal have feathers? (yes/no)."
%    - yes_no_question(QuestionString, PropertyToCheck)
% 2. Store user's answers (assert facts dynamically).
% 3. Use rules that chain based on these answers to deduce the animal.

% Example of asking a question (simplified):
% ask(Question, Property) :-
%     format('~w (yes/no)? ', [Question]),
%     read(Answer),
%     ( Answer = yes -> assertz(has_property(Property)) ; true ).
%
% identify_interactive(Animal) :-
%     ask('Does it have feathers?', has_feathers),
%     ask('Does it bark?', barks),
%     % ... more questions
%     ( has_property(has_feathers) -> Animal = bird_guess ;
%       has_property(barks) -> Animal = dog_guess ;
%       Animal = unknown
%     ).
% This is a very basic sketch. Real interactive systems require more robust handling
% of user input, uncertainty, explanations, etc.
% The current `identify(AnimalName)` is a "lookup and classify" system.

list_all_animals(Animals) :-
    findall(Animal, animal_property(Animal, _), AnimalList),
    sort(AnimalList, Animals).

% ?- list_all_animals(A), maplist(identify, A).
% This will run identify for all known animals.
