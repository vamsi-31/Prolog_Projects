parent(Z,Y) :- father(Z,Y) ; mother(Z,Y).

sibling(kabir,akash).
sibling(sue,akash).
sibling(nancy,jeff).
sibling(nancy,ron).
sibling(jell,ron).

sibling(X,Y):-
parent(A,X),
parent(A,Y),
not(X=Y).

sister(X, Y) :-
      sibling(X, Y),
      female(X),
      not(X = Y).

brother(X, Y) :-
      sibling(X, Y),
      male(X),
      not(X = Y).

grandparent(C,D) :- parent(C,E), parent(E,D).
cousin(X,Y) :- father(Z,X),brother(Z,W),father(W,Y).

aunt(X,Y) :-
  parent(Z,Y), sister(X,Z). 
aunt(X, Y) :- female(X), sibling(X, Z), parent(Z, Y).
% aunt(X, Y) :- female(X), spouse(X, W), sibling(W, Z), parent(Z, Y).


uncle(X,Y) :-
  parent(Z,Y), brother(X,Z). 
male(ram).
male(mahesh).
male(kabir).
male(pawankalyan).
male(ganesh).
male(surya).

female(lakshmi).
female(sita).
female(gita).
female(samantha).
female(samera).
female(bindu).

mother(lakshmi, ram).
mother(lakshmi, mahesh).
mother(sita, kabir).
mother(sita, pawankalyan).
mother(samantha, surya).

father(ram, sita).
father(ram, kabir).
father(kabir, gita).
father(kabir, ganesh).
father(mahesh, pawankalyan).


