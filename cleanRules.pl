% clean the database facts, determines values for MaxH and MaxV based on MinSurf, MinV, MinH 


cleanFact(N):-
	N >= 0,
	space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf),
	space(0, _, _, _, _, _, _, _, _, _, _, _, _, _, FloorMaxSurf),
	(var(MaxSurf) -> MaxSurf is FloorMaxSurf; MaxSurf is MaxSurf),
	(var(MaxH) -> MaxH is div(MaxSurf, MinV); MaxH is MaxH),
	(var(MaxV) -> MaxV is div(MaxSurf,MinH); MaxV is MaxV),
	retract(space(N, _, _, _, _, _, _, _, _, _, _, _, _, _, _)),
	asserta(space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf)).

cleanDB(-1).

cleanDB(IdMax):-
	IdMax >= 0,
	cleanFact(IdMax),
	Id1 is IdMax - 1,
	cleanDB(Id1).
