male(ram).
male(mahesh).
male(mohan).
male(pawankalyan).
male(ganesh).
male(surya).
male(ravi).
male(krishna).
male(kumar).
male(vijay).
female(bindhu).
female(lakshmi).
female(sita).
female(gita).
female(samantha).
female(shreya).
female(radha).

parent(ravi,ganesh).
parent(ravi,mahesh).
parent(shreya,ganesh).
parent(shreya,mahesh).
parent(ganesh,sita).
parent(ganesh, gita).
parent(radha,sita).
parent(radha, gita).
parent(mahesh,krishna).
parent(mahesh,kumar).
parent(lakshmi, krishna).
parent(lakshmi,kumar).
parent(kumar,pawankalyan).
parent(gita,pawankalyan).
parent(mohan,radha).
parent(samantha,radha).
parent(vijay,lakshmi).
parent(bindu,laksmi).
 
father(X,Y):- male(X),
    parent(X,Y).
 
mother(X,Y):- female(X),
    parent(X,Y).
 
grandfather(X,Y):- male(X),
    parent(X,Z),
    parent(Z,Y).
 
grandmother(X,Y):- female(X),
    parent(X,Z),
    parent(Z,Y).
 
sister(X,Y):- %(X,Y or Y,X)%
    female(X),
    father(F, Y), father(F,X),X \= Y.
 
sister(X,Y):- female(X),
    mother(M, Y), mother(M,X),X \= Y.
 
aunt(X,Y):- female(X),
    parent(Z,Y), sister(Z,X),!.
 
brother(X,Y):- %(X,Y or Y,X)%
    male(X),
    father(F, Y), father(F,X),X \= Y.
 
brother(X,Y):- male(X),
    mother(M, Y), mother(M,X),X \= Y.
 
uncle(X,Y):-
    parent(Z,Y), brother(Z,X).
 
ancestor(X,Y):- parent(X,Y).
ancestor(X,Y):- parent(X,Z),
    ancestor(Z,Y).