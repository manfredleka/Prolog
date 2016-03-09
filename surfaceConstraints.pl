% Surface constraints
% ensure the dimensions of each room respects its own surface constraint
% also ensures the sum of surfaces doesnt exceed the available surface in the room

postSurfaceConstraints(FloorSpaceVar, [], Sum):-
	getSurf(FloorSpaceVar, Surf),
	Sum #=< Surf.

postSurfaceConstraints(FloorSpaceVar, [SpaceVar | SpaceVarList], Sum):-
	(var(Sum) -> Sum #= 0),
	getCoordinates(SpaceVar, [Room1, Room2]),
	getSurf(SpaceVar, Surf),
	computeSurf(Room1, Res1),
	computeSurf(Room2, Res2),
	Surf #= Res1 + Res2,
	Sum1 #= Sum + Surf,
	postSurfaceConstraints(FloorSpaceVar, SpaceVarList, Sum1).

computeSurf([], 0).

computeSurf([_, H1, _, V1], Res):-
	Res #= H1 * V1.	

