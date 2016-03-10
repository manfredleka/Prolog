% GETTERS

getId(SpaceVar, Id):-
	arg(1, SpaceVar, Id).

getH(SpaceVar, VarH):-
	arg(SpaceVar,2,VarH).

geth(SpaceVar, Varh):-
	arg(SpaceVar, 3, Varh).

getV(SpaceVar, V):-
	arg(SpaceVar, 4, V).

getv(SpaceVar, Varv):-
	arg(SpaceVar, 5, Varv).

getSurf(SpaceVar, Surf):-
	arg(SpaceVar, 6, Surf).

getCoordinates(SpaceVar, Coord):-
	arg(SpaceVar, 7, Coord).

getName(SpaceVar, Name):-
	arg(SpaceVar, 8, Name).

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