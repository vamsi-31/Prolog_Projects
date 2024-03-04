s:-
write('Enter The current State Of 4 Litre Jug'),nl,
read(X),nl,
write('Enter The current State Of 3 Litre Jug'),nl,
read(Y),nl,
state(X,Y).
state(X,Y):-X>4,
write('The Jug Capacity is 4 litre so it cant take more than 4 litre'),nl,
write('The solution for this Situvation is not practically possible'),nl.
state(X,Y):-Y>3,
write('The Jug Capacity is 3 litre so it cant take more than 3 litre'),nl,
write('The solution for this Situvation is not practically possible'),nl.
state(X,Y):-X>4,Y>3,
write('The Jug Capacity is 4 litre so it cant take more than 4 litre and The Jug Capacity is 3 litre so it cant take more than 3 litre '),nl,
write('The solution for this Situvation is not practically possible').
state(X,Y):-X=:=2,Y=:=0,
write('The solution for this Situvation is  practically possible and reached'),nl.
state(X,Y):-X=:=2,Y>0,nl,
write('Pour The Water In JUG B out The Soloution Can be achived'),nl,
write('The solution for this Situvation is  practically possible and reached'),nl.
state(X,Y):-X=0,Y=2,
write('Pour The Water In JUG B to Jug A The Soloution Can be achived'),nl,
write('The solution for this Situvation is  practically possible and reached'),nl.
state(X,Y):-X>0,Y=2,X<4,nl,
write('Pour The Water In JUG A Out and then pour water of JUG B In JUg A The Soloution Can be achived'),nl,
write('The solution for this Situvation is  practically possible and reached'),nl.
state(X,Y):-Y=2,X=4,nl,
write('Pour The Water In JUG A Out and then pour water of JUG B In JUg A The Soloution Can be achived'),nl,
write('The solution for this Situvation is  practically possible and reached'),nl.
state(X,Y):-X>=3,Y=1,
write('Pour The Water of Jug2 in Jug1 The final State is Reached').
state(X,Y):-X=3,Y=3,nl,
write('Pour The Water In JUG A to JUG B  and then pour water of JUG B OUt The Soloution Can be achived'),nl,
write('The solution for this Situvation is  practically possible and reached'),nl.
state(X,Y):-X<4,X>0,Y=3,nl,
write('Pour The Water In JUG A to JUG B  and then pour water of JUG B OUt The Soloution Can be achived'),nl,
write('The solution for this Situvation is  practically possible and reached'),nl.
state(X,Y):-X=4,Y=3,nl,
write('Pour The water In JUg B out'),nl,
write('Pour The Water In JUG A to JUG B  and then pour water of JUG B OUt The Soloution Can be achived'),nl,
write('The solution for this Situvation is  practically possible and reached'),nl.
