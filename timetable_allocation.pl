:- use_module(library(clpfd)).
course(cse341, 3, [mwf, 11, 12], 'cs1').
course(cse342, 3, [mwf, 13, 14], 'cs2').
course(cse343, 3, [mwf, 15, 16], 'cs3').
course(cse344, 3, [mwf, 17, 18], 'cs4').
course(cse345, 3, [tt, 11, 12], 'cs5').
course(cse346, 3, [tt, 13, 14], 'cs6').
course(cse347, 3, [tt, 15, 16], 'cs7').
course(cse348, 3, [tt, 17, 18], 'cs8').

room(cs1, 20).
room(cs2, 30).
room(cs3, 30).
room(cs4, 30).
room(cs5, 30).
room(cs6, 30).
room(cs7, 30).
room(cs8, 30).

teacher(t1, [cse341, cse342, cse343, cse344, cse345, cse346, cse347, cse348]).
teacher(t2, [cse341, cse342, cse343, cse344, cse345, cse346, cse347, cse348]).
teacher(t3, [cse341, cse342, cse343, cse344, cse345, cse346, cse347, cse348]).
teacher(t4, [cse341, cse342, cse343, cse344, cse345, cse346, cse347, cse348]).
teacher(t5, [cse341, cse342, cse343, cse344, cse345, cse346, cse347, cse348]).
teacher(t6, [cse341, cse342, cse343, cse344, cse345, cse346, cse347, cse348]).
teacher(t7, [cse341, cse342, cse343, cse344, cse345, cse346, cse347, cse348]).
teacher(t8, [cse341, cse342, cse343, cse344, cse345, cse346, cse347, cse348]).

schedule(S, P, T, R):-
        courses(S),
        professors(P),
        rooms(R),
        timeslots(T),
        maplist(slot_course, T, S),
        maplist(slot_professor, T, P),
        maplist(slot_room, T, R),
        maplist(course_professor, S, P),
        maplist(course_room, S, R),
        maplist(course_timeslots, S, T),
        maplist(room_capacity, R, C),
        maplist(course_size, S, C).

courses([]).
courses([H|T]):-
        course(H, _, _, _),
        courses(T).

professors([]).
professors([H|T]):-
        teacher(H, _),
        professors(T).

rooms([]).
rooms([H|T]):-
        room(H, _),
        rooms(T).

timeslots([]).
timeslots([H|T]):-
        time_slot(H, _, _, _),
        timeslots(T).

slot_course(slot(_, _, _), course(_, _, _, _)).

slot_professor(slot(_, _, _), professor(_)).

slot_room(slot(_, _, _), room(_, _)).

course_professor(course(_, _, _, _), professor(_)).

course_room(course(_, _, _, _), room(_, _)).

course_timeslots(course(_, _, _, _), slot(_, _, _)).

course_size(course(_, Size, _, _), Size).

room_capacity(room(_, Capacity), Capacity).

a:- 
schedule(S, P, T, R), labeling([], S).