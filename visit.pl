% Optimal visit path


% Builds Graph from adjacency constraint
buildGraph([]).

buildGraph([RoomName | RoomNames]):-
	buildGraph(RoomNames),
	adj(RoomName, Y),
	buildArcs(RoomName, Y).

% build arcs between RoomName and AdjRoomNames
buildArcs(RoomName, []).

buildArcs(RoomName, [AdjRoomName | AdjRoomNames]):-
	buildArcs(RoomName, AdjRoomNames),
	space(RoomId, _, RoomName, _, _, _, _, _, _, _, _, _, _, _, _),
	space(AdjRoomId, _, AdjRoomName, _, _, _, _, _, _, _, _, _, _, _, _),
	buildArcsFromId(RoomId, [AdjRoomId]).

buildArcsFromId(_, []).

buildArcsFromId(RoomId, [AdjRoomId | AdjRoomIds]):-
	buildArcsFromId(RoomId, AdjRoomIds),
	asserta(arc(RoomId, AdjRoomId)),
	asserta(arc(AdjRoomId, RoomId)).

buildArcsFromId([]).

buildArcsFromId([Id | Ids]):-
	buildArcsFromId(Ids),
	buildArcsFromId(Id, Ids).

% build nodes
buildNodes([]).

buildNodes([Id | Ids]):-
	buildNodes(Ids),
	asserta(node(Id)).

% break arcs between CorrId and a list of Ids 
breakArcs(_, []).

breakArcs(CorrId, [AdjToCorr | AdjToCorrs]):-
	breakArcs(CorrId, AdjToCorrs),
	retract(arc(CorrId, AdjToCorr)),
	retract(arc(AdjToCorr, CorrId)).

% Cleans the graph
% ie bypasses corridors
% ex: if 10 is a corridor, arc(9,10), arc(10, 12) becomes arc(9, 12) deleting node(10) too
cleanGraph([]).

cleanGraph([CorrId | CorrIds]):-
	cleanGraph(CorrIds),
	retract(node(CorrId)),
	findall(AdjToCorr, arc(CorrId, AdjToCorr), AdjToCorrs),
	breakArcs(CorrId, AdjToCorrs),
	buildArcsFromId(AdjToCorrs).

% rules to generate path
path(A, Z, Path) :- 
          path1(A, [Z], Path).

path1(A, [A|Path1], [A|Path1]).

path1(A, [Y|Path1], Path) :-
          arc(X,Y),
          not_member(X, Path1),
          path1(A, [X,Y|Path1], Path).

not_member(X, []).
not_member(X, [Y|L]) :-
          not_member(X, L),
          X \== Y. 

member(X, [X|L]).
member(X, [Y|L]) :- member(X, L).

% additional rules to generate hamiltonian acyclic path
hamiltonian(Path) :- 
          path(A, Z, Path),
          findall(X, node(X), Nodes),
          eq_set(Path, Nodes).

eq_set(P, N) :- 
          subset(P,N),
          subset(N,P).

subset([], S).
subset([A|L], S) :- 
         member(A, S),
         subset(L, S).

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
