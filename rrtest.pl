a:-
read(A),
write('Product 1:- '),
write('Enter the product name:- '),
read(Name1,DOM1,Price1),
write('Enter the product price:- '),
write('Enter the products Manufacturing date:- '),
maplist(Name1,Price1,Dom1,E),
format("Even Numbers: ~w~n",[E]).