% Surface constraints
% ensure the dimensions of each room respects its own surface constraint

postSurfaceConstraints([]).

postSurfaceConstraints([SpaceVar | SpaceVarList]):-
	postSurfaceConstraints(SpaceVarList),
	getSurf(SpaceVar, Surf),
	getCoordinates(SpaceVar, [Room1Coord, Room2Coord]),
	computeSurf(Room1Coord, Res1),
	computeSurf(Room2Coord, Res2),
	Res1 + Res2 #= Surf.

computeSurf([], 0).

computeSurf([_, H1, _, V1], Res):-
	Res #= H1 * V1.	

