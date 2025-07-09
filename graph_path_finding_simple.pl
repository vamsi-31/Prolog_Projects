path(A,B) :-   % two nodes are connected, if
  walk(A,B,[]) % - if we can walk from one to the other,
  .            % first seeding the visited list with the empty list

walk(A,B,V) :-       % we can walk from A to B...
  edge(A,X) ,        % - if A is connected to X, and
  not(member(X,V)) , % - we haven't yet visited X, and
  (                  % - either
    B = X            %   - X is the desired destination
  ;                  %   OR
    walk(X,B,[A|V])  %   - we can get to it from X
  )                  %
  .                  % Easy!

edge(a,e).
edge(e,d).
edge(d,c).
edge(c,b).
edge(b,a).
edge(d,a).
edge(e,c).
edge(f,b).