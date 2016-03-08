%test

:- use_module(library(clpfd)).

test(Y):-
	Y in 0..4,
	Z in 2..2,
	X in 5..5,
	A = (Y#>Z),
	B = (Y#<X),
	call(A #/\ B).