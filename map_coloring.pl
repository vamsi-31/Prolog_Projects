% --- map_coloring.pl ---
% This program solves a simple map coloring problem.
% The goal is to assign a color to each region of a map such that
% no two adjacent regions have the same color.
% We will use a small number of colors (e.g., red, green, blue).

% --- Defining Colors ---
color(red).
color(green).
color(blue).
% You could add more colors if needed, e.g., color(yellow).

% --- Defining the Map (Regions and Adjacency) ---
% We need to define which regions are adjacent to each other.
% adjacent(Region1, Region2) means Region1 and Region2 share a border.
% Adjacency is symmetric, but we only need to define it once for each pair.

% Let's define a simple map with 5 regions: R1, R2, R3, R4, R5.
% R1 is adjacent to R2, R3
% R2 is adjacent to R1, R3, R4
% R3 is adjacent to R1, R2, R4, R5
% R4 is adjacent to R2, R3, R5
% R5 is adjacent to R3, R4

% We can represent the map structure implicitly in our main coloring predicate
% or explicitly using facts. For this example, we'll define a list of
% region pairs that must have different colors.

% A region is defined by its name and its assigned color: region(Name, Color).
% The solution will be a list of these region(Name, Color) terms.

% --- The Coloring Predicate ---
% solve_map_coloring(Solution)
% Solution will be a list: [region(r1,C1), region(r2,C2), ..., region(r5,C5)]

solve_map_coloring(Solution) :-
    % Assign a color to each region
    Solution = [region(r1, C1), region(r2, C2), region(r3, C3), region(r4, C4), region(r5, C5)],

    % Choose a color for each region from the available colors
    color(C1),
    color(C2),
    color(C3),
    color(C4),
    color(C5),

    % Define constraints: adjacent regions must have different colors.
    % We use \= for "not equal".

    % R1 adjacencies
    C1 \= C2, % R1 != R2
    C1 \= C3, % R1 != R3

    % R2 adjacencies (already covered R2!=R1)
    C2 \= C3, % R2 != R3
    C2 \= C4, % R2 != R4

    % R3 adjacencies (already covered R3!=R1, R3!=R2)
    C3 \= C4, % R3 != R4
    C3 \= C5, % R3 != R5

    % R4 adjacencies (already covered R4!=R2, R4!=R3)
    C4 \= C5. % R4 != R5

    % R5 adjacencies are covered by the above (R5!=R3, R5!=R4).

% --- How to Query ---
% ?- solve_map_coloring(Solution).
% Press ';' to find more solutions if they exist.

% Example Output (one possible solution):
% Solution = [region(r1, red), region(r2, green), region(r3, blue), region(r4, red), region(r5, green)] ;
% Solution = [region(r1, red), region(r2, green), region(r3, blue), region(r4, red), region(r5, blue)] ;
% ... and many more.

% --- A More General Approach (for larger maps) ---
% For larger maps, explicitly listing all \= constraints becomes tedious.
% A more general approach involves:
% 1. Defining all adjacencies explicitly as facts:
%    adjacent(r1, r2). adjacent(r1, r3).
%    adjacent(r2, r3). adjacent(r2, r4).
%    adjacent(r3, r4). adjacent(r3, r5).
%    adjacent(r4, r5).
%
% 2. Creating a list of all region names: Regions = [r1, r2, r3, r4, r5].
%
% 3. A predicate that assigns colors and checks constraints:
%    assign_colors([], _). % Base case: all regions colored
%    assign_colors([Region|RestRegions], Assignments) :-
%        member(region(Region, ColorOfRegion), Assignments), % Get assigned color
%        color(ColorOfRegion),
%        check_constraints(Region, ColorOfRegion, Assignments),
%        assign_colors(RestRegions, Assignments).
%
%    check_constraints(_, _, []).
%    check_constraints(Region1, Color1, [region(Region2, Color2)|RestAssignments]) :-
%        ( (adjacent(Region1, Region2) ; adjacent(Region2, Region1)) ->
%            Color1 \= Color2
%        ; true % Not adjacent, no constraint
%        ),
%        check_constraints(Region1, Color1, RestAssignments).
%
%    % Then the main predicate would initialize Assignments with variables and call assign_colors.
%    % This structure is more complex to set up initially but scales better.
%    % The version `solve_map_coloring/1` above is simpler for small, fixed maps.

% --- Outputting the solution more clearly ---
pretty_print_solution([]).
pretty_print_solution([region(Name, Color)|Rest]) :-
    format('Region ~w is colored ~w~n', [Name, Color]),
    pretty_print_solution(Rest).

% ?- solve_map_coloring(S), pretty_print_solution(S).
% Example Output:
% Region r1 is colored red
% Region r2 is colored green
% Region r3 is colored blue
% Region r4 is colored red
% Region r5 is colored green
% S = [region(r1, red), region(r2, green), region(r3, blue), region(r4, red), region(r5, green)] ;
% ... (next solution)

% Note: The number of solutions can be large. Prolog will find all valid colorings
% through backtracking. Using more colors or more regions increases complexity.
% If no solution is possible with the given colors (e.g., trying to 2-color this map),
% the query `solve_map_coloring(Solution).` would eventually return `false`.
% For instance, try removing `color(blue).` and see.
% (This map requires at least 3 colors because R1, R2, R3 form a triangle,
%  and R2, R3, R4 also form a triangle, R3,R4,R5 also).
% Actually R1,R2,R3 are mutually adjacent, so need 3 colors for them.
% R2,R3,R4 are also mutually adjacent.
% R3,R4,R5 are also mutually adjacent.
% So this map is indeed 3-colorable.
% If we had only two colors, say red and green:
% color(red). color(green).
% Then solve_map_coloring(S). would yield false.
/*
Test with 2 colors:
color(red).
color(green).
% color(blue). % Comment out blue

solve_map_coloring(S).
-> false. (Correct, this map needs at least 3 colors).
*/
