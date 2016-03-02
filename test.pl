% test orthotopes
:-[diffn]

test(X1,Y1,X2,Y2):-
	orth1 =[[X1],[Y1],
	orth2 = [[X2], [Y2]],
	diffn(orth1, orth2).
