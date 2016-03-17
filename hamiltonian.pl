% Figure 9.20    Finding an acyclic path, Path, from A to Z in Graph.

% path( A, Z, Graph, Path): Path is an acyclic path from A to Z in Graph
path( A, Z, Path):-
    path1( A, [Z], Path).

% path1( A, Path1, G, Path) if there is an acyclic Path 
% that starts from A and ends with Path1 
path1( A, [A | Path1], [A | Path1] ).

path1( A, [Y | Path1], Path):-
    adjacent( X, Y),
    not( member( X, Path1)),                                                % No-cycle condition
    path1( A, [X, Y | Path1], Path).

% adjacent for graphs represented by node and edge sets (represented as lists)
adjacent( X,Y):-
 	e(X,Y)
 	;
	e(Y,X).

% Hamiltonian path
hamiltonian( Path):-
 path(_,_,Path),
 covers(Path).

covers(Path):-
 not((node(N), not(member(N, Path)))).

