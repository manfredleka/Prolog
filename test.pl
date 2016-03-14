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


test([Element]):-
	writeln('queue vide').

test([Element| List]):-
	writeln('queue non vide'),
	test(List).
