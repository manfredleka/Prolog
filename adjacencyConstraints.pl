% ADJACENCY CONSTRAINTS
% adjacency constraint btween two rectangles with an intersection of at least 1 meter width for a door

% collect and post the adjacency constraints 
postAdjacencyConstraints([AdjRoomName |AdjRoomNames], SpaceVarList):-
	postAdjacencyConstraints(AdjRoomNames, SpaceVarList),
	adj(AdjRoomName, AdjList)),
	getSpaceVarFromName(AdjRoomName, AdjRoomSpaceVar),
	getCoordinates(AdjRoomSpaceVar, AdjRoomCoord),
	getAdjacencyConstraint(AdjRoomCoord, AdjList, SpaceVarList, A),
	call(A).


getAdjacencyConstraint(_, [], _, _).

getAdjacencyConstraints(AdjRoomCoord, [Room1Name | RoomNames], SpaceVarList, A):-
	getAdjacencyConstraints(AdjRoomCoord, RoomNames,SpaceVarList, C),
	getSpaceVarFromName(Room1Name, SpaceVarList, Room1SpaceVar),
	getCoordinates(Room1SpaceVar, Room1Coord),
	adjacencyContraint(AdjRoomCoord, Room2Coord, B),
	(nonvar(C) -> 
		A = B #/\ C;
		A = B
	).	

% adjacency constraint on two rectangular rooms
adjacencyConstraint([X1, H1, Y1, V1], [X2, H2, Y2, V2], A):-
	A = (((X2 #>= X1) #/\ (X2 + 1 #=< X1 + H1) #/\ ((Y2 #= Y1 + V1 ) #\ (Y2 + V2 #= Y1)))
			#\ ((Y2 #>= Y1) #/\ (Y2 + 1 #=< Y1 + V1) #/\ ((X2 + H2 #= X1) #\ (X2 #= X1 + H1)))).


% OR distribution of adjacency constraint for L shaped rooms
adjacencyConstraint([Room1, []], Room2, A):-
	adjacencyConstraint(Room1, Room2, A).

adjacencyConstraint(Room1, [Room2, Room3], A):-
	adjacencyConstraint([Room2, Room3], Room1, A).

adjacencyConstraint([Room1, Room2], Room3, A):-
	adjacencyConstraint(Room1, Room3, B),
	adjacencyConstraint(Room2, Room3, C),
	A = B #\/ C.


