% clean the database facts, determines values for MaxH and MaxV based on MinSurf, MinV, MinH 


cleanFact(N):-
	N >= 0,
	space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf),
	space(0, _, _, _, FloorMaxH, _, _, _, FloorMaxV, _, _, _, _, _, FloorMaxSurf),
	(var(MaxH) -> MaxH is FloorMaxH; MaxH is MaxH),
	(var(MaxV) -> MaxV is FloorMaxV; MaxV is MaxV),
	Maax is MaxH*MaxV,
	(var(MaxSurf) -> MaxSurf is Maax; MaxSurf is MaxSurf),
	retract(space(N, _, _, _, _, _, _, _, _, _, _, _, _, _, _)),
	asserta(space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf)).

cleanDB(-1).

cleanDB(IdMax):-
	IdMax >= 0,
	cleanFact(IdMax),
	Id1 is IdMax - 1,
	cleanDB(Id1).
