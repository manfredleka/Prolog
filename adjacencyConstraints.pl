% ADJACENCY CONSTRAINTS
% adjacency constraint btween two rectangles with an intersection of at least 1 meter width for a door

% collect and post the adjacency constraints 
postAdjacencyConstraints(SpaceVarList):-
	postAdjacencyConstraints(SpaceVarList, SpaceVarList).

postAdjacencyConstraints([], _).

postAdjacencyConstraints([SpaceVar | SpaceVarList], WholeList):-
	getName(SpaceVar, SpaceVarName),
	(adj(SpaceVarName, X) ->
		getAdjacencyConstraints(SpaceVar, X, WholeList, A),
		call(A)
	),
	postAdjacencyConstraints(SpaceVarList, WholeList).


getAdjacencyConstraints(_, [], _, A).

getAdjacencyConstraints(Room1SpaceVar, [Room2Name | Xs], WholeList, A):-
	getSpaceVarFromName(Room2Name, WholeList, Room2SpaceVar),
	getCoordinates(Room1SpaceVar, Room1Coord),
	getCoordinates(Room2SpaceVar, Room2Coord),
	adjacencyContraint(Room1Coord, Room2Coord, B),
	A = A #/\ B,
	getAdjacencyConstraints(Room1SpaceVar, Xs, WholeList, A).
	

% adjacency constraint on two rectangular rooms
adjacencyConstraint([X1, H1, Y1, V1], [X2, H2, Y2, V2], A):-
	A = ((X2 #>= X1) #/\ (X2 + 1 #=< X1 + H1) #/\ ((Y2 #= Y1 + V1 ) #\ (Y2 + V2 #= Y1)))
			#\ ((Y2 #>= Y1) #/\ (Y2 + 1 #<= Y1 + V1) #/\ ((X2 + H2 #= X1) #\ (X2 #= X1 + H1))).

% OR distribution of adjacency constraint for L shaped rooms
adjacencyConstraint([Room1, Room2], Room3, A):-
	adjacencyConstraint(Room1, Room3, B),
	adjacencyConstraint(Room2, Room3, C),
	A = B #\/ C.

adjacencyConstraint(Room1, [Room2, Room3], A):-
	adjacencyConstraint([Room2, Room3], Room1, A).