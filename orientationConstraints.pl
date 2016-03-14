% Orientation constraints
% handles each room orientation, ie to the north, west, east, south, etc...
% for L shaped rooms, orientation constraint on room1 OR on room2 
% for mutiple orientation, OR distribution

% post the collected constraints on all the rooms

postOrientationConstraints([], _, _).

postOrientationConstraints([RoomName | RoomNames], SpaceVarList, FloorSpaceVar):-
	postOrientationConstraints(RoomNames, SpaceVarList, FloorSpaceVar),
	contour(RoomName, OrientationList),
	getSpaceVarFromName(RoomName, SpaceVarList, RoomSpaceVar),
	getCoordinates(RoomSpaceVar, RoomCoord),
	getOrientationConstraint(RoomCoord, OrientationList, FloorSpaceVar, A),
	call(A).

getOrientationConstraint(RoomCoord,[AltOrientation], FloorSpaceVar, A):-
	buildOrientationConstraint(RoomCoord, AltOrientation, FloorSpaceVar, A).

getOrientationConstraint(RoomCoord, [AltOrientation1 | Alts], FloorSpaceVar, A):-
	getOrientationConstraint(RoomCoord, Alts, FloorSpaceVar, C),
	buildOrientationConstraint(RoomCoord, AltOrientation1, FloorSpaceVar, B),
	A = (B #\/ C).

buildOrientationConstraint([Room1, []], Orientation, FloorSpaceVar, A):-
	getCoordinates(FloorSpaceVar, [FloorCoord, _]),
	orientationConstraint(Room1, FloorCoord, Orientation, A).

buildOrientationConstraint([Room1, Room2], Orientation, FloorSpaceVar, A):-
	getCoordinates(FloorSpaceVar, [FloorCoord, _]),
	orientationConstraint(Room1, FloorCoord, Orientation, B),
	orientationConstraint(Room2, FloorCoord, Orientation, C),
	A = (B #\/ C).

% collect constraints for rectangular rooms
% return whatever for empty room 
orientationConstraint([], _,_,_).

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
	A = (B #/\ C).

orientationConstraint(RoomCoord,FloorCoord,  no, A):-
	orientationConstraint(RoomCoord, FloorCoord, n, B),
	orientationConstraint(RoomCoord, FloorCoord, o, C),
	A = (B #/\ C).

orientationConstraint(RoomCoord,FloorCoord,  so, A):-
	orientationConstraint(RoomCoord, FloorCoord, s, B),
	orientationConstraint(RoomCoord, FloorCoord, o, C),
	A = (B #/\ C).

orientationConstraint(RoomCoord,FloorCoord,  se, A):-
	orientationConstraint(RoomCoord, FloorCoord, s, B),
	orientationConstraint(RoomCoord, FloorCoord, e, C),
	A = (B #/\ C).

