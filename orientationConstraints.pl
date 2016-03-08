% Orientation constraints

% NEED SOME FUNCTION TO COLLECT ALL CONSTRAINTS AND POST THEM


% return empty list for no orientation constraint
orientationConstraint(_, _, [], _, []).

% distribute potential orientation constraints
orientationConstraint(Room, Floor, [X| Xs], Z, A):-
	orientationConstraint(Room, Floor, X, Z, B),
	orientationConstraint(Room, Floor, Xs, Z, C),
	A = B #\/ C.

% post constraints for rectangular rooms

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

% for L shaped rooms
orientationConstraint([Room1, Room2], Floor, X, A):-
	orientationConstraint(Room1, Floor, X, B),
	orientationConstraint(Room2, Floor, X, C),
	A = B #\/ C.
