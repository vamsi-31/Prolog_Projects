%%%%%%Reem Ahmed 46-13896

courses([(csen403,2),(csen905,2),(csen709,1),(csen601,2),(csen301,3),(csen701,2)
,(csen503,3),(csen501,2)]).

slots([slot(sunday,1),slot(sunday,2),slot(sunday,3),slot(monday,1),slot(monday,2),
slot(monday,3),slot(tuesday,1),slot(tuesday,2),slot(tuesday,3),slot(wednesday,1),
slot(wednesday,2),slot(wednesday,3)]).

greedyDivisionList([1,2,2,2,2,3]).

putSlotsHelper(_,[]). 
putSlotsHelper([(H,_)|T],[H|T1]):-
    putSlotsHelper(T,T1).

putSlots(L):-
  slots(Lis),
  putSlotsHelper(L,Lis).

courseNotDone([],_).
courseNotDone([H|T],Subject):-
    \+ H = Subject , 
    courseNotDone(T,Subject).  

pickAnotDoneCourse([(Subject,Num)|_],DoneCourses,(Subject,Num)):-
   courseNotDone(DoneCourses,Subject).  
pickAnotDoneCourse([C1|T],DoneCourses,C):-
   \+ C1=C,
   pickAnotDoneCourse(T,DoneCourses,C).

findAndGetSlot(_,0,_,0).
findAndGetSlot([],_,_,0):-
  fail.
findAndGetSlot([(_,X)|T],N,ON,C):- 
%C is index of the last slot of the N consecutive slots 
   N>0,
   var(X),
   N1 is N-1,
   findAndGetSlot(T,N1,ON,C1),
   C is C1 + 1.
findAndGetSlot([(_,X)|T],_,ON,C):-
   \+ var(X),
   findAndGetSlot(T,ON,ON,C1),
   C is C1+1.


%%BASE
schedulingHelper(_,_,N,FirstVacant,LastVacant):-
  LastVacant is N + FirstVacant .

schedulingHelper([(_,Name)|T],Name,N,FirstVacant,Pointer):-
  Pointer>=FirstVacant,
  MovedPointer is Pointer + 1 ,
  schedulingHelper(T,Name,N,FirstVacant,MovedPointer).

schedulingHelper([_|T],Name,N,FirstVacant,Pointer):-
   Pointer<FirstVacant , 
   MovedPointer is Pointer + 1 ,
   schedulingHelper(T,Name,N,FirstVacant,MovedPointer).
   
scheduleCourse(L,Name,N):-
  findAndGetSlot(L,N,N,LastVacant),
  FirstVacant is LastVacant - N + 1 ,
  schedulingHelper(L,Name,N,FirstVacant,1).
   
removeFromNotDone(_,[],[]).
removeFromNotDone(C,[H|T],[H|T1]):-
  \+ C = H,
  removeFromNotDone(C,T,T1).

removeFromNotDone(C,[C|T],L):-
  removeFromNotDone(C,T,L).

addToDoneCourses([],E,[E]).
addToDoneCourses([H|T],E,[H|T1]):- 
  addToDoneCourses(T,E,T1).

getAllWithSameSlotNum([],_,_).
getAllWithSameSlotNum([(_,NumS)|T],NumS,O):-
    getAllWithSameSlotNum(T,NumS,O1),
    O is O1+1.
getAllWithSameSlotNum([(_,N)|T],NumS,O):-
    \+ N = NumS,
    getAllWithSameSlotNum(T,NumS,O).

getAllSlotsWithOccur(_,3,_).
getAllSlotsWithOccur(NumOfSlotsneed,[(NumOfSlotsneed,O)|T]):-
   courses(List),
   getAllWithSameSlotNum(List,NumOfSlotsneed,O),
   NumOfSlotsneedupdate is NumOfSlotsneed +1 , 
   getAllSlotsWithOccur(NumOfSlotsneedupdate,T).

%Trying to implement my own greedy division list of the available slots
%greedyDivision([],_). 
%greedyDivision(AvailableSlots,[H|T],L):-
%   getAllSlotsWithOccur(1,[H|T]).
%  dividegreedy(AvailableSlots,[H|T],L).


ensureGoodPick(NotDoneSubjects,DoneSubjects,(CourseName,NumOfSlots),NumOfSlots):-
   pickAnotDoneCourse(NotDoneSubjects,DoneSubjects,(CourseName,NumOfSlots)).
ensureGoodPick(NotDoneSubjects,DoneSubjects,(CourseName,NumOfSlots),H):-
   pickAnotDoneCourse(NotDoneSubjects,DoneSubjects,(CourseName,NumOfSlots)),
   \+ H = NumOfSlots , 
   removeFromNotDone((CourseName,NumOfSlots),NotDoneSubjects,NotDoneNew),
   ensureGoodPick(NotDoneNew,DoneSubjects,(CourseName,NumOfSlots),H).

scheduleHelper(_,_,_,0,0,_).

scheduleHelper(L,DoneSubjects,NotDoneSubjects,AvailableSlots,DoneSubjN,[H|T]) :-
  ensureGoodPick(NotDoneSubjects,DoneSubjects,(CourseName,NumOfSlots),H),
  AvailableSlots >= NumOfSlots ,
  scheduleCourse(L,CourseName,NumOfSlots), 
  addToDoneCourses(DoneSubjects,CourseName,DoneNew),
  removeFromNotDone((CourseName,NumOfSlots),NotDoneSubjects,NotDoneNew),
  AvailableSlotsNew is AvailableSlots - NumOfSlots , 
  scheduleHelper(L,DoneNew,NotDoneNew,AvailableSlotsNew,DoneSubjNplus,T),
  DoneSubjN is DoneSubjNplus + 1 .

schedule(L,DoneSubjects,NotDoneSubjects,AvailableSlots,DoneSubjN) :-
  greedyDivisionList(List),
  scheduleHelper(L,DoneSubjects,NotDoneSubjects,AvailableSlots,DoneSubjN,List).

solve(L,DoneSubjN):-
 putSlots(L), %L is a list of all slots with unassigned variable
 length(L,N), %N is the number of available slots 
 courses(NotDone),
 sort(2,@=<,NotDone,SortedCourses), %A greedy approach to the maximization problem at hand
 %Sorted Courses is a list of slots ordered from least demanding to highest demanding with arity (Course,NumSlots)
 schedule(L,[],SortedCourses,N,DoneSubjN).