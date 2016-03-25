% GETTERS

getId(SpaceVar, Id):-
	arg(1, SpaceVar, Id).

getCoordinates(SpaceVar, Coord):-
	arg(2, SpaceVar, Coord).

getName(SpaceVar, Name):-
	arg(3, SpaceVar, Name).

getSpaceVarFromName(_, [], _):- 
	fail.

getSpaceVarFromName(SpaceVarName, [SpaceVar | SpaceVarList], X):-
	(getName(SpaceVar, SpaceVarName) ->
		X = SpaceVar;
		getSpaceVarFromName(SpaceVarName, SpaceVarList, X)
	).


getAllCoordinates(FloorSpaceVar, [], A):-
	getCoordinates(FloorSpaceVar, FloorCoord),
	A = FloorCoord.

getAllCoordinates(FloorSpaceVar, [SpaceVar | SpaceVarList], A):-
	getAllCoordinates(FloorSpaceVar, SpaceVarList, B),
	getCoordinates(SpaceVar, Coord),
	A = [Coord, B].

