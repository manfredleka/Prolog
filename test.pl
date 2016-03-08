%test

:- use_module(library(clpfd)).
:- dynamic space/15.

space(0, room , living , 4, _, 0, 0, 4, _, 0, 0, _, _, 33, 42).
space(1, room , living , 4, _, 0, 0, 4, _, 0, 0, _, _, 33, 42).

testCleanDB(-1).
testCleanDB(N):-
	N >= 0,
	space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf),
	((var(MaxH), var(MaxV), nonvar(MinSurf), nonvar(MaxSurf))	-> 
		MaxH is MaxSurf / MinV,
		MaxV is MaxSurf / MinH,
		retract(space(N, _, _, _, _, _, _, _, _, _, _, _, _, _, _)),
		asserta(space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf))
	),
	N1 is N-1,
	testCleanDB(N1).


testListe([A,B], C, D):-
	C = A,
	D = B.
