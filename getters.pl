% GETTERS

getId(SpaceVar, Id):-
	arg(1, SpaceVar, Id).

getH(SpaceVar, VarH):-
	arg(2, SpaceVar,VarH).

geth(SpaceVar, Varh):-
	arg(3, SpaceVar, Varh).

getV(SpaceVar, V):-
	arg(4, SpaceVar, V).

getv(SpaceVar, Varv):-
	arg(5, SpaceVar, Varv).

getSurf(SpaceVar, Surf):-
	arg(6, SpaceVar, Surf).

getCoordinates(SpaceVar, Coord):-
	arg(7, SpaceVar, Coord).

getName(SpaceVar, Name):-
	arg(8, SpaceVar, Name).

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

