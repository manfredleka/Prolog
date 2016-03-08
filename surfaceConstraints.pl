% Surface constraints
% ensure the dimensions of each room respects the surface constraints

postSurfaceConstraints([]).

postSurfaceConstraints([SpaceVar | SpaceVarList]):-
	getCoordinates(SpaceVar, [Room1, Room2]),
	getSurf(SpaceVar, Surf),
	computeSurf(Room1, Res1),
	computeSurf(Room2, Res2),
	Surf #= Res1 + Res2,
	postSurfaceConstraints(SpaceVarList).

computeSurf([], 0).

computeSurf([_, H1, _, V1], Res):-
	Res #= H1 * V1.	

