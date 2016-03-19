% general surface constraint

postGalSurfConstraint(SpaceVarList, FloorSpaceVar):-
	sumSurfaces(SpaceVarList, Sum),
	getCoordinates(FloorSpaceVar, [[_, FloorH, _, FloorV], []]),
	FloorH * FloorV #= Sum.


computeSurf([], 0).

computeSurf([_, H, _, V], X):-
	X #= H*V.

sumSurfaces([], 0).

sumSurfaces([SpaceVar | SpaceVarList], Sum):-
	sumSurfaces(SpaceVarList, Sum1),
	getCoordinates(SpaceVar, [Room1, Room2]),
	computeSurf(Room1, Res1),
	computeSurf(Room2, Res2),
	Sum #= Sum1 + Res1 + Res2.
