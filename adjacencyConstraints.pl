% ADJACENCY CONSTRAINTS

% adjacency constraint btween two rectangles with an intersection of at least 1 meter width for a door
adjacencyConstraint([X1, H1, Y1, V1], [X2, H2, Y2, V2], A):-
	A = (X2 #>= X1) #/\ (X2 + 1 #=< X1 + H1) #/\ ((Y2 #= Y1 + V1 ) #\ (Y2 #= Y1)).

adjacencyConstraint([[Room1], [Room2]], Room3, A):-
	adjacencyConstraint(Room1, Room3, B),
	adjacencyConstraint(Room2, Room3, C),
	A = B #\/ C.