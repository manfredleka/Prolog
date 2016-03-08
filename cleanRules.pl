% clean the database facts, determines values for MaxH and MaxV based on MinSurf, MinV, MinH 
									% TEST OK
cleanDB(-1).
cleanDB(N):-
	N >= 0,
	space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf),
	((var(MaxH), var(MaxV), nonvar(MinSurf), nonvar(MaxSurf))	-> 
		MaxH is MaxSurf / MinV,
		MaxV is MaxSurf / MinH,
		retract(space(N, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
		asserta(space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf)
	),
	N1 is N-1,
	cleanDB(N1).