% Optimal visit path
:- consult(hamiltonian).

% Builds Graph from adjacency constraint
buildGraph([]).

buildGraph([RoomName | RoomNames]):-
	buildGraph(RoomNames),
	adj(RoomName, Y),
	buildEdges(RoomName, Y).

% build arcs between RoomName and AdjRoomNames
buildEdges(RoomName, []).

buildEdges(RoomName, [AdjRoomName | AdjRoomNames]):-
	buildEdges(RoomName, AdjRoomNames),
	space(RoomId, _, RoomName, _, _, _, _, _, _, _, _, _, _, _, _),
	space(AdjRoomId, _, AdjRoomName, _, _, _, _, _, _, _, _, _, _, _, _),
	buildEdgesFromId(RoomId, [AdjRoomId]).

buildEdgesFromId(_, []).

buildEdgesFromId(RoomId, [AdjRoomId | AdjRoomIds]):-
	buildEdgesFromId(RoomId, AdjRoomIds),
	(not(e(RoomId, AdjRoomId)) -> asserta(e(RoomId, AdjRoomId)); !),
	(not(e(AdjRoomId, RoomId)) -> asserta(e(AdjRoomId, RoomId)); !).

buildEdgesFromId([]).

buildEdgesFromId([Id | Ids]):-
	buildEdgesFromId(Ids),
	buildEdgesFromId(Id, Ids).

% build nodes
buildNodes([]).

buildNodes([Id | Ids]):-
	buildNodes(Ids),
	asserta(node(Id)).

% break arcs between CorrId and a list of Ids 
breakEdges(_, []).

breakEdges(CorrId, [AdjToCorr | AdjToCorrs]):-
	breakEdges(CorrId, AdjToCorrs),
	(e(CorrId, AdjToCorr) -> retract(e(CorrId, AdjToCorr))),
	(e(AdjToCorr, CorrId) -> retract(e(AdjToCorr, CorrId))).

% Cleans the graph
% ie bypasses corridors
% ex: if 10 is a corridor, arc(9,10), arc(10, 12) becomes arc(9, 12) deleting node(10) too
cleanGraph([]).

cleanGraph([CorrId | CorrIds]):-
	cleanGraph(CorrIds),
	retract(node(CorrId)),
	findall(AdjToCorr, e(CorrId, AdjToCorr), AdjToCorrs),
	breakEdges(CorrId, AdjToCorrs),
	buildEdgesFromId(AdjToCorrs).

% main rule, returns the optimal visit path
visit(X):-
	findall(Y, adj(Y,_), RoomNames),
	writeln('initiating graph construction'),
	buildGraph(RoomNames),
	writeln('graph built'),

	findall(Id, space(Id, _,_,_,_,_,_,_,_,_,_,_,_,_,_), Ids),
	writeln('initiating nodes construction'),
	buildNodes(Ids),
	retract(node(0)),
	writeln('nodes builts'),

	findall(CorrId, space(CorrId, corridor, _, _, _, _, _, _, _, _, _, _, _, _, _), CorrIds),
	writeln('initiating cleaning graphs of corridors'),
	cleanGraph(CorrIds),
	writeln('graph cleaned'),

	writeln('initiating hamiltonian circuit search'),
	hamiltonian(X).
