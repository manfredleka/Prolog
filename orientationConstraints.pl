% Orientation constraints
% handles each room orientation, ie to the north, west, east, south, etc...
% for L shaped rooms, orientation constraint on room1 OR on room2 
% for mutiple orientation, OR distribution

% post the collected constraints on all the rooms
postOrientationConstraints(FloorSpaceVar, SpaceVarList):-
	collectOrientationConstraints(FloorSpaceVar, SpaceVarList, A),
	call(A).

% collect constraints
collectOrientationConstraints(_, [], A).

collectOrientationConstraints(FloorSpaceVar, [SpaceVar | SpaceVarList], A):-
	getName(SpaceVar, Name),
	(contour(Name, X) ->
		getCoordinates(SpaceVar, RoomCoord),
		getCoordinates(FloorSpaceVar, FloorCoord),
		orientationConstraint(RoomCoord, FloorCoord, X, B),
		A = B #/\ A
	),
	collectOrientationConstraints(FloorSpaceVar, SpaceVarList, A).

% return empty list for no orientation constraint
orientationConstraint(_, _, [], _, []).

% distribute potential orientation constraints
orientationConstraint(RoomCoord, FloorCoord, [X| Xs], A):-
	orientationConstraint(RoomCoord, FloorCoord, X, Z, B),
	orientationConstraint(RoomCoord, FloorCoord, Xs, Z, C),
	A = B #\/ C.

% distribute constraints on each subroom for L shaped rooms
orientationConstraint([Room1, Room2], FloorCoord, X, A):-
	orientationConstraint(Room1, FloorCoord, X, B),
	orientationConstraint(Room2, FloorCoord, X, C),
	A = B #\/ C.

% collect constraints for rectangular rooms
% return empty list for empty room 
orientationConstraint([], _,_,_,[]).

orientationConstraint([_,_,RoomY,RoomV], [_, _, _, FloorV], n, A):-
	A = (RoomY + RoomV #= FloorV).

orientationConstraint([_,_,RoomY,_],[_, _, _, _],  s, A):-
	A = (RoomY #= 0).

orientationConstraint([RoomX,RoomH,_,_],[_, FloorH, _, _],  e, A):-
	A = (RoomX + RoomH #= FloorH).

orientationConstraint([RoomX,_,_,_],[_, _, _, _],  o, A):-
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

