% Optimal visit path

:- dynamic(arc/2).

traceGraph(X):-
	findall(X, adj(X, _), AdjRooms),
	buildGraph(AdjRooms).


buildGraph([]).

buildGraph([AdjRoomFrom | AdjRooms]):-
	buildGraph(AdjRooms),
	adj(AdjRoomFrom, AdjRoomTos),
	buildArc(AdjRoomFrom, AdjRoomTos).

buildArc(AdjRoomFrom, [AdjRoomTo | AdjRoomTos]):-
	builArc(AdjRoomFrom, AdjRoomTos)
	buildArc(AdjRoomFrom, AdjRoomTo)
