% --- tic_tac_toe_ai.pl ---
% A simple Tic-Tac-Toe game where a human plays against the computer.

% --- Board Representation ---
% The board is a list of 9 elements.
% e.g., [x, o, e, e, x, e, o, e, e] where 'e' means empty.
% Positions are 1-9:
% 1 | 2 | 3
% ---+---+---
% 4 | 5 | 6
% ---+---+---
% 7 | 8 | 9

initial_board([e,e,e,e,e,e,e,e,e]).

% --- Displaying the Board ---
print_cell(e) :- write(' ').
print_cell(x) :- write('X').
print_cell(o) :- write('O').

print_row([C1,C2,C3]) :-
    write(' '), print_cell(C1), write(' | '),
    print_cell(C2), write(' | '),
    print_cell(C3), write(' '), nl.

print_board([C1,C2,C3,C4,C5,C6,C7,C8,C9]) :-
    nl,
    print_row([C1,C2,C3]),
    write('---+---+---'), nl,
    print_row([C4,C5,C6]),
    write('---+---+---'), nl,
    print_row([C7,C8,C9]),
    nl.

% --- Checking for a Winner ---
winning_line(Board, Player) :- line(X,Y,Z), cell(X,Board,Player), cell(Y,Board,Player), cell(Z,Board,Player).
line(1,2,3). line(4,5,6). line(7,8,9). % Rows
line(1,4,7). line(2,5,8). line(3,6,9). % Columns
line(1,5,9). line(3,5,7).             % Diagonals

cell(Pos, Board, Val) :- nth1(Pos, Board, Val). % nth1 is 1-indexed

winner(Board, Player) :- winning_line(Board, Player).

% --- Checking for a Draw ---
board_full(Board) :- \+ member(e, Board).
draw(Board) :- board_full(Board), \+ winner(Board, x), \+ winner(Board, o).

% --- Making a Move ---
% move(Board, Position, Player, NewBoard)
% Position is 1-9.
move(Board, Pos, Player, NewBoard) :-
    Pos >= 1, Pos =< 9,
    nth1(Pos, Board, e), % Check if cell is empty
    replace(Board, Pos, Player, NewBoard).

% replace(OldList, Index, Element, NewList) - 1-indexed
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
    I > 1,
    I1 is I - 1,
    replace(T, I1, X, R).
replace([], _, _, []). % Should not happen if Pos is valid and list is board

% --- Game Play ---
play :-
    initial_board(Board),
    write('Welcome to Tic-Tac-Toe!'), nl,
    write('You are X, Computer is O.'), nl,
    write('Enter position (1-9) to make a move.'), nl,
    game_loop(Board, x). % Human starts

game_loop(Board, Player) :-
    print_board(Board),
    ( winner(Board, x) -> write('You (X) win! Congratulations!'), nl
    ; winner(Board, o) -> write('Computer (O) wins! Better luck next time.'), nl
    ; draw(Board)      -> write('It''s a draw!'), nl
    ; ( Player = x -> human_turn(Board)
      ; Player = o -> computer_turn(Board)
      )
    ).

human_turn(Board) :-
    repeat,
    write('Your move (X) - enter position (1-9): '),
    read_line_to_string(user_input, MoveStr), % Read as string
    atom_number(MoveStr, Pos), % Convert to number
    ( move(Board, Pos, x, NewBoard) ->
        !, % Cut to stop repeat if move is valid
        game_loop(NewBoard, o)
    ; write('Invalid move. Cell might be taken or number out of range. Try again.'), nl,
      fail % Fail to trigger repeat
    ).
human_turn(Board) :- % Catch read errors or non-numeric input
    write('Invalid input. Please enter a number between 1 and 9.'), nl,
    game_loop(Board, x). % Let human try again


computer_turn(Board) :-
    write('Computer''s move (O)...'), nl,
    choose_computer_move(Board, o, Pos), % Computer is 'o'
    ( move(Board, Pos, o, NewBoard) ->
        game_loop(NewBoard, x)
    ; write('Error: Computer made an invalid move. This should not happen.'), nl,
      game_loop(Board,x) % Should not occur with proper AI
    ).


% --- Computer AI ---
% choose_computer_move(Board, Player, MovePosition)
% Strategy:
% 1. Win if possible.
% 2. Block opponent's win if possible.
% 3. Take center if available.
% 4. Take a corner if available.
% 5. Take a side if available.
% 6. Make any valid move (should not be needed if 1-5 cover all scenarios on non-full board).

% 1. Win if possible
choose_computer_move(Board, Player, Pos) :-
    can_win(Board, Player, Pos), !.

% 2. Block opponent's win
choose_computer_move(Board, Player, Pos) :-
    opponent(Player, Opponent),
    can_win(Board, Opponent, Pos), !. % Find where opponent would win, and take that spot

% 3. Take center
choose_computer_move(Board, _, 5) :- % Center is position 5
    nth1(5, Board, e), !.

% 4. Take a corner
choose_computer_move(Board, _, Pos) :-
    corner(Pos),
    nth1(Pos, Board, e), !.

% 5. Take a side
choose_computer_move(Board, _, Pos) :-
    side(Pos),
    nth1(Pos, Board, e), !.

% (Fallback - should ideally not be reached if above are exhaustive for non-full boards)
choose_computer_move(Board, _, Pos) :-
    member(PosVal-P, [1,2,3,4,5,6,7,8,9]), % Try any position
    Pos = PosVal, % Silly way to bind Pos, just to iterate
    nth1(Pos, Board, e), !.


% Helper for AI: can_win(Board, Player, WinningMovePosition)
% Checks if Player can make a move at WinningMovePosition to win.
can_win(Board, Player, Pos) :-
    move(Board, Pos, Player, TempBoard), % Try making the move
    winner(TempBoard, Player).

opponent(x, o).
opponent(o, x).

corner(1). corner(3). corner(7). corner(9).
side(2). side(4). side(6). side(8).

% --- To Start the Game ---
% ?- play.

% Note: read_line_to_string/2 is an SWI-Prolog specific predicate.
% For other Prologs, input reading might need adjustment.
% If atom_number fails (e.g. non-numeric input), it will be caught by the
% second human_turn clause.

% A small improvement: make sure computer doesn't try to move on a full board
% (though game_loop should handle this by detecting win/draw first).
% The choose_computer_move clauses assume there's an empty cell 'e' to pick.
% If the board is full and it's computer's turn (which implies no win/draw yet, a contradiction),
% then the last fallback rule for choose_computer_move might fail if no 'e' is found.
% However, the game_loop structure prevents this.
