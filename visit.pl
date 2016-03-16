% Optimal visit path

% arcs work both ways
arc(X,Y) :- arc(Y,X).


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
	asserta(arc(RoomId, AdjRoomId)).

% build nodes
buildNodes([]).

buildNodes([Id | Ids]):-
	buildNodes(Ids),
	asserta(node(Id)).

% build arcs between all the elements of the list 2 by 2
buildArcs([_]).

buildArcs([RoomName | RoomNames]):-
	buildArcs(RoomNames),
	buildArcs(RoomName, RoomNames).

% break arcs between CorrId and a list of Ids 
breakArcs(_, []).

breakArcs(CorrId, [AdjToCorr | AdjToCorrs]):-
	breakArcs(CorrId, AdjToCorrs),
	(arc(CorrId, AdjToCorr) -> retract(arc(CorrId, AdjToCorr)) ; retract(arc(AdjToCorr, CorrId))).

% Cleans the graph
% ie bypasses corridors
% ex: if 10 is a corridor, arc(9,10), arc(10, 12) becomes arc(9, 12) deleting node(10) too
cleanGraph([]).

cleanGraph([CorrId | CorrIds]):-
	cleanGraph(CorrIds),
	retract(node(CorrId)),
	findall(AdjToCorr, arc(corrId, AdjToCorr), AdjToCorrs),
	breakArcs(CorrId, AdjToCorrs),
	buildArcs(AdjToCorrs), 

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
	buildGraph(RoomNames),
	findall(Id, space(Id, _,_,_,_,_,_,_,_,_,_,_,_,_,_), Ids),
	buildNodes(Ids),
	findall(CorrId, space(CorrId, corridor, _, _, _, _, _, _, _, _, _, _, _, _, _), CoorIds),
	cleanGraph(CoorIds),
	hamiltonian(X).
