%test

:- use_module(library(clpfd)).
:- dynamic space/15.

space(0, room , living , 4, _, 0, 0, 4, _, 0, 0, _, _, 33, 42).
space(1, room , living , 4, _, 0, 0, 4, _, 0, 0, _, _, 33, 42).
contour(living , [so]).
contour(kitchen, [s,n]).
contour(room1 , [s,n]).
contour(room2 , [s,n]).
contour(room3 , [s,n]).
contour(room4 , [s]).

testContour(X,Z):-
	(contour(X,Z) -> writeln('azi')).



testCleanDB(-1).
testCleanDB(N):-
	N >= 0,
	space(N, Type, Name, MinH, MaxH, Minh, Maxh, MinV, MaxV, Minv, Maxv, _, _, MinSurf, MaxSurf),
	(var(MaxH)	-> 
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

azy(_):-
	write('aziiiiii').

groupeSpace(S):-
	setof((N, A, B, C, D, E, F, G, H, I, J, K, L, M, O), space(N=\=0,A,B,C,D,E,F,G,H,I,J,K,L,M,O), S).

groupContour(S):-
	findall(X, contour(X, _), S).