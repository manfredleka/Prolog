% NON OVERLAPPING CONSTRAINT

postNonOverlappingConstraints([]).

postNonOverlappingConstraints([SpaceVar | SpaceVarList]):-
	postNonOverlappingConstraints(SpaceVarList),
	postNonOverlappingConstraints(SpaceVar, SpaceVarList).

postNonOverlappingConstraints(_, []).

postNonOverlappingConstraints(SpaceVar, [SpaceVar2 | SpaceVarList]):-
	postNonOverlappingConstraints(SpaceVar, SpaceVarList),
	getCoordinates(SpaceVar, Room1Coord),
	getCoordinates(SpaceVar2, Room2Coord),
	nonOverlapping(Room1Coord, Room2Coord).


% For 1 not to overlap 2 (and vice versa) 1 must be at the left or the right or the top or the bottom of 2
nonOverlapping2([], _).
nonOverlapping2(_, []).

nonOverlapping2([X1,H1,Y1,V1], [X2,H2,Y2,V2]):-
	((X2 #>= X1 + H1) #\/ (X1 #>= X2 + H2) #\/ (Y2 #>= Y1 + V1) #\/ (Y1 #>= Y2 + V2)).


nonOverlapping([Room1, Room2], [Room3, Room4]):-
	nonOverlapping2(Room1, Room2),
	nonOverlapping2(Room1, Room3),
	nonOverlapping2(Room1, Room4),
	nonOverlapping2(Room2, Room3),
	nonOverlapping2(Room2, Room4),
	nonOverlapping2(Room3, Room4).
