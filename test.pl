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

adj(living , [room1, room2]).
adj(toilet, shower).

essai([X]):-
	test([X]).

test([]).

test([X | Xs]):-
	test(Xs),
	writeln('queue non vide').