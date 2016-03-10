% Orientation constraints
% handles each room orientation, ie to the north, west, east, south, etc...
% for L shaped rooms, orientation constraint on room1 OR on room2 
% for mutiple orientation, OR distribution

% post the collected constraints on all the rooms

postOrientationConstraints(_, []).

postOrientationConstraints(FloorSpaceVar, [SpaceVar | SpaceVarList]):-
	postOrientationConstraints(FloorSpaceVar, SpaceVarList),
	getName(SpaceVar, SpaceVarName),
	contour(SpaceVarName, X),
	(nonvar(X) -> 
		getCoordinates(SpaceVar, SpaceVarCoord),
		getCoordinates(FloorSpaceVar, FloorCoord),
		orientationConstraint(SpaceVarCoord, FloorCoord, X, A),
		call(A)
	).



% return whatever for no orientation constraint
orientationConstraint(_, _, [], _, _).

% distribute potential orientation constraints
orientationConstraint(RoomCoord, FloorCoord, [X| Xs], A):-
	orientationConstraint(RoomCoord, FloorCoord, X, Z, B),
	orientationConstraint(RoomCoord, FloorCoord, Xs, Z, C),
	(nonvar(C) -> 
		A = B #\/ C;
		A = B;
	).

% distribute constraints on each subroom for L shaped rooms
orientationConstraint([Room1, Room2], FloorCoord, X, A):-
	orientationConstraint(Room1, FloorCoord, X, B),
	orientationConstraint(Room2, FloorCoord, X, C),
	A = B #\/ C.

% collect constraints for rectangular rooms
% return whatever for empty room 
orientationConstraint([], _,_,_,_).

orientationConstraint([_,_,RoomY,RoomV], [_, _, _, FloorV], n, A):-
	A = (RoomY + RoomV #= FloorV).

orientationConstraint([_,_,RoomY,_],_,  s, A):-
	A = (RoomY #= 0).

orientationConstraint([RoomX,RoomH,_,_],[_, FloorH, _, _],  e, A):-
	A = (RoomX + RoomH #= FloorH).

orientationConstraint([RoomX,_,_,_], _,  o, A):-
	A = (RoomX #= 0).

orientationConstraint(RoomCoord, FloorCoord, ne, A):-
	orientationConstraint(RoomCoord, FloorCoord, n, B),
	orientationConstraint(RoomCoord, FloorCoord, e, C),
	A = B #/\ C.

orientationConstraint(RoomCoord,FloorCoord,  no, A):-
	orientationConstraint(RoomCoord, FloorCoord, n, B),
	orientationConstraint(RoomCoord, FloorCoord, o, C),
	A = B #/\ C.

orientationConstraint(RoomCoord,FloorCoord,  so, A):-
	orientationConstraint(RoomCoord, FloorCoord, s, B),
	orientationConstraint(RoomCoord, FloorCoord, o, C),
	A = B #/\ C.

orientationConstraint(RoomCoord,FloorCoord,  se, A):-
	orientationConstraint(RoomCoord, FloorCoord, s, B),
	orientationConstraint(RoomCoord, FloorCoord, e, C),
	A = B #/\ C.

