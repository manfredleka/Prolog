% ADJACENCY CONSTRAINTS
% adjacency constraint btween two rectangles with an intersection of at least 1 meter width for a door

% collect and post the adjacency constraints 
postAdjacencyConstraints([] , _).

postAdjacencyConstraints([RoomName | ListRoomNames], SpaceVarList):-
	postAdjacencyConstraints(ListRoomNames, SpaceVarList),
	adj(RoomName, AdjRoomNames),
	getAdjacencyConstraint(RoomName, AdjRoomNames, SpaceVarList, A),
	call(A).

getAdjacencyConstraint(RoomName, [AdjRoomName], SpaceVarList, A):-
	getSpaceVarFromName(RoomName, SpaceVarList, RoomSpaceVar),
	getCoordinates(RoomSpaceVar, RoomCoord),
	getSpaceVarFromName(AdjRoomName, SpaceVarList, AdjRoomSpaceVar),
	getCoordinates(AdjRoomSpaceVar, AdjRoomCoord),
	adjacencyConstraint(RoomCoord, AdjRoomCoord, A).

getAdjacencyConstraint(RoomName, [AdjRoomName | AdjRoomNames], SpaceVarList, A):-
	getAdjacencyConstraint(RoomName, AdjRoomNames, SpaceVarList, B),
	getSpaceVarFromName(RoomName, SpaceVarList, RoomSpaceVar),
	getCoordinates(RoomSpaceVar, RoomCoord),
	getSpaceVarFromName(AdjRoomName, SpaceVarList, AdjRoomSpaceVar),
	getCoordinates(AdjRoomSpaceVar, AdjRoomCoord),
	adjacencyConstraint(RoomCoord, AdjRoomCoord, C),
	A = (B #\/ C).   % marche qu'avec ET pas avec OU...


% adjacency constraint on two rectangular rooms
adjacencyConstraint([X1, H1, Y1, V1], [X2, H2, Y2, V2], A):-
	A = (#\(
			((X1 #>= X2+H2) #/\(Y1#>=Y2+V2)) 
			#\/ ((X1#>=X2+H2)#/\(Y1#=<Y2-V1))
			#\/ ((X1#=<X2-H1)#/\(Y1#=<Y2-V1))
			#\/ ((X1#=<X2-H1)#/\(Y1#>=Y2+V2))
			)).

% OR distribution of adjacency constraint for L shaped rooms
% sinon adjacencyConstraint([], _,_). + check si nonvar(A) avant call mais 
% problème d'argument insuffisamment instancié quand même...

adjacencyConstraint([Room1, []], Room2, A):-
	adjacencyConstraint(Room1, Room2, A).

adjacencyConstraint(Room1, [Room2, Room3], A):-
	adjacencyConstraint([Room2, Room3], Room1, A).

adjacencyConstraint([Room1, Room2], Room3, A):-
	adjacencyConstraint(Room1, Room3, B),
	adjacencyConstraint(Room2, Room3, C),
	A = (B #\/ C).



