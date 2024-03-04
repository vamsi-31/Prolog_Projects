s:-
write('Enter The name of the student'),
read(X),nl,
A is 0,
B is 0,
write('Number of subjects enrolled'),
read(Y),
loop(0),
loop(Y):-Y>0,write('Enter maximum marks of subject'),read(Z),nl,

             write('Enter obtained marks of subject'),read(R),nl,
             A is A+Z,
             B is B+R,
             S is Y-1, loop(S). 
C is (B/A).
write('Percentage'),write(C),nl.
             
 

